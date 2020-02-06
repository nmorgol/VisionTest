

import UIKit
import CoreData

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var photoImageView = UIImageView()
    var usePhotoButton = UIButton()
    var deletePhotoButton = UIButton()
    var resultImageView = UIImageView()
    
    var frameImag = CGRect()
    
    var comletion:((Data)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        addPhotoImageView()
//        addUsePhotoButton()
        addDeletePhotoButton()
        addResultImageView()
        displayImagePickerContr()
        
        
        photoImageView.isUserInteractionEnabled = true
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureMethod(recognizer:)))
        photoImageView.addGestureRecognizer(pinchGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(punGestureMethod(recognizer:)))
        photoImageView.addGestureRecognizer(panGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillAppear(false)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func addPhotoImageView() {
        view.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        photoImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        photoImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    func addResultImageView(){
        view.addSubview(resultImageView)
        resultImageView.translatesAutoresizingMaskIntoConstraints = false
        resultImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        resultImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        resultImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        resultImageView.layer.borderWidth = 3
        resultImageView.layer.borderColor = UIColor.darkGray.cgColor
        
    }
    
    @objc func resultImageViewAction(){
        
        //прилетает нил надо проверка
        if photoImageView.image == nil{
            deletePhotoButton.isEnabled = false
            return
        }else{
            deletePhotoButton.isEnabled = true
        }
        let img = cropImage(photoImageView.image!, toRect: resultImageView.frame, viewWidth: photoImageView.frame.width, viewHeight: photoImageView.frame.height  )
        
        photoImageView.image = nil
        resultImageView.image = img  //UIImage(cgImage: img!)
        resultImageView.contentMode = .scaleAspectFit
        
        addUsePhotoButton()
        
        deletePhotoButton.removeFromSuperview()
    }
    
    func addUsePhotoButton(){
        view.addSubview(usePhotoButton)
        usePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        usePhotoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        usePhotoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        usePhotoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        usePhotoButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        usePhotoButton.setTitle("Use Photo", for: .normal)
        usePhotoButton.setTitleColor(.black, for: .normal)
        usePhotoButton.layer.cornerRadius = 20
        usePhotoButton.layer.borderWidth = 0.3
        
        usePhotoButton.addTarget(self, action: #selector(savePhotoAction), for: .touchUpInside)
    }
    
    func addDeletePhotoButton(){
        view.addSubview(deletePhotoButton)
        deletePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        deletePhotoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        deletePhotoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        deletePhotoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        deletePhotoButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        deletePhotoButton.setTitleColor(.black, for: .normal)
        deletePhotoButton.setTitle("Crop Photo", for: .normal)
        deletePhotoButton.layer.cornerRadius = 20
        deletePhotoButton.layer.borderWidth = 0.3
        
        deletePhotoButton.addTarget(self, action: #selector(resultImageViewAction), for: .touchUpInside)
    }
    
    @objc func savePhotoAction(){
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let lowImage = resultImageView.image?.jpeg(.lowest)
//        print(lowImage?.count)
//        let photoPNG = resultImageView.image?.pngData()
//        print(photoPNG?.count)
        let data:Data = lowImage ?? (UIImage(named: "placeholder")?.pngData())!
//        do {
//            let result = try context.fetch(User.fetchRequest())
//
//            //            print((result.last as! User).photo as Any)
//            if result.count > 0 {
//                (result.last as! User).photo = photoPNG
//                try? context.save()
//            }else{
//                let userNew = User(context: context)
//                userNew.setValue(photoPNG, forKey: "photo")
//                do {
//                    try context.save()
//                }catch let error as NSError{
//                    print(error)
//                }
//            }
//        } catch let error as NSError {
//            print(error)
//        }
        comletion?(data)
        self.navigationController?.popViewController(animated: false)
    }
    
    func displayImagePickerContr() {
        let photoPickerContr = UIImagePickerController()
        photoPickerContr.delegate = self
        photoPickerContr.sourceType = UIImagePickerController.SourceType.camera
        self.present(photoPickerContr, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photoImageView.image = info[.originalImage] as? UIImage
        photoImageView.image = photoImageView.image?.fixOrientation()
        photoImageView.backgroundColor = .clear
        photoImageView.contentMode = .scaleAspectFit
        //        resultImageViewAction()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func punGestureMethod(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let viewRec = recognizer.view {
            viewRec.center = CGPoint(x: viewRec.center.x + translation.x, y: viewRec.center.y + translation.y)
            
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
    }
    
    @objc func pinchGestureMethod(recognizer: UIPinchGestureRecognizer) {
        if let viewRec = recognizer.view{
            viewRec.transform = viewRec.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
            
        }
        
        if recognizer.state == .ended{
            frameImag = photoImageView.frame
        }
    }
    
    func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect, viewWidth: CGFloat, viewHeight: CGFloat) -> UIImage?
    {
        let imageViewScale = max(inputImage.size.width / viewWidth,
                                 inputImage.size.height / viewHeight)
                let imgScaleX = inputImage.size.width / viewWidth
                let imgScaleY = inputImage.size.height / viewHeight
        print(photoImageView.frame.origin)
        // Scale cropRect to handle images larger than shown-on-screen size
        let cropZone = CGRect(x:(resultImageView.frame.origin.x - photoImageView.frame.origin.x)*imgScaleX,
                              y:(resultImageView.frame.origin.y - photoImageView.frame.origin.y)*imgScaleY,
                              width:cropRect.size.width * imageViewScale,
                              height:cropRect.size.height * imageViewScale)
        
        // Perform cropping in Core Graphics
        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropZone)
            else {
                return nil
        }
        
        // Return image to UIImage
        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
        
        return croppedImage
    }
    
}
