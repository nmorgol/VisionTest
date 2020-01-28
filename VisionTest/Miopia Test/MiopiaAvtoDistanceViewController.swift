

import UIKit
import Speech
import AVKit
import Vision

class MiopiaAvtoDistanceViewController: UIViewController, SFSpeechRecognizerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, AVSpeechSynthesizerDelegate {

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
    
    
    
    let distLabel = UILabel()//временный ярлык - потом удалить
    
    var disapearTrue = true //подпорка для того чтобы не отрабатывал метод self.navigationController?.popViewController(animated:false)
    var distanceBool = false
    
    let startLabel = UILabel()
    let helpSymbolView = UIView()//для символа
    let helpWorkView = UIView()//для кнопок
    
    var distance = Float(0.5)//расстояние для первого запуска
    
    let rightSnellenView = SnellenRightView()
    let leftSnellenView = SnellenLeftView()
    let topSnellenView = SnellenTopView()
    let bottomSnellenView = SnellenBottomView()
    
    let rightLandoltView = LandoltRightUIView()
    let leftLandoltView = LandoltLeftUIView()
    let topLandoltView = LandoltTopUIView()
    let bottomLandoltView = LandoltBottomUIView()
    
    let topButton = UIButton()
    let bottomButton = UIButton()
    let rightButton = UIButton()
    let leftButton = UIButton()
    let centralButton = UIButton()
    
    var viewArray = [UIView]()
    var workViewArray = [UIView]()
    var currentView = UIView()
    
    var koef = Float()//коэфициент рассчета размера символа
    var counter = Float(1)//счетчик нажатий
    
    var wrongCounter = Float(0)//считаем неправильные результаты
    var superWrong = Float(0)//счетчик неправильных нажатий итогового принятия решения
    var visualAcuity = Float()//острота зрения
    
    var currentEye = ""
    
    
    var synthesizer = AVSpeechSynthesizer()
    
