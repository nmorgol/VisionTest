

import UIKit
import Speech

class HyperopiaSpeechViewController: UIViewController, SFSpeechRecognizerDelegate {

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru_Ru"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    
    //let wordArray = ["Верх","Низ","Лево","Право"]
    var currentText = String()
    var speechBool = false
    var wordLabel = UILabel()
    var authorizedLabel = UILabel()
    var fontSize = Float()
    
    var inputText = String()
    
    var comletion: ((String)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hyperopia test speech"
        self.navigationItem.title = "Hyperopia test speech"
        self.view.backgroundColor = .white
//        fontSize = 17
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        addWordLabel()
        addAuthorizedLabel()
        print(fontSize)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(false)
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
        recordButtonTapped()
    }
    
        private func startRecording() throws {
            
            // Cancel the previous task if it's running.
            recognitionTask?.cancel()
            self.recognitionTask = nil
            
            // Configure the audio session for the app.
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
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
                    isFinal = result.isFinal
    
                    self.currentText = result.bestTranscription.formattedString
//                    print(self.currentText + "-" + self.wordLabel.text!)
                    if Array(self.currentText).count >= Array(self.inputText).count{
                        self.stopRecognition()
                    }
                    
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
    
    func recordButtonTapped() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            audioEngine.inputNode.removeTap(onBus: 0)//надо с этой строкой еще подумать
        } else {
            do {
                try startRecording()
                
            } catch {
            }
            //
        }
    }
    
    func stopRecognition(){
//        let labelText = wordLabel.text ?? ""
//        let compare = compareString(str1: labelText, str2: currentText)
//        if compare == true {
//
//            print("ok")
//            fontSize -= 1
//            wordLabel.text = wordArray.randomElement()
//            wordLabel.font = .boldSystemFont(ofSize: CGFloat(fontSize))
//
//        }else{
//             print("not ok")
//            fontSize += 1
//            wordLabel.text = wordArray.randomElement()
//            wordLabel.font = .boldSystemFont(ofSize: CGFloat(fontSize))
//        }
        let text = currentText 
        comletion?(text)
        navigationController?.popViewController(animated: false)
    }
    
//    func compareString(str1: String, str2: String) -> Bool {
//        var boolCompare = false
//        let second1 = Array(str1)
//        let second2 = Array(str2)
//        for i in 0...second2.count-1{
//            if (second2[i]==second1[0]) && ((second2.count-i) >= (second1.count)){
//                for j in 0...second1.count-1{
//                    if second2[i+j] == second1[j]{
//                        boolCompare = true
//                    }else{
//                        boolCompare = false
//                    }
//                }
//            }
//        }
//        return boolCompare
//    }
    
    
    func addWordLabel() {
        view.addSubview(wordLabel)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        wordLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5).isActive = true
        
        wordLabel.text = inputText
        wordLabel.textAlignment = .center
        wordLabel.font = .boldSystemFont(ofSize: CGFloat(fontSize))
        wordLabel.numberOfLines = 0
        
//        wordLabel.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
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
    
    
}
