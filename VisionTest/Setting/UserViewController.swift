

import UIKit
import CoreData

class UserViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    let userImageView = UIImageView()
    let userTextField = UITextField()
    let userTextView = UITextView()
    let firstView = UIView()
    let secondView = UIView()
    let photoButton = UIButton()
    
    let userInfoImageView = UIImageView()
    
    var usersArray = [User]()
    var currentUser = Int()
    var imageData = Data()
    
    var newUserBool = false
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.6561266184, green: 0.9085168242, blue: 0.9700091481, alpha: 1)
        
        userTextView.delegate = self
        userTextField.delegate = self
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAction)), UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(organizeButtonAction))]
        
        do {//получили текущего юзера
            usersArray = try context.fetch(User.fetchRequest())
            let resCurrUser = try context.fetch(CurrentUser.fetchRequest())
            if resCurrUser.count > 0 {
                currentUser = Int((resCurrUser.last as! CurrentUser).currentUser)
            }else{currentUser = 0}
        } catch let error as NSError {
            print(error)
        }
        
        setImage()
        addSubView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        
        
        addView()
//        print(newUserBool)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(false)
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
        userImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor).isActive = true
        userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //userImageView.layer.cornerRadius = 50
        
        userImageView.clipsToBounds = true
        userImageView.isUserInteractionEnabled = true
        let gestureUserPhotoView = UITapGestureRecognizer(target: self, action: #selector(tapGestureUserInfoAction(tapGestureRecognizer:)))
        userImageView.addGestureRecognizer(gestureUserPhotoView)
        
        
        firstView.translatesAutoresizingMaskIntoConstraints = false
        firstView.topAnchor.constraint(equalTo: userImageView.bottomAnchor).isActive = true
        firstView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        firstView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
        
        firstView.addSubview(photoButton)
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        photoButton.centerYAnchor.constraint(equalTo: firstView.centerYAnchor).isActive = true
        photoButton.centerXAnchor.constraint(equalTo: firstView.centerXAnchor).isActive = true
        photoButton.widthAnchor.constraint(equalTo: userImageView.widthAnchor).isActive = true
        photoButton.heightAnchor.constraint(equalTo: firstView.widthAnchor, multiplier: 9/10).isActive = true
        photoButton.setTitle("New photo", for: .normal)
        photoButton.setTitleColor(.systemBlue, for: .normal)
        photoButton.addTarget(self, action: #selector(photoButtonAction), for: .touchUpInside)
        
        userTextField.translatesAutoresizingMaskIntoConstraints = false
        userTextField.topAnchor.constraint(equalTo: firstView.bottomAnchor).isActive = true
        userTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 5/6).isActive = true
        userTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/20).isActive = true
        userTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if usersArray.count > 0 {
            userTextField.text = usersArray[currentUser].name
            
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
    
    func setImage(){
        imageData = UIImage(named: "placeholder")!.pngData()!
        if usersArray.count > 0{
            userImageView.image = UIImage(data: usersArray[currentUser].photo ?? imageData)
        }else{
            userImageView.image = UIImage(data: imageData)
        }
    }
    
    @objc func addButtonAction(){
        self.navigationItem.rightBarButtonItems?.removeAll()
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAddButtonAction))]
        userImageView.image = UIImage(named: "placeholder")
        userTextView.text = ""
        userTextField.text = ""
        
        newUserBool = true
    }
    
    @objc func photoButtonAction(){
        let cameraVC = CameraViewController()
        cameraVC.comletion = {[unowned self] data in
            self.userImageView.image = UIImage(data: data)
            if self.navigationItem.rightBarButtonItems?.count ?? 2 > 1 {
                self.navigationItem.rightBarButtonItems?.removeAll()
                self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveEditButtonAction))]
            }
            
        }
        self.navigationController?.pushViewController(cameraVC, animated: false)
    }
    
    
    @objc func organizeButtonAction(){
        let userArrayVC = UsersArrayTableViewController()
        userArrayVC.complition = { curUser in
            self.currentUser = curUser
            self.userImageView.image = UIImage(data: self.usersArray[self.currentUser].photo!)
        }
        userArrayVC.state = "Main"
        self.navigationController?.pushViewController(userArrayVC, animated: false)
    }
    
    @objc func saveAddButtonAction(){
        let userNew = User(context: context)//добавили нового пользователя
        userNew.setValue(userImageView.image?.jpeg(.lowest), forKey: "photo")
        userNew.setValue(userTextField.text, forKey: "name")
        userNew.setValue(userTextView.text, forKey: "info")
        do {
            try context.save()
        }catch let error as NSError{
            print(error)
        }
        
        if newUserBool == true{ //если это новый пользователь
            do {//удаляем текущего пользователя
                let result = try context.fetch(CurrentUser.fetchRequest())
                for res in result{
                    context.delete(res as! NSManagedObject)
                }
                try? context.save()
            } catch let error as NSError {
                print(error)
            }
            
            var count = Int()
            do {//получили массив всех юзеров
                count = try context.fetch(User.fetchRequest()).count//присвоили переменной длину массива
            }catch let error as NSError {
                print(error)
            }
            let newCurrentUser = CurrentUser(context: context)
            newCurrentUser.setValue(Float(count - 1), forKey: "currentUser")//создали нового текущего пользователя - последний в списке
            do {
                try context.save()
            }catch let error as NSError{
                print(error)
            }
            print(count - 1)
        }
        self.navigationItem.rightBarButtonItems?.removeAll()
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAction)), UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(organizeButtonAction))]
    }
    
    
    @objc func saveEditButtonAction(){
        if usersArray.count == 0{//если нет пользователей
            let userNew = User(context: context)//добавили нового пользователя
            userNew.setValue(userImageView.image?.jpeg(.lowest), forKey: "photo")
            userNew.setValue(userTextField.text, forKey: "name")
            userNew.setValue(userTextView.text, forKey: "info")
            
            let currentUser = CurrentUser(context: context)
            currentUser.setValue(0, forKey: "currentUser")
            do {
                try context.save()
            }catch let error as NSError{
                print(error)
            }
        }else{
            usersArray[currentUser].photo = userImageView.image?.jpeg(.lowest)
            usersArray[currentUser].name = userTextField.text
            usersArray[currentUser].info = userTextView.text
            print(currentUser)
            
            do {
                try context.save()
            }catch let error as NSError{
                print(error)
            }
        }
        self.navigationItem.rightBarButtonItems?.removeAll()
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAction)), UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(organizeButtonAction))]
        
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if userTextView.isFirstResponder{
            //userTextField.frame.origin.y -= 200
            userTextView.frame.origin.y -= 200
            
            photoButton.frame.origin.y -= 500
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        userTextView.frame.origin.y += 200
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if userTextView.isFirstResponder{
            //userTextField.frame.origin.y += 200
            userTextView.frame.origin.y += 200
            photoButton.frame.origin.y += 500
            userTextView.resignFirstResponder()
            
            self.navigationItem.rightBarButtonItems?.removeAll()
            self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveEditButtonAction))]
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userTextField.resignFirstResponder()
        self.navigationItem.rightBarButtonItems?.removeAll()
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveEditButtonAction))]
        
        return true
    }
    
    @objc func tapGestureUserInfoAction(tapGestureRecognizer: UITapGestureRecognizer){
        self.view.addSubview(userInfoImageView)
        userInfoImageView.translatesAutoresizingMaskIntoConstraints = false
        userInfoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        userInfoImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        userInfoImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        userInfoImageView.image = UIImage(data: imageData)
        
        if usersArray.count > 0{
            userInfoImageView.image = UIImage(data: usersArray[currentUser].photo ?? imageData)
        }else{
            userInfoImageView.image = UIImage(data: imageData)
        }
        
        userInfoImageView.contentMode = .scaleAspectFit
        userInfoImageView.backgroundColor = .white
        userInfoImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeCoverImage))
        userInfoImageView.addGestureRecognizer(tap)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func removeCoverImage(recognizer: UITapGestureRecognizer){
        userInfoImageView.removeFromSuperview()
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
}
