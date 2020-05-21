

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
    var iapMoreThenOneUser = false
    
    var locale = "en_US"
    let textUserVC = UserVCText()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.6561266184, green: 0.9085168242, blue: 0.9700091481, alpha: 1)
        
        userTextView.delegate = self
        userTextField.delegate = self
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAction)), UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(organizeButtonAction))]
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        
        do {//получили текущего юзера
            usersArray = try context.fetch(User.fetchRequest())
            let resCurrUser = try context.fetch(CurrentUser.fetchRequest())
            let iap = try context.fetch(InAppPurchases.fetchRequest())
            if resCurrUser.count > 0 {
                currentUser = Int((resCurrUser.last as! CurrentUser).currentUser)
            }else{currentUser = 0}
            
            if iap.count > 0{
                iapMoreThenOneUser = (iap.last as! InAppPurchases).moreThanOneUser
            }
        } catch let error as NSError {
            print(error)
        }
        
        setImage()
        addSubView()
        
        addView()

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
        userTextField.textAlignment = .center
        userTextField.layer.cornerRadius = 10
        
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
        userTextView.layer.cornerRadius = 10
    }
    
    func setImage(){
        if newUserBool == false{
            imageData = UIImage(named: "placeholder")!.pngData()!
            if usersArray.count > 0{
                userImageView.image = UIImage(data: usersArray[currentUser].photo ?? imageData)
            }else{
                userImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    @objc func addButtonAction(){
        
        if iapMoreThenOneUser{
            
            let text4:String = textUserVC.allertMessage[locale] ?? "Хотите добавить нового пользователя?"
            
            let alert = UIAlertController(title: nil, message: text4, preferredStyle: .alert)
            
            let text5:String = textUserVC.alertCanselText[locale] ?? "Отмена"
            
            let alertCansel = UIAlertAction(title: text5, style: .destructive, handler: nil)
            
            let text6:String = textUserVC.alertAction[locale] ?? "Добавить пользователя"
            
            let alertAction = UIAlertAction(title: text6, style: .default) { (action) in
                self.userImageView.image = UIImage(named: "placeholder")
                self.userTextView.text = ""
                self.userTextField.text = ""
                
                self.newUserBool = true
                let array = ["👶🏻", "👧", "🧒🏼", "👨🏼‍🦳", "👵🏻", "👴🏻", "👱🏽‍♀️", "🧔🏻"]
                
                let size = CGSize(width: 50, height: 50)
                self.userImageView.image = array.randomElement()?.image(size: size)
                
                let userNew = User(context: self.context)//добавили нового пользователя
                userNew.setValue(self.userImageView.image?.jpeg(.lowest), forKey: "photo")
                userNew.setValue(self.userTextField.text, forKey: "name")
                userNew.setValue(self.userTextView.text, forKey: "info")
                do {
                    try self.context.save()
                }catch let error as NSError{
                    print(error)
                }
                self.usersArray.append(userNew)
                if self.newUserBool == true{ //если это новый пользователь
                    do {//удаляем текущего пользователя
                        let result = try self.context.fetch(CurrentUser.fetchRequest())
                        for res in result{
                            self.context.delete(res as! NSManagedObject)
                        }
                        try? self.context.save()
                    } catch let error as NSError {
                        print(error)
                    }
                    
                    var count = Int()
                    do {//получили массив всех юзеров
                        count = try self.context.fetch(User.fetchRequest()).count//присвоили переменной длину массива
                    }catch let error as NSError {
                        print(error)
                    }
                    self.currentUser = count - 1
                    let newCurrentUser = CurrentUser(context: self.context)
                    newCurrentUser.setValue(Float(count-1), forKey: "currentUser")//создали нового текущего пользователя - последний в списке
                    do {
                        try self.context.save()
                    }catch let error as NSError{
                        print(error)
                    }
                    print(count - 1)
                }
            }
            alert.addAction(alertAction)
            alert.addAction(alertCansel)
            self.present(alert, animated: false, completion: nil)
            
        }else{
            let iapVC = IAPurchTableViewController()
            let text1:String = textUserVC.alertIAPMessage[locale] ?? "Для увеличения количества пользователей необходимо совершить покупку"
            let alert = UIAlertController(title: " ", message: text1, preferredStyle: .actionSheet)
            
//            let alert = UIAlertController(title: " ", message: "Для увеличения количества пользователей необходимо совершить покупку", preferredStyle: .actionSheet)
            let text2:String = textUserVC.alertActionIAP[locale] ?? "Перейти к покупкам"
            let alertAction = UIAlertAction(title: text2, style: .default) { (_) in
                self.navigationController?.pushViewController(iapVC, animated: true)
            }
//            let alertAction = UIAlertAction(title: "Перейти к покупкам", style: .default) { (_) in
//                self.navigationController?.pushViewController(iapVC, animated: true)
//            }
            let text3:String = textUserVC.alertCanselText[locale] ?? "Отмена"
            let alertCancel = UIAlertAction(title: text3, style: .cancel, handler: nil)
            alert.addAction(alertAction)
            alert.addAction(alertCancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func photoButtonAction(){
        let cameraVC = CameraViewController()
        cameraVC.comletion = {[unowned self] data in
            self.userImageView.image = UIImage(data: data)
            self.usersArray[self.currentUser].photo = data
            do {
                try self.context.save()
            }catch let error as NSError{
                print(error)
            }
            
        }
        self.navigationController?.pushViewController(cameraVC, animated: false)
    }
    
    
    @objc func organizeButtonAction(){
        let userArrayVC = UsersArrayTableViewController()
        userArrayVC.complition = { curUser in
            self.currentUser = curUser
            let imgData = UIImage(named: "placeholder")?.pngData()
            self.userImageView.image = UIImage(data: self.usersArray[self.currentUser].photo ?? imgData!)
        }
        userArrayVC.state = "Main"
        userArrayVC.stateBool = true
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
            newCurrentUser.setValue(Float(count), forKey: "currentUser")//создали нового текущего пользователя - последний в списке
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
        userTextView.frame.origin.y += 400
        photoButton.isEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if userTextView.isFirstResponder{
            //userTextField.frame.origin.y += 200
            userTextView.frame.origin.y += 200
            photoButton.frame.origin.y += 500
            userTextView.resignFirstResponder()
            //userTextField.resignFirstResponder()
            usersArray[currentUser].info = userTextView.text
            do {
                try context.save()
            }catch let error as NSError{
                print(error)
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userTextField.resignFirstResponder()
//        self.navigationItem.rightBarButtonItems?.removeAll()
//        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveEditButtonAction))]
        usersArray[currentUser].name = userTextField.text
        do {
            try context.save()
        }catch let error as NSError{
            print(error)
        }
        photoButton.isEnabled = true
        
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