    var timer: Timer!
    var startTimerCounter = 5//время до старта
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        synthesizer.delegate = self
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Results", style: .plain, target: self, action: #selector(actionResults))
        
    }
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        disapearTrue = true
        
        viewArray = [rightLandoltView, leftLandoltView, topLandoltView, bottomLandoltView]
        koef = ((UIDevice.modelWidth)/70)*5/distance
        
        
        addHelpSymbolView()
        addHelpWorkView()

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let resultSettings = try context.fetch(SettingsApp.fetchRequest())
            
            if resultSettings.count > 0 {
                distanceBool = (resultSettings.last as! SettingsApp).avtoDetectDistance
                if resultSettings.count > 0 {
                    distance = (resultSettings.last as! SettingsApp).distanceTest
                    
                    if (resultSettings.last as! SettingsApp).timeBeforeTest > 0 {
                        startTimerCounter = Int((resultSettings.last as! SettingsApp).timeBeforeTest)
                    }
                    
                    if (resultSettings.last as! SettingsApp).symbolTest == "Snellen"{
                        viewArray = [rightSnellenView, leftSnellenView, topSnellenView, bottomSnellenView]
                    }else if (resultSettings.last as! SettingsApp).symbolTest == "Landolt"{
                        viewArray = [rightLandoltView, leftLandoltView, topLandoltView, bottomLandoltView]
                    }
                    
                    koef = ((UIDevice.modelWidth)/70)*5/(resultSettings.last as! SettingsApp).distanceTest //70 - ширина символа в мм на расст 5м, 5  - это и есть 5 метров
                }
                else{
                    viewArray = [rightLandoltView, leftLandoltView, topLandoltView, bottomLandoltView]
                }
            }
        } catch let error as NSError {
            print(error)
        }
        
        workViewArray = viewArray
        currentView = workViewArray.randomElement()!
        addLandoltSnellenView(addingView: currentView, koef: koef)
        
        if distanceBool{
            self.session = self.setupAVCaptureSession()
            self.prepareVisionRequest()
            self.session?.startRunning()
        }
        addButton()
        
        addStartLabel()
        //addDistLabel()//потом убрать
    }
    // MARK: viewDidAppear
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
                    print("authorized")
                    
                case .denied:
                    print("denied")
                    
                case .restricted:
                    print("restricted")
                    
                case .notDetermined:
                    print("notDetermined")
                    
                default:
                    print("denied")
                   
                }
            }
        }
        
    }
    
    // MARK: viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(false)
         //self.navigationController?.navigationBar.isHidden = false
        if disapearTrue {
            self.navigationController?.popViewController(animated: false)
        }
        self.session?.stopRunning()
    }
    
    @objc func actionResults() {//метод self.navigationItem.leftBarButtonItem
        
        disapearTrue = false
        let resultVC = ResultsTableViewController()
        resultVC.title = "Miopia test results"
        resultVC.state = "Miopia"
        self.navigationController?.pushViewController(resultVC, animated: true)
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
                //self.reciveTextLabel.text = result.bestTranscription.formattedString
                
                isFinal = result.isFinal
                
                //self.currentText = result.bestTranscription.formattedString
                
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
        let videoDataOutputQueue = DispatchQueue(label: "myBeautifullQueue")
        //let videoDataOutputQueue = DispatchQueue(label: "com.example.apple-samplecode.VisionFaceTrack")
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
                    let rez = (Float(righ!) - Float(left!))*deviceCoef//(458/326)
                    //self.distLabel.text = "\(31/rez))"
                    self.distance = (31/rez)
                    
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
    
    
    // MARK: View
    
    func addStartLabel(){
        self.view.addSubview(startLabel)
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        startLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        startLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        //startLabel.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        startLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        startLabel.text = "Коснитесь экрана для начала теста"
        startLabel.textAlignment = .center
        startLabel.numberOfLines = 0
        startLabel.textColor = .systemBlue
        startLabel.font = .systemFont(ofSize: 30)
        startLabel.backgroundColor = .white
        startLabel.alpha = 0.8
        startLabel.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(tapGestureRecognizer:)))
        startLabel.addGestureRecognizer(tap)
        
    }
    
    func addDistLabel() {
        view.addSubview(distLabel)
        distLabel.translatesAutoresizingMaskIntoConstraints = false
        distLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        distLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        distLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
        distLabel.textAlignment = .center
        distLabel.layer.borderColor = UIColor.red.cgColor
        distLabel.layer.borderWidth = 1
        distLabel.font = .boldSystemFont(ofSize: 80)
        distLabel.textColor = .blue
    }
    
    func addHelpSymbolView() {
        
        self.view.addSubview(helpSymbolView)
        helpSymbolView.translatesAutoresizingMaskIntoConstraints = false
        helpSymbolView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        helpSymbolView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        helpSymbolView.heightAnchor.constraint(equalTo: helpSymbolView.widthAnchor).isActive = true
        
    }
    
    
    func addHelpWorkView() {
        self.view.addSubview(helpWorkView)
        helpWorkView.translatesAutoresizingMaskIntoConstraints = false
        helpWorkView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: -view.frame.width).isActive = true
        helpWorkView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        helpWorkView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
    }
    
    func addLandoltSnellenView(addingView:UIView, koef: Float) {
        helpSymbolView.addSubview(addingView)
        addingView.translatesAutoresizingMaskIntoConstraints = false
        addingView.centerYAnchor.constraint(equalTo: helpSymbolView.centerYAnchor).isActive = true
        addingView.centerXAnchor.constraint(equalTo: helpSymbolView.centerXAnchor).isActive = true
        addingView.widthAnchor.constraint(equalTo: helpSymbolView.widthAnchor, multiplier: CGFloat(1/koef)).isActive = true
        addingView.heightAnchor.constraint(equalTo: helpSymbolView.heightAnchor, multiplier: CGFloat(1/koef)).isActive = true
    }
    
    func addButton(){
        
        let butonsSymbolArray = ["→","←","↑","↓","❌"]
        let buttonArray = [rightButton, leftButton, topButton, bottomButton,centralButton]
        
        for i in (0...buttonArray.count-1){
            helpWorkView.addSubview(buttonArray[i])
            buttonArray[i].translatesAutoresizingMaskIntoConstraints = false
            if i < 4 {
                buttonArray[i].heightAnchor.constraint(equalTo: helpWorkView.heightAnchor, multiplier: 1/3).isActive = true
                buttonArray[i].widthAnchor.constraint(equalTo: helpWorkView.widthAnchor, multiplier: 1/3).isActive = true}
            buttonArray[i].layer.cornerRadius = 20
            buttonArray[i].layer.backgroundColor = UIColor.white.cgColor
            buttonArray[i].layer.borderColor = UIColor.blue.cgColor
            buttonArray[i].layer.borderWidth = 1
            buttonArray[i].tag = i
            //buttonArray[i].addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            buttonArray[i].setTitle(butonsSymbolArray[i], for: .normal)
            buttonArray[i].setTitleColor(.darkGray, for: .normal)
            
        }
        topButton.topAnchor.constraint(equalTo: helpWorkView.topAnchor, constant: 5).isActive = true
        topButton.centerXAnchor.constraint(equalTo: helpWorkView.centerXAnchor).isActive = true
        bottomButton.bottomAnchor.constraint(equalTo: helpWorkView.bottomAnchor, constant: -5).isActive = true
        bottomButton.centerXAnchor.constraint(equalTo: helpWorkView.centerXAnchor).isActive = true
        leftButton.leftAnchor.constraint(equalTo: helpWorkView.leftAnchor, constant: 5).isActive = true
        leftButton.centerYAnchor.constraint(equalTo: helpWorkView.centerYAnchor).isActive = true
        rightButton.rightAnchor.constraint(equalTo: helpWorkView.rightAnchor, constant: -5).isActive = true
        rightButton.centerYAnchor.constraint(equalTo: helpWorkView.centerYAnchor).isActive = true
        
        centralButton.widthAnchor.constraint(equalTo: helpWorkView.widthAnchor, multiplier: 1/4).isActive = true
        centralButton.heightAnchor.constraint(equalTo: helpWorkView.heightAnchor, multiplier: 1/4).isActive = true
        centralButton.centerYAnchor.constraint(equalTo: helpWorkView.centerYAnchor).isActive = true
        centralButton.centerXAnchor.constraint(equalTo: helpWorkView.centerXAnchor).isActive = true
        //centralButton.removeTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        //centralButton.addTarget(self, action: #selector(centralButtonAction), for: .touchUpInside)
    }
    
    @objc func tapAction(tapGestureRecognizer: UITapGestureRecognizer){
        //startLabel.removeFromSuperview()
//        topButton.isEnabled = true
//        bottomButton.isEnabled = true
//        leftButton.isEnabled = true
//        rightButton.isEnabled = true
//        centralButton.isEnabled = true
        
        //startAlert()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimerAction), userInfo: nil, repeats: true)
        // MARK: session?.startRunning()
        self.session = self.setupAVCaptureSession()
        self.prepareVisionRequest()
        self.session?.startRunning()
        
    }
    
    @objc func startTimerAction(){
        if startTimerCounter > 0{
            
            startTimerCounter -= 1
            startLabel.text = "\(startTimerCounter)"
            if startTimerCounter <= 0 {
                startLabel.removeFromSuperview()
                timer.invalidate()
                currentView.removeFromSuperview()
                koef = ((UIDevice.modelWidth)/70)*5/distance
                print(distance)
                self.session?.stopRunning()
                addLandoltSnellenView(addingView: currentView, koef: koef)
                beginSynthesizer()
            }
        }
    }
    
    func beginSynthesizer(){
        var textUteranse = String()
        textUteranse = "Закройте левый глаз"
        let utteranceSp = AVSpeechUtterance(string: textUteranse)
        utteranceSp.voice = AVSpeechSynthesisVoice(language: "ru_Ru")
        utteranceSp.rate = 0.5
        
        synthesizer.speak(utteranceSp)
    }
    
}

