

import UIKit
import Speech
import AVKit
import Vision
import CoreData


class HyperopiaSpeechViewController: UIViewController, SFSpeechRecognizerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru_Ru"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    
    
    var currentText = String()
    
    var wordLabel = UILabel()
    var reciveTextLabel = UILabel()
    var authorizedLabel = UILabel()
    var eyeLabel = UILabel()
    
    var startFontCounter = 1//счетчик уменьшения размера шрифта
    var fontSize = Float(40)//методом подбора = острота зрения 0.1
    
    var inputText = String()
    
    var comletion: ((String)->())?//вроде как можно удалить уже
    
    let microphoneView = MicrophoneView()
    let circleView = CircleView()
    var animateCounter = Int(1)
    
    let phoneImageView = UIImageView()
    let progress = UIProgressView()
    
    var distance = Float()
    var startBool = false//для анимации
    
    var timer: Timer!
    var timerCounter = 0
    var stopBool = true // для работы таймера от слова СТОП
    let stopLabel = UILabel()//всплывает по слову СТОП
    
    var rightRes = Float()
    var leftRes = Float()
    
    var disapearTrue = true //подпорка для того чтобы не отрабатывал метод self.navigationController?.popViewController(animated:false
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hyperopia test speech"
        self.navigationItem.title = "Hyperopia test speech"
        self.view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        
        disapearTrue = true
        
        startFontCounter = 1
        
        //self.session?.startRunning()
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        addEyeLabel(text: "Закройте левый глаз")
        animatedEyeLabel()
        
        addWordLabel()
        addProgressView()
        addReciveTextLabel()
        addAuthorizedLabel()
        addMicrophonesView()
    }
    
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(false)
        
        
        //animatedMicrophone()
        speechRecognizer.delegate = self
        
        // Asynchronously make the authorization request.
        SFSpeechRecognizer.requestAuthorization { authStatus in
            
            // Divert to the app's main thread so that the UI
            // can be updated.
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.authorizedLabel.text = "authorized"
                    
                case .denied:
                    self.authorizedLabel.text = "denied"
                    
                case .restricted:
                    self.authorizedLabel.text = "restricted"
                    
                case .notDetermined:
                    self.authorizedLabel.text = "notDetermined"
                default:
                    self.authorizedLabel.text = "denied"
                }
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(true)
        if disapearTrue {
            self.navigationController?.popViewController(animated: false)
        }
        timer.invalidate()
        
        //self.session?.stopRunning()
        
        self.navigationController?.navigationBar.isHidden = false
        
        DispatchQueue.global(qos: .userInteractive).async {
            [unowned self] in
            if self.audioEngine.isRunning {
                self.audioEngine.stop()
                self.recognitionRequest?.endAudio()
                self.audioEngine.inputNode.removeTap(onBus: 0)//надо с этой строкой еще подумать
                self.recognitionTask?.cancel()
                self.recognitionTask = nil 
            }else{
                do {
                    try self.startRecording()
                } catch {
                    
                }
            }
        }
        
    }
    
    // MARK: Speech
    private func startRecording() throws {
        
        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.playAndRecord, mode: .voiceChat, options: .allowBluetooth)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        
        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        
        // Keep speech recognition data on device
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = false
        }
        
        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            
            if let result = result {
                // Update the text view with the results.
                //                self.textView.text = result.bestTranscription.formattedString
                self.reciveTextLabel.text = result.bestTranscription.formattedString
                
                isFinal = result.isFinal
                
                self.currentText = result.bestTranscription.formattedString
                
            }
            
            if error != nil || isFinal {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
            }
        }
        
        // Configure the microphone input.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
            
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
    }
    
    // MARK: SFSpeechRecognizerDelegate
    
    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            print("available")
        } else {
            print(" not available")
        }
    }
    
    @objc func recordButtonTapped() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            audioEngine.inputNode.removeTap(onBus: 0)//надо с этой строкой еще подумать
            
            do {
                try startRecording()
                
            } catch {
            }
            
        }
    }
    

    

    
    // MARK: View
    func addWordLabel() {
        view.addSubview(wordLabel)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        wordLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/15).isActive = true
        
        wordLabel.text = inputText
        wordLabel.textAlignment = .center
        //wordLabel.font = .boldSystemFont(ofSize: CGFloat(fontSize))
        wordLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(fontSize))
        wordLabel.numberOfLines = 0
        
    }
    
    func addProgressView() {
        view.addSubview(progress)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.topAnchor.constraint(equalTo: wordLabel.bottomAnchor).isActive = true
        progress.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        progress.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progress.progressViewStyle = .default
        
    }
    
    func addReciveTextLabel() {
        view.addSubview(reciveTextLabel)
        reciveTextLabel.translatesAutoresizingMaskIntoConstraints = false
        reciveTextLabel.topAnchor.constraint(equalTo: progress.bottomAnchor, constant: 5).isActive = true
        reciveTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reciveTextLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        reciveTextLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/15).isActive = true
        
        //reciveTextLabel.text = inputText
        reciveTextLabel.textAlignment = .center
        reciveTextLabel.font = .boldSystemFont(ofSize: CGFloat(40))
        reciveTextLabel.numberOfLines = 0
        reciveTextLabel.backgroundColor = .lightGray
        
        //        wordLabel.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
    }
    
    func addEyeLabel(text: String){
        view.addSubview(eyeLabel)
        eyeLabel.translatesAutoresizingMaskIntoConstraints = false
        eyeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        eyeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //eyeLabel.centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor).isActive = true
        eyeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        eyeLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
        eyeLabel.font = .boldSystemFont(ofSize: 30)
        eyeLabel.text = text//"Закройте левый глаз"
        eyeLabel.textColor = .blue
        eyeLabel.textAlignment = .center
        eyeLabel.numberOfLines = 0
    }
    
    func addAuthorizedLabel() {
        view.addSubview(authorizedLabel)
        authorizedLabel.translatesAutoresizingMaskIntoConstraints = false
        authorizedLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        authorizedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        authorizedLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        authorizedLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/20).isActive = true
        
        authorizedLabel.textAlignment = .center
        
    }
    
    func addMicrophonesView(){
        
        self.view.addSubview(circleView)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.bottomAnchor.constraint(equalTo: self.authorizedLabel.topAnchor, constant: -50).isActive = true
        circleView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5).isActive = true
        circleView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5).isActive = true
        circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circleView.backgroundColor = .clear
        
        circleView.addSubview(microphoneView)
        microphoneView.translatesAutoresizingMaskIntoConstraints = false
        microphoneView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        microphoneView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        microphoneView.widthAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: 3/4).isActive = true
        microphoneView.heightAnchor.constraint(equalTo: circleView.heightAnchor, multiplier: 3/4).isActive = true
        microphoneView.backgroundColor = .clear
        
    }
    
    func addPhoneImageView(){
        
        self.view.addSubview(phoneImageView)
        phoneImageView.translatesAutoresizingMaskIntoConstraints = false
        phoneImageView.bottomAnchor.constraint(equalTo: self.wordLabel.topAnchor, constant: -100).isActive = true
        phoneImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5).isActive = true
        phoneImageView.heightAnchor.constraint(equalTo: phoneImageView.widthAnchor, multiplier: 2).isActive = true
        phoneImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        phoneImageView.backgroundColor = .clear
        phoneImageView.image = UIImage(named: "phoneImage")
    }
    
    func addStopLabel(){
        self.view.addSubview(stopLabel)
        stopLabel.translatesAutoresizingMaskIntoConstraints = false
        stopLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stopLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stopLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        stopLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        
        stopLabel.backgroundColor = .white
        stopLabel.text = "стоп стоп стоп"
        stopLabel.textAlignment = .center
        
        
        stopLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(stopLabelGestureAction))
        stopLabel.addGestureRecognizer(tap)
       
    }
    
    @objc func animatedMicrophone() {
        CircleView.animate(withDuration: 0.15/Double(animateCounter), animations: {
            
            self.circleView.transform = CGAffineTransform.init(translationX: 0, y: -30)
        }) { (_) in
            
            CircleView.animate(withDuration: 0.15, animations: {
                self.circleView.transform = CGAffineTransform.init(translationX: 0, y: 30)
            }) { (_) in
                CircleView.animate(withDuration: 0.10, animations: {
                    self.circleView.transform = CGAffineTransform.init(translationX: 0, y: -15)
                }) { (_) in
                    CircleView.animate(withDuration: 0.05, animations: {
                        self.circleView.transform = CGAffineTransform.init(translationX: 0, y: 7.5)
                    }) { (_) in
                        CircleView.animate(withDuration: 0.05) {
                            self.circleView.transform = CGAffineTransform.init(translationX: 0, y: -7.5)
                        }
                    }
                }
            }
        }
    }
    

    
    @objc func animatedEyeLabel() {
        UILabel.animate(withDuration: 0.15/Double(animateCounter), animations: {
            
            self.eyeLabel.transform = CGAffineTransform.init(translationX: 0, y: -30)
        }) { (_) in
            
            UILabel.animate(withDuration: 0.15, animations: {
                self.eyeLabel.transform = CGAffineTransform.init(translationX: 0, y: 30)
            }) { (_) in
                UILabel.animate(withDuration: 0.10, animations: {
                    self.eyeLabel.transform = CGAffineTransform.init(translationX: 0, y: -15)
                }) { (_) in
                    UILabel.animate(withDuration: 0.05, animations: {
                        self.eyeLabel.transform = CGAffineTransform.init(translationX: 0, y: 7.5)
                    }) { (_) in
                        UILabel.animate(withDuration: 0.05, animations: {
                            self.eyeLabel.transform = CGAffineTransform.init(translationX: 0, y: -7.5)
                        }) { (_) in
                            self.stopBool = false
                        }
                    }
                }
            }
        }
    }
    
    func compareString(str1: String, str2: String) -> Bool {
        var boolCompare = false
        //let second1 = Array(str1)
        let second2 = Array(str2)
        
        if second2.count == 0 {//пришел как-то 0 и краш
            boolCompare = false
        }else{
            if str2.contains(str1){
                boolCompare = true
            }
        }
        return boolCompare
    }
    
    func compareStop(str2: String) {
        
        if (str2.lowercased()).contains("стоп"){

            stopBool = true
            saveResult()
            
            addStopLabel()

            recognitionRequest = nil
            reciveTextLabel.text = " "

            if eyeLabel.text == "Закройте правый глаз"{
                eyeLabel.text = "Закройте левый глаз"
            }else if eyeLabel.text == "Закройте левый глаз"{
                eyeLabel.text = "Закройте правый глаз"
            }
            
            
        }
        
    }
    
    @objc func timerAction() {
        if stopBool == false {
            
            progress.setProgress(0.1*Float(Int(timerCounter)%10) + 0.1, animated: false)
            if timerCounter == 0 || timerCounter%10 == 0{
                
                inputText = String(Int.random(in: 100...999))
                print(inputText)
                reciveTextLabel.text = ""
                wordLabel.text = inputText
                print(audioEngine.isRunning)
                if audioEngine.isRunning {
                    audioEngine.stop()
                    recognitionRequest?.endAudio()
                    audioEngine.inputNode.removeTap(onBus: 0)//надо с этой строкой еще подумать
                }else{
                    do {
                        try startRecording()
                        animatedMicrophone()
                    } catch {
                    }
                }
            }else if ((timerCounter + 1)%10 == 0)  {
                
                DispatchQueue.main.async {
                    [unowned self] in
                    if self.audioEngine.isRunning {
                        self.audioEngine.stop()
                        self.recognitionRequest?.endAudio()
                        self.audioEngine.inputNode.removeTap(onBus: 0)//надо с этой строкой еще подумать
                    }else{
                        do {
                            try self.startRecording()
                        } catch {
                        }
                    }
                }
                if reciveTextLabel.text != nil{
                    if compareString(str1: inputText, str2: reciveTextLabel.text!){
                        
                        startFontCounter += 1
                        fontSize = Float(40/startFontCounter)
                        
                    }
                    compareStop(str2: reciveTextLabel.text!)
                    if stopBool == true{
                        startFontCounter = 1
                        fontSize = Float(40/startFontCounter)
                    }
                }
                DispatchQueue.global(qos: .userInteractive).async {
                    [unowned self] in
                    self.recognitionTask?.cancel()
                    self.recognitionTask = nil
                }
                reciveTextLabel.text = ""
                inputText = ""
            }
            timerCounter += 1
        }
    }
    
    func saveResult(){
        
        do{
            let resultUser = try context.fetch(User.fetchRequest())
            let resCurrentUser = try context.fetch(CurrentUser.fetchRequest())
            if resCurrentUser.count > 0{
                let curUserNum = (resCurrentUser.last as! CurrentUser).currentUser
                let curUser = (resultUser[Int(curUserNum)] as! User)
                let result = HyperopiaTestResult(context: context)
//                print("результат", ((startFontCounter-1)/10))
                result.result = ((Float(startFontCounter)-1.0)/10.0)
                result.dateTest = Date()
                if eyeLabel.text == "Закройте правый глаз"{
                    result.testingEye = "Левый глаз"
                }else if eyeLabel.text == "Закройте левый глаз"{
                    result.testingEye = "Правый глаз"
                }
                
                curUser.addToRelationship1(result)
                
                try context.save()
                print(result)
            }
            
        }catch let error as NSError {
            print(error)
        }
    }
    
    @objc func stopLabelGestureAction() {
        stopLabel.removeFromSuperview()
        //stopBool = false
        startFontCounter = 1
        animatedEyeLabel()
    }
    
    
    
    
    
    
    
    
    private func disableAVSession() {
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't disable.")
        }
    }
}
// MARK: Сравнение на близком расстояниии
//    func converPointToDistance(points: Float ) -> Int {
//        var distance = Int()
//        if (points >= 115)&&(points <= 140){
//            distance = 20
//        }else if (points>100)&&(points<115){
//            distance = 25
//        }else if (points<=100)&&(points>=85){
//            distance = 30
//        }else if (points<85)&&(points>80){
//            distance = 35
//        }else if (points<=80)&&(points>=75){
//            distance = 40
//        }else if (points>65)&&(points<75){
//            distance = 45
//        }else if (points>=50)&&(points<=65){
//            distance = 50
//        }
//        return distance
//    }
    
    
