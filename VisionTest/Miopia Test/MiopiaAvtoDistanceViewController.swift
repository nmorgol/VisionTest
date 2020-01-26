

import UIKit
import Speech
import AVKit
import Vision

class MiopiaAvtoDistanceViewController: UIViewController {

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
    
    
    
    
    var disapearTrue = true //подпорка для того чтобы не отрабатывал метод self.navigationController?.popViewController(animated:false)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Results", style: .plain, target: self, action: #selector(actionResults))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        disapearTrue = true
        //self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(false)
         //self.navigationController?.navigationBar.isHidden = false
        if disapearTrue {
            self.navigationController?.popViewController(animated: false)}
    }
    
    @objc func actionResults() {//метод self.navigationItem.leftBarButtonItem
        
        disapearTrue = false
        let resultVC = ResultsTableViewController()
        resultVC.title = "Miopia test results"
        resultVC.state = "Miopia"
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
    
}
