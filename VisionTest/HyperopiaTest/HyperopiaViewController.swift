

import UIKit
import Speech
import CoreData

class HyperopiaViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru_Ru"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    
    let wordArray = ["Верх","Низ","Лево","Право"]
    var currentText = String()
    var speechBool = false
    var wordLabel = UILabel()
    var fontSize = Float()
    var comlition: ((String)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let resultSettings = try context.fetch(SettingsApp.fetchRequest())
            
            if resultSettings.count > 0 {
                speechBool = (resultSettings.last as! SettingsApp).speechRecognize
            }
        } catch let error as NSError {
            print(error)
        }
        
        self.title = "Hyperopia test"
        self.navigationItem.title = "Hyperopia test"
        self.view.backgroundColor = .white
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Results", style: .plain, target: self, action: #selector(actionResults))
        fontSize = 17
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        addWordLabel()
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
                    //                    self.recordButton.isEnabled = true
                    print("authorized")
                    
                case .denied:
                    //                    self.recordButton.isEnabled = false
                    //                    self.recordButton.setTitle("User denied access to speech recognition", for: .disabled)
                    print("authorized")
                case .restricted:
                    //                    self.recordButton.isEnabled = false
                    //                    self.recordButton.setTitle("Speech recognition restricted on this device", for: .disabled)
                    print("authorized")
                case .notDetermined:
                    //                    self.recordButton.isEnabled = false
                    //                    self.recordButton.setTitle("Speech recognition not yet authorized", for: .disabled)
                    print("authorized")
                default:
                    //                    self.recordButton.isEnabled = false
                    print("authorized")
                }
            }
        }
        recordButtonTapped()
    }
    
    @objc func actionResults() {
        let resultVC = ResultsTableViewController()
        resultVC.title = "Hyperopia test results"
        self.navigationController?.pushViewController(resultVC, animated: true)
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
//                print("\(result.bestTranscription.formattedString)")
//                let printArray = result.transcriptions
//                print(result.transcriptions.count)
//                for i in printArray{
//                    print("\(i.formattedString)")
//                }
                
                
                self.currentText = result.bestTranscription.formattedString
                print(self.currentText + "-" + self.wordLabel.text!)
                
                self.stopRecognition()
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
        let labelText = wordLabel.text ?? ""
        let compare = compareString(str1: labelText, str2: currentText)
        if compare == true {
            
            print("ok")
            fontSize -= 1
            wordLabel.text = wordArray.randomElement()
            wordLabel.font = .boldSystemFont(ofSize: CGFloat(fontSize))
            
        }else{
             print("not ok")
            fontSize += 1
            wordLabel.text = wordArray.randomElement()
            wordLabel.font = .boldSystemFont(ofSize: CGFloat(fontSize))
        }
    }
    
    func addWordLabel() {
        view.addSubview(wordLabel)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        wordLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/20).isActive = true
        
        wordLabel.text = wordArray.randomElement()
        wordLabel.textAlignment = .center
        wordLabel.font = .boldSystemFont(ofSize: CGFloat(fontSize))
        
        wordLabel.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
    }
    
    func compareString(str1: String, str2: String) -> Bool {
        var boolCompare = false
        var second1 = Array(str1)
        second1.removeLast()
        let second2 = Array(str2)
        for i in 0...second2.count-1{
            if second2[i]==second1[0]{
                for j in 0...second1.count-1{
                    if second2[i+j] == second1[j]{
                        boolCompare = true
                    }
                }
            }
            return boolCompare
        }
        
        
//        second1.removeFirst()
//        second2.removeFirst()
//
//        if (str1.first == str2.first) && (second1.first == second2.first){
//            boolCompare = true
//        }
        return boolCompare
    }
    
    func startStopSpechRecogn() {
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "text" {
            //print("все пропало")
            //recordButtonTapped()
        }
    }
}
