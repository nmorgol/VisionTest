

import UIKit
import Speech
import AVKit
import Vision


class HyperopiaSpeechViewController: UIViewController, SFSpeechRecognizerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru_Ru"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    
    
    // AVCapture variables to hold sequence data
    var session: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var videoDataOutput: AVCaptureVideoDataOutput?
    var videoDataOutputQueue: DispatchQueue?
    
    var captureDevice: AVCaptureDevice?
    var captureDeviceResolution: CGSize = CGSize()
    
    // Layer UI for drawing Vision results
    var rootLayer: CALayer?
    var detectionOverlayLayer: CALayer?
    var detectedFaceRectangleShapeLayer: CAShapeLayer?
    var detectedFaceLandmarksShapeLayer: CAShapeLayer?
    
    // Vision requests
    private var detectionRequests: [VNDetectFaceRectanglesRequest]?
    private var trackingRequests: [VNTrackObjectRequest]?
    
    lazy var sequenceRequestHandler = VNSequenceRequestHandler()
    
    
    
    //let wordArray = ["Верх","Низ","Лево","Право"]
    var currentText = String()
    var speechBool = false
    var wordLabel = UILabel()
    var reciveTextLabel = UILabel()
    var authorizedLabel = UILabel()
    var fontSize = 17
    
    var inputText = String()
    
    var comletion: ((String)->())?
    
    let microphoneView = MicrophoneView()
    let circleView = CircleView()
    var animateCounter = Int(1)
    
    let phoneImageView = UIImageView()
    
    var distance = Float()
    var startBool = false//для анимации
    
    var timer: Timer!
    var timerCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hyperopia test speech"
        self.navigationItem.title = "Hyperopia test speech"
        self.view.backgroundColor = .white
        
        //        self.session = self.setupAVCaptureSession()
        //
        //        self.prepareVisionRequest()
        //
        //        self.session?.startRunning()
        //inputText = String(Int.random(in: 100...999))
        
        //        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        
        self.session = self.setupAVCaptureSession()
        
        self.prepareVisionRequest()
        
        self.session?.startRunning()
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        
        addWordLabel()
        addReciveTextLabel()
        addAuthorizedLabel()
        addMicrophonesView()
        //addPhoneImageView()
        //print(fontSize)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(false)
        
        
        animatedMicrophone()
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
        self.navigationController?.popViewController(animated: true)
        timer.invalidate()
        self.session?.stopRunning()
    }
    
    // MARK: Speech
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
                self.reciveTextLabel.text = result.bestTranscription.formattedString
                
                isFinal = result.isFinal
                
                self.currentText = result.bestTranscription.formattedString
                //                    print(self.currentText + "-" + self.wordLabel.text!)
                //                if Array(self.currentText).count >= Array(self.inputText).count{
                //                    if self.compareString(str1: self.currentText, str2: self.inputText) == true{
                //
                //                        self.inputText = String(Int.random(in: 100...999))
                //
                //                    }
                //                    //self.stopRecognition()
                //                }
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
            //        } else {
            //            do {
            //                try startRecording()
            //
            //            } catch {
            //            }
        }
    }
    
    @objc func stopRecognition(){
        
        let text = currentText 
        comletion?(text)
        navigationController?.popViewController(animated: false)
    }
    
    // MARK: Vision
    // Ensure that the interface stays locked in Portrait.
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // Ensure that the interface stays locked in Portrait.
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    // MARK: AVCapture Setup
    
    /// - Tag: CreateCaptureSession
    fileprivate func setupAVCaptureSession() -> AVCaptureSession? {
        let captureSession = AVCaptureSession()
        do {
            let inputDevice = try self.configureFrontCamera(for: captureSession)
            self.configureVideoDataOutput(for: inputDevice.device, resolution: inputDevice.resolution, captureSession: captureSession)
            self.designatePreviewLayer(for: captureSession)
            return captureSession
        } catch let executionError as NSError {
            self.presentError(executionError)
        } catch {
            self.presentErrorAlert(message: "An unexpected failure has occured")
        }
        
        self.teardownAVCapture()
        
        return nil
    }
    
    /// - Tag: ConfigureDeviceResolution
    fileprivate func highestResolution420Format(for device: AVCaptureDevice) -> (format: AVCaptureDevice.Format, resolution: CGSize)? {
        var highestResolutionFormat: AVCaptureDevice.Format? = nil
        var highestResolutionDimensions = CMVideoDimensions(width: 0, height: 0)
        
        for format in device.formats {
            let deviceFormat = format as AVCaptureDevice.Format
            
            let deviceFormatDescription = deviceFormat.formatDescription
            if CMFormatDescriptionGetMediaSubType(deviceFormatDescription) == kCVPixelFormatType_420YpCbCr8BiPlanarFullRange {
                let candidateDimensions = CMVideoFormatDescriptionGetDimensions(deviceFormatDescription)
                if (highestResolutionFormat == nil) || (candidateDimensions.width > highestResolutionDimensions.width) {
                    highestResolutionFormat = deviceFormat
                    highestResolutionDimensions = candidateDimensions
                }
            }
        }
        
        if highestResolutionFormat != nil {
            let resolution = CGSize(width: CGFloat(highestResolutionDimensions.width), height: CGFloat(highestResolutionDimensions.height))
            return (highestResolutionFormat!, resolution)
        }
        
        return nil
    }
    
    fileprivate func configureFrontCamera(for captureSession: AVCaptureSession) throws -> (device: AVCaptureDevice, resolution: CGSize) {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front)
        
        if let device = deviceDiscoverySession.devices.first {
            if let deviceInput = try? AVCaptureDeviceInput(device: device) {
                if captureSession.canAddInput(deviceInput) {
                    captureSession.addInput(deviceInput)
                }
                
                if let highestResolution = self.highestResolution420Format(for: device) {
                    try device.lockForConfiguration()
                    device.activeFormat = highestResolution.format
                    device.unlockForConfiguration()
                    
                    return (device, highestResolution.resolution)
                }
            }
        }
        
        throw NSError(domain: "ViewController", code: 1, userInfo: nil)
    }
    
    /// - Tag: CreateSerialDispatchQueue
    fileprivate func configureVideoDataOutput(for inputDevice: AVCaptureDevice, resolution: CGSize, captureSession: AVCaptureSession) {
        
        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        
        // Create a serial dispatch queue used for the sample buffer delegate as well as when a still image is captured.
        // A serial dispatch queue must be used to guarantee that video frames will be delivered in order.
        let videoDataOutputQueue = DispatchQueue(label: "com.example.apple-samplecode.VisionFaceTrack")
        videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        
        if captureSession.canAddOutput(videoDataOutput) {
            captureSession.addOutput(videoDataOutput)
        }
        
        videoDataOutput.connection(with: .video)?.isEnabled = true
        
        if let captureConnection = videoDataOutput.connection(with: AVMediaType.video) {
            if captureConnection.isCameraIntrinsicMatrixDeliverySupported {
                captureConnection.isCameraIntrinsicMatrixDeliveryEnabled = true
            }
        }
        
        self.videoDataOutput = videoDataOutput
        self.videoDataOutputQueue = videoDataOutputQueue
        
        self.captureDevice = inputDevice
        self.captureDeviceResolution = resolution
    }
    
    /// - Tag: DesignatePreviewLayer
    fileprivate func designatePreviewLayer(for captureSession: AVCaptureSession) {
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer = videoPreviewLayer
        
        videoPreviewLayer.name = "CameraPreview"
        videoPreviewLayer.backgroundColor = UIColor.black.cgColor
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        if let previewRootLayer = self.view?.layer {
            self.rootLayer = previewRootLayer
            
            previewRootLayer.masksToBounds = true
            videoPreviewLayer.frame = previewRootLayer.bounds
        }
    }
    
    // Removes infrastructure for AVCapture as part of cleanup.
    fileprivate func teardownAVCapture() {
        self.videoDataOutput = nil
        self.videoDataOutputQueue = nil
        
        if let previewLayer = self.previewLayer {
            previewLayer.removeFromSuperlayer()
            self.previewLayer = nil
        }
    }
    
    // MARK: Helper Methods for Error Presentation
    
    fileprivate func presentErrorAlert(withTitle title: String = "Unexpected Failure", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true)
    }
    
    fileprivate func presentError(_ error: NSError) {
        self.presentErrorAlert(withTitle: "Failed with error \(error.code)", message: error.localizedDescription)
    }
    
    // MARK: Helper Methods for Handling Device Orientation & EXIF
    
    fileprivate func radiansForDegrees(_ degrees: CGFloat) -> CGFloat {
        return CGFloat(Double(degrees) * Double.pi / 180.0)
    }
    
    func exifOrientationForDeviceOrientation(_ deviceOrientation: UIDeviceOrientation) -> CGImagePropertyOrientation {
        
        switch deviceOrientation {
        case .portraitUpsideDown:
            return .rightMirrored
            
        case .landscapeLeft:
            return .downMirrored
            
        case .landscapeRight:
            return .upMirrored
            
        default:
            return .leftMirrored
        }
    }
    
    func exifOrientationForCurrentDeviceOrientation() -> CGImagePropertyOrientation {
        return exifOrientationForDeviceOrientation(UIDevice.current.orientation)
    }
    
    // MARK: Performing Vision Requests
    
    /// - Tag: WriteCompletionHandler
    fileprivate func prepareVisionRequest() {
        
        //self.trackingRequests = []
        var requests = [VNTrackObjectRequest]()
        
        let faceDetectionRequest = VNDetectFaceRectanglesRequest(completionHandler: { (request, error) in
            
            if error != nil {
                print("FaceDetection error: \(String(describing: error)).")
            }
            
            guard let faceDetectionRequest = request as? VNDetectFaceRectanglesRequest,
                let results = faceDetectionRequest.results as? [VNFaceObservation] else {
                    return
            }
            DispatchQueue.main.async {
                // Add the observations to the tracking list
                for observation in results {
                    let faceTrackingRequest = VNTrackObjectRequest(detectedObjectObservation: observation)
                    requests.append(faceTrackingRequest)
                }
                self.trackingRequests = requests
            }
        })
        
        // Start with detection.  Find face, then track it.
        self.detectionRequests = [faceDetectionRequest]
        
        self.sequenceRequestHandler = VNSequenceRequestHandler()
        
    }
    
    
    /// - Tag: PerformRequests
    // Handle delegate method callback on receiving a sample buffer.
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        var requestHandlerOptions: [VNImageOption: AnyObject] = [:]
        
        let cameraIntrinsicData = CMGetAttachment(sampleBuffer, key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, attachmentModeOut: nil)
        if cameraIntrinsicData != nil {
            requestHandlerOptions[VNImageOption.cameraIntrinsics] = cameraIntrinsicData
        }
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            print("Failed to obtain a CVPixelBuffer for the current output frame.")
            return
        }
        
        let exifOrientation = self.exifOrientationForCurrentDeviceOrientation()
        
        guard let requests = self.trackingRequests, !requests.isEmpty else {
            // No tracking object detected, so perform initial detection
            let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                                            orientation: exifOrientation,
                                                            options: requestHandlerOptions)
            
            do {
                guard let detectRequests = self.detectionRequests else {
                    return
                }
                try imageRequestHandler.perform(detectRequests)
            } catch let error as NSError {
                NSLog("Failed to perform FaceRectangleRequest: %@", error)
            }
            return
        }
        
        do {
            try self.sequenceRequestHandler.perform(requests,
                                                    on: pixelBuffer,
                                                    orientation: exifOrientation)
        } catch let error as NSError {
            NSLog("Failed to perform SequenceRequest: %@", error)
        }
        
        // Setup the next round of tracking.
        var newTrackingRequests = [VNTrackObjectRequest]()
        for trackingRequest in requests {
            
            guard let results = trackingRequest.results else {
                return
            }
            
            guard let observation = results[0] as? VNDetectedObjectObservation else {
                return
            }
            
            if !trackingRequest.isLastFrame {
                if observation.confidence > 0.3 {
                    trackingRequest.inputObservation = observation
                } else {
                    trackingRequest.isLastFrame = true
                }
                newTrackingRequests.append(trackingRequest)
            }
        }
        self.trackingRequests = newTrackingRequests
        
        if newTrackingRequests.isEmpty {
            // Nothing to track, so abort.
            return
        }
        
        // Perform face landmark tracking on detected faces.
        var faceLandmarkRequests = [VNDetectFaceLandmarksRequest]()
        
        // Perform landmark detection on tracked faces.
        for trackingRequest in newTrackingRequests {
            
            let faceLandmarksRequest = VNDetectFaceLandmarksRequest(completionHandler: { (request, error) in
                
                if error != nil {
                    print("FaceLandmarks error: \(String(describing: error)).")
                }
                
                guard let landmarksRequest = request as? VNDetectFaceLandmarksRequest,
                    let results = landmarksRequest.results as? [VNFaceObservation] else {
                        return
                }
                
                
                // MARK: Perform all UI updates (drawing) on the main queue, not the background queue on which this handler is being called.
                DispatchQueue.main.async {
                    //                    self.drawFaceObservations(results)
                    let deviceCoef = UIDevice.deviceСoefficient
                    
                    
                    let left = results.first?.landmarks?.leftPupil?.pointsInImage(imageSize: self.view.frame.size).first?.x
                    let righ = results.first?.landmarks?.rightPupil?.pointsInImage(imageSize: self.view.frame.size).first?.x
                    let rez = (Float(righ!) - Float(left!))*deviceCoef
                    
                    //let dist = self.converPointToDistance(points: rez)
                    // self.label.text = "\(dist)"+"см."
                    self.distance = Float(self.converPointToDistance(points: rez))
                    //                    print(self.distance)
                    if rez > 140 && self.startBool == false{
                        print(self.startBool)
                        self.animatedPhoneNear()
                    }else if rez < 50 && self.startBool == false{
                        self.animatedPhoneFar()
                    }
                }
            })
            
            guard let trackingResults = trackingRequest.results else {
                return
            }
            
            guard let observation = trackingResults[0] as? VNDetectedObjectObservation else {
                return
            }
            let faceObservation = VNFaceObservation(boundingBox: observation.boundingBox)
            faceLandmarksRequest.inputFaceObservations = [faceObservation]
            
            // Continue to track detected facial landmarks.
            faceLandmarkRequests.append(faceLandmarksRequest)
            
            let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                                            orientation: exifOrientation,
                                                            options: requestHandlerOptions)
            
            do {
                try imageRequestHandler.perform(faceLandmarkRequests)
            } catch let error as NSError {
                NSLog("Failed to perform FaceLandmarkRequest: %@", error)
            }
        }
    }
    
    func converPointToDistance(points: Float ) -> Int {
        var distance = Int()
        if (points >= 115)&&(points <= 140){
            distance = 20
        }else if (points>100)&&(points<115){
            distance = 25
        }else if (points<=100)&&(points>=85){
            distance = 30
        }else if (points<85)&&(points>80){
            distance = 35
        }else if (points<=80)&&(points>=75){
            distance = 40
        }else if (points>65)&&(points<75){
            distance = 45
        }else if (points>=50)&&(points<=65){
            distance = 50
        }
        return distance
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
        wordLabel.font = .boldSystemFont(ofSize: CGFloat(fontSize))
        wordLabel.numberOfLines = 0
        
        //        wordLabel.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
    }
    
    func addReciveTextLabel() {
        view.addSubview(reciveTextLabel)
        reciveTextLabel.translatesAutoresizingMaskIntoConstraints = false
        reciveTextLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 5).isActive = true
        reciveTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reciveTextLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        reciveTextLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/15).isActive = true
        
        //reciveTextLabel.text = inputText
        reciveTextLabel.textAlignment = .center
        reciveTextLabel.font = .boldSystemFont(ofSize: CGFloat(fontSize))
        reciveTextLabel.numberOfLines = 0
        reciveTextLabel.backgroundColor = .lightGray
        
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
    
    @objc func animatedPhoneFar(){
        self.addPhoneImageView()
        UIImageView.animate(withDuration: 1, animations: {
            
            self.phoneImageView.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        }) { (_) in
            
            UIImageView.animate(withDuration: 1, animations: {
                
                self.phoneImageView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            }) { (_) in
                self.phoneImageView.removeFromSuperview()
            }
        }
    }
    
    @objc func animatedPhoneNear(){
        startBool = true
        print(startBool)
        self.addPhoneImageView()
        UIImageView.animate(withDuration: 3, animations: {
            
            self.phoneImageView.transform = CGAffineTransform.init(scaleX: -0.5, y: -0.5)
        }) { (_) in
            
            //            UIImageView.animate(withDuration: 1, animations: {
            //
            //                self.phoneImageView.transform = CGAffineTransform.init(scaleX: 2, y: 2)
            //            }) { (_) in
            self.phoneImageView.removeFromSuperview()
            self.startBool = false
            // }
        }
    }
    
    func compareString(str1: String, str2: String) -> Bool {
        var boolCompare = false
        let second1 = Array(str1)
        let second2 = Array(str2)
        
        if second2.count == 0 {//пришел как-то 0 и краш
            boolCompare = false
        }else{
            for i in 0...second2.count-1{
                if (second2[i]==second1[0]) && ((second2.count-i) >= (second1.count)){
                    for j in 0...second1.count-1{
                        if second2[i+j] == second1[j]{
                            boolCompare = true
                        }else{
                            boolCompare = false
                        }
                    }
                }
            }
        }
        return boolCompare
    }
    
    @objc func timerAction() {
        
        if timerCounter == 0 || timerCounter%10 == 0{
            inputText = String(Int.random(in: 100...999))
            print(inputText)
            
            wordLabel.text = inputText
            
            if audioEngine.isRunning {
                audioEngine.stop()
                recognitionRequest?.endAudio()
                audioEngine.inputNode.removeTap(onBus: 0)//надо с этой строкой еще подумать
            }else{
                do {
                    try startRecording()
                } catch {
                    
                }
            }
            
        }else if ((timerCounter + 1)%10 == 0)  {
            
            if audioEngine.isRunning {
                audioEngine.stop()
                recognitionRequest?.endAudio()
                audioEngine.inputNode.removeTap(onBus: 0)//надо с этой строкой еще подумать
            }else{
                do {
                    try startRecording()
                } catch {
                    
                }
            }
            if reciveTextLabel.text != nil{
                if compareString(str1: inputText, str2: reciveTextLabel.text!) == true{
                    fontSize -= 1
                    print("огонь")
                }
            }
            recognitionTask?.cancel()
            self.recognitionTask = nil
            reciveTextLabel.text = ""
        }
        timerCounter += 1
    }
    
}

