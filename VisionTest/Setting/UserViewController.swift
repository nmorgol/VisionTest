

import UIKit
import CoreData

class UserViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    let userImageView = UIImageView()
    let userTextField = UITextField()
    let userTextView = UITextView()
    let firstView = UIView()
    let secondView = UIView()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var usersArray = [User]()
    var currentUser = Int()
    var imageData = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonAction)), UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(rightBarButtonAction)),UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(organizeButtonAction))]
        
        addSubView()
        
        let tapUserImageViewGesture = UITapGestureRecognizer(target: self, action: #selector(userImageViewTapAction))
        userImageView.isUserInteractionEnabled = true
        userImageView.addGestureRecognizer(tapUserImageViewGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        do {
            usersArray = try context.fetch(User.fetchRequest())
        } catch let error as NSError {
            print(error)
        }
        if usersArray.count != 0 {
        currentUser = usersArray.count - 1
        }else{currentUser = 0}
        
        addView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillAppear(false)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func addSubView(){
        view.addSubview(userImageView)
        view.addSubview(userTextField)
        view.addSubview(userTextView)
        view.addSubview(firstView)
        view.addSubview(secondView)
        
    }
    
    func addView(){
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor).isActive = true
        userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //userImageView.layer.cornerRadius = 50
        imageData = UIImage(named: "placeholder")!.pngData()!
        if usersArray.count > 0{
            userImageView.image = UIImage(data: usersArray[currentUser].photo ?? imageData)
        }else{
            userImageView.image = UIImage(data: imageData)
        }
        
        userImageView.clipsToBounds = true
        
        firstView.translatesAutoresizingMaskIntoConstraints = false
        firstView.topAnchor.constraint(equalTo: userImageView.bottomAnchor).isActive = true
        firstView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        firstView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/30).isActive = true
        
        userTextField.translatesAutoresizingMaskIntoConstraints = false
        userTextField.topAnchor.constraint(equalTo: firstView.bottomAnchor).isActive = true
        userTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 5/6).isActive = true
        userTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/20).isActive = true
        userTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if usersArray.count > 0 {
            userTextField.placeholder = usersArray[currentUser].name
        }else{
            userTextField.placeholder = "Name"
        }
        
        userTextField.backgroundColor = .systemGray6
        
        secondView.translatesAutoresizingMaskIntoConstraints = false
        secondView.topAnchor.constraint(equalTo: userTextField.bottomAnchor).isActive = true
        secondView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        secondView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/30).isActive = true
        
        userTextView.translatesAutoresizingMaskIntoConstraints = false
        userTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 5/6).isActive = true
        userTextView.topAnchor.constraint(equalTo: secondView.bottomAnchor).isActive = true
        userTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        userTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if usersArray.count > 0 {
            userTextView.text = usersArray[currentUser].info
        }
        
        userTextView.backgroundColor = .systemGray6
        
    }
    
    @objc func rightBarButtonAction(){
        
    }
    
    @objc func userImageViewTapAction(){
        let cameraVC = CameraViewController()
        self.navigationController?.pushViewController(cameraVC, animated: false)
    }
    
    @objc func organizeButtonAction(){
        let useraArrayVC = UsersArrayTableViewController()
        self.navigationController?.pushViewController(useraArrayVC, animated: false)
    }
}
