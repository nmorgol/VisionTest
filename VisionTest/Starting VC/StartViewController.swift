

import UIKit

class StartViewController: UIViewController {

    let userView = UIView()
    let userImageView = UIImageView()
    let userNameLabel = UILabel()
    let userInfoTextView = UITextView()
    
    let eyeView = EyeView()
    let myopiaLight = MyopiaLightView()
    
    let eyeHypView = EyeView()
    let hyperopiaLight = HyperopiaLightView()
    
    var avtoDetectDistBool = false
    var speechRecognBool = false
    var distanceTest = Float(0.5)
    var timeToStart = Float(0)
    var symbolTest = "Snellen"
    
    var name = "name"
    var photo = Data()
    var infoText = "info"
    
    let settingsView = UIView()
    let settingsLabel = UILabel()
    let settingsButton = UIButton()
    
    let myopiaView = UIView()
    let startMyopiaView = UIView()
    let informMyopiaButton = UIButton()
    let myopiaResultButton = UIButton()
    
    let hyperopiaView = UIView()
    let startHyperopiaView = UIView()
    let informHyperopiaButton = UIButton()
    let hyperopiaResultButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.6561266184, green: 0.9085168242, blue: 0.9700091481, alpha: 1)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        
        self.navigationController?.navigationBar.isHidden = true
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let image = UIImage(named: "placeholder")?.pngData()!
        
        do {
            let resultUser = try context.fetch(User.fetchRequest())
            let resCurrentUser = try context.fetch(CurrentUser.fetchRequest())
            let settings = try context.fetch(SettingsApp.fetchRequest())
            let iap = try context.fetch(InAppPurchases.fetchRequest())
            let canselInfo = try context.fetch(CanselInstruction.fetchRequest())
            
            
            print(iap.count)
            if iap.count == 0{
                let newIAP = InAppPurchases(context: context)
                newIAP.setValue(false, forKey: "speechRecognition")
                newIAP.setValue(false, forKey: "moreThanOneUser")
                newIAP.setValue(false, forKey: "autoDetectDistance")
                do {
                    try context.save()
                }catch let error as NSError{
                    print(error)
                }
            }
            
            
            
            if resultUser.count > 0 {
                let curUser = (resCurrentUser.last as! CurrentUser).currentUser
                
                name = (resultUser[Int(curUser)] as! User).name ?? ""
                photo = ((resultUser[Int(curUser)] as! User).photo) ?? image!
                infoText = ((resultUser[Int(curUser)] as! User).info) ?? ""
            }else{
                let userNew = User(context: context)//добавили нового пользователя
                userNew.setValue(image, forKey: "photo")
                userNew.setValue("name", forKey: "name")
                userNew.setValue(" ", forKey: "info")
                
                let currentUser = CurrentUser(context: context)
                currentUser.setValue(0, forKey: "currentUser")
                do {
                    try context.save()
                }catch let error as NSError{
                    print(error)
                }
                
                name = "name"
                photo = image!
            }//надо переделать
            if settings.count > 0 {
                distanceTest = (settings.last as! SettingsApp).distanceTest
                timeToStart = (settings.last as! SettingsApp).timeBeforeTest
                avtoDetectDistBool = (settings.last as! SettingsApp).avtoDetectDistance
                speechRecognBool = (settings.last as! SettingsApp).speechRecognize
                symbolTest = (settings.last as! SettingsApp).symbolTest ?? "Snellen"
            }
            if canselInfo.count == 0{
                let newCansel = CanselInstruction(context: context)
                newCansel.setValue(false, forKey: "hyperopiaLightCansel")
                newCansel.setValue(false, forKey: "hyperopiaSpeechCansel")
                newCansel.setValue(false, forKey: "myopiaLightCansel")
                newCansel.setValue(false, forKey: "myopiaSpeechCansel")
                
                do {
                    try context.save()
                }catch let error as NSError{
                    print(error)
                }
            }
            
        } catch let error as NSError {
            print(error)
        }
        
        addUserView()
        addSettingsView()
        addMyopiaView()
        addHyperopiaView()
        
        addUserSubviews()
        
        addMyopiaViewSubviews()
        addHyperopiaViewSubviews()
        addSettingsSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(false)
        self.navigationController?.navigationBar.isHidden = false
        
    }

    func addUserView() {
        view.addSubview(userView)
        userView.translatesAutoresizingMaskIntoConstraints = false
        userView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 9/10).isActive = true
        userView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/6).isActive = true
        userView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        userView.backgroundColor = .white
        userView.layer.cornerRadius = 30

        userView.layer.shadowOpacity = 0.1
        userView.layer.shadowColor = UIColor.black.cgColor
        
        userView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(userImageViewAction))
        userView.addGestureRecognizer(tap)
    }
    
    
    func addMyopiaView() {
        view.addSubview(myopiaView)
        myopiaView.translatesAutoresizingMaskIntoConstraints = false
        myopiaView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        myopiaView.topAnchor.constraint(equalTo: userView.bottomAnchor, constant: 5).isActive = true
        myopiaView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myopiaView.bottomAnchor.constraint(equalTo: settingsView.topAnchor, constant: -5).isActive = true
        
        myopiaView.backgroundColor = #colorLiteral(red: 0.912041011, green: 0.9828456094, blue: 1, alpha: 1)
        myopiaView.layer.cornerRadius = 30
        
        myopiaView.layer.shadowOpacity = 0.1
        myopiaView.layer.shadowColor = UIColor.black.cgColor
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeAnimate))
        leftSwipe.direction = .left
        myopiaView.addGestureRecognizer(leftSwipe)
    }
    
    
    
    func addHyperopiaView() {
        view.addSubview(hyperopiaView)
        hyperopiaView.translatesAutoresizingMaskIntoConstraints = false
        hyperopiaView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        hyperopiaView.topAnchor.constraint(equalTo: userView.bottomAnchor, constant: 5).isActive = true
        hyperopiaView.leftAnchor.constraint(equalTo: myopiaView.rightAnchor, constant: 5).isActive = true
        hyperopiaView.bottomAnchor.constraint(equalTo: settingsView.topAnchor, constant: -5).isActive = true
        
        hyperopiaView.backgroundColor = #colorLiteral(red: 0.912041011, green: 0.9828456094, blue: 1, alpha: 1)
        hyperopiaView.layer.cornerRadius = 30
        
        hyperopiaView.layer.shadowOpacity = 0.1
        hyperopiaView.layer.shadowColor = UIColor.black.cgColor
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeAnimate))
        rightSwipe.direction = .right
        hyperopiaView.addGestureRecognizer(rightSwipe)
    }
    
    func addSettingsView() {
        view.addSubview(settingsView)
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 9/10).isActive = true
        settingsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/8).isActive = true
        settingsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        settingsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        settingsView.backgroundColor = .white
        settingsView.layer.cornerRadius = 30
        
        settingsView.layer.shadowOpacity = 0.1
        settingsView.layer.shadowColor = UIColor.black.cgColor
        settingsView.backgroundColor = #colorLiteral(red: 0.912041011, green: 0.9828456094, blue: 1, alpha: 1)
    }
    
    func addUserSubviews(){
        userView.addSubview(userImageView)
        userView.addSubview(userNameLabel)
        userView.addSubview(userInfoTextView)
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        userImageView.leftAnchor.constraint(equalTo: userView.leftAnchor, constant: 10).isActive = true
        userImageView.topAnchor.constraint(equalTo: userView.topAnchor, constant: 10).isActive = true
        
        userImageView.image = UIImage(data: photo)
        userImageView.layer.cornerRadius = 50
        userImageView.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(userImageViewAction))
        userImageView.isUserInteractionEnabled = true
        userImageView.addGestureRecognizer(tap)
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.bottomAnchor.constraint(equalTo: userImageView.centerYAnchor).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: userImageView.topAnchor).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 10).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: userView.rightAnchor, constant: -10).isActive = true
        
        userNameLabel.text = name
        userNameLabel.textAlignment = .center
        
        let smallView = UIView()
        userNameLabel.addSubview(smallView)
        smallView.translatesAutoresizingMaskIntoConstraints = false
        smallView.bottomAnchor.constraint(equalTo: userNameLabel.bottomAnchor).isActive = true
        smallView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        smallView.widthAnchor.constraint(equalTo: userNameLabel.widthAnchor).isActive = true
        smallView.backgroundColor = .darkGray
        
        userInfoTextView.translatesAutoresizingMaskIntoConstraints = false
        userInfoTextView.rightAnchor.constraint(equalTo: smallView.rightAnchor).isActive = true
        userInfoTextView.leftAnchor.constraint(equalTo: smallView.leftAnchor).isActive = true
        userInfoTextView.topAnchor.constraint(equalTo: smallView.bottomAnchor).isActive = true
        userInfoTextView.heightAnchor.constraint(equalTo: userNameLabel.heightAnchor).isActive = true
        userInfoTextView.font = .systemFont(ofSize: 10)
        userInfoTextView.text = infoText
        userInfoTextView.isEditable = false
        
        
    }
    
    func addSettingsSubviews(){
        settingsView.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.centerYAnchor.constraint(equalTo: settingsView.centerYAnchor).isActive = true
        settingsButton.centerXAnchor.constraint(equalTo: settingsView.centerXAnchor).isActive = true
        settingsButton.widthAnchor.constraint(equalTo: settingsView.widthAnchor, multiplier: 4/5).isActive = true
        settingsButton.heightAnchor.constraint(equalTo: settingsView.heightAnchor, multiplier: 5/6).isActive = true
        
         
        settingsButton.backgroundColor = .white
        settingsButton.layer.cornerRadius = 20

        settingsButton.layer.shadowColor = UIColor.gray.cgColor
        settingsButton.layer.shadowOpacity = 0.1
        

        settingsButton.titleLabel?.numberOfLines = 0
        settingsButton.titleLabel?.textColor = .systemBlue
        settingsButton.titleLabel?.textAlignment = .center
        
        let size = CGSize(width: 50, height: 50)
        settingsButton.setImage("⚙️".image(size: size), for: .normal)
        
        
        settingsButton.setTitle("Настройки приложения", for: .normal)
        settingsButton.setTitleColor(.systemBlue, for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsViewAction), for: .touchUpInside)
        
    }
    
    func addMyopiaViewSubviews() {
        myopiaView.addSubview(startMyopiaView)
        myopiaView.addSubview(informMyopiaButton)
        myopiaView.addSubview(myopiaResultButton)
        
        startMyopiaView.translatesAutoresizingMaskIntoConstraints = false
        startMyopiaView.widthAnchor.constraint(equalTo: myopiaView.widthAnchor, multiplier: 4/5).isActive = true
        startMyopiaView.heightAnchor.constraint(equalTo: myopiaView.heightAnchor, multiplier: 1/2).isActive = true
        startMyopiaView.centerXAnchor.constraint(equalTo: myopiaView.centerXAnchor).isActive = true
        startMyopiaView.topAnchor.constraint(equalTo: myopiaView.topAnchor, constant: 10).isActive = true
        
        startMyopiaView.backgroundColor = #colorLiteral(red: 0.912041011, green: 0.9828456094, blue: 1, alpha: 1)
        startMyopiaView.layer.cornerRadius = 20
        
        startMyopiaView.layer.shadowColor = UIColor.gray.cgColor
        startMyopiaView.layer.shadowOpacity = 0.1
        
        startMyopiaView.addSubview(eyeView)
        eyeView.translatesAutoresizingMaskIntoConstraints = false
        eyeView.widthAnchor.constraint(equalTo: startMyopiaView.widthAnchor, multiplier: 2/3).isActive = true
        eyeView.heightAnchor.constraint(equalTo: startMyopiaView.heightAnchor, multiplier: 2/3).isActive = true
        eyeView.centerXAnchor.constraint(equalTo: startMyopiaView.centerXAnchor).isActive = true
        eyeView.topAnchor.constraint(equalTo: myopiaView.topAnchor, constant: 0).isActive = true
        eyeView.backgroundColor = .clear
        
        eyeView.addSubview(myopiaLight)
        myopiaLight.translatesAutoresizingMaskIntoConstraints = false
        myopiaLight.widthAnchor.constraint(equalTo: eyeView.widthAnchor, multiplier: 1).isActive = true
        myopiaLight.heightAnchor.constraint(equalTo: eyeView.heightAnchor, multiplier: 1).isActive = true
        myopiaLight.centerXAnchor.constraint(equalTo: eyeView.centerXAnchor).isActive = true
        myopiaLight.topAnchor.constraint(equalTo: eyeView.topAnchor, constant: 0).isActive = true
        
        myopiaLight.backgroundColor = .clear
        
//        let tapStart = UITapGestureRecognizer(target: self, action: #selector(startMyopiaViewAction))
//        startMyopiaView.isUserInteractionEnabled = true
//        startMyopiaView.addGestureRecognizer(tapStart)
        
        
        
        
        let startButton = UIButton()
        startMyopiaView.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.widthAnchor.constraint(equalTo: startMyopiaView.widthAnchor, multiplier: 5/5).isActive = true
        startButton.heightAnchor.constraint(equalTo: startMyopiaView.heightAnchor, multiplier: 1/3).isActive = true
        startButton.centerXAnchor.constraint(equalTo: startMyopiaView.centerXAnchor).isActive = true
        startButton.bottomAnchor.constraint(equalTo: startMyopiaView.bottomAnchor).isActive = true
        
        startButton.backgroundColor = .white
        startButton.layer.cornerRadius = 20
        
        startButton.layer.shadowColor = UIColor.lightGray.cgColor
        startButton.layer.shadowOpacity = 0.1
        
        let size = CGSize(width: 50, height: 50)
        startButton.setImage("✅".image(size: size), for: .normal)
        startButton.setTitle("Тест на наличие близорукости", for: .normal)
        startButton.titleLabel?.textAlignment = .center
        startButton.titleLabel?.numberOfLines = 0
        
        startButton.setTitleColor(.systemBlue, for: .normal)
        startButton.addTarget(self, action: #selector(startMyopiaViewAction), for: .touchUpInside)
        
        
        
        myopiaResultButton.translatesAutoresizingMaskIntoConstraints = false
        myopiaResultButton.leftAnchor.constraint(equalTo: startMyopiaView.leftAnchor, constant: 0).isActive = true
        myopiaResultButton.topAnchor.constraint(equalTo: startMyopiaView.bottomAnchor, constant: 10).isActive = true
        myopiaResultButton.bottomAnchor.constraint(equalTo: informMyopiaButton.topAnchor, constant: -10).isActive = true
        myopiaResultButton.rightAnchor.constraint(equalTo: startMyopiaView.rightAnchor, constant: 0).isActive = true
        
        myopiaResultButton.setImage("📁".image(size: size), for: .normal)
        myopiaResultButton.setTitle("Результаты теста близорукости", for: .normal)
        
        myopiaResultButton.titleLabel?.numberOfLines = 0
        myopiaResultButton.titleLabel?.textAlignment = .center
        myopiaResultButton.setTitleColor(.systemBlue, for: .normal)
        myopiaResultButton.backgroundColor = .white
        myopiaResultButton.layer.shadowColor = UIColor.gray.cgColor
        myopiaResultButton.layer.shadowOpacity = 0.1
        myopiaResultButton.layer.cornerRadius = 20
        myopiaResultButton.addTarget(self, action: #selector(myopiaResultButtonAction), for: .touchUpInside)
        
        informMyopiaButton.translatesAutoresizingMaskIntoConstraints = false
        informMyopiaButton.widthAnchor.constraint(equalTo: myopiaView.widthAnchor, multiplier: 4/5).isActive = true
        informMyopiaButton.bottomAnchor.constraint(equalTo: myopiaView.bottomAnchor, constant: -10).isActive = true
        informMyopiaButton.centerXAnchor.constraint(equalTo: myopiaView.centerXAnchor).isActive = true
        informMyopiaButton.heightAnchor.constraint(equalTo: myopiaView.heightAnchor, multiplier: 1/5).isActive = true
        
        informMyopiaButton.backgroundColor = .white
        informMyopiaButton.layer.cornerRadius = 20
        
        informMyopiaButton.layer.shadowColor = UIColor.lightGray.cgColor
        informMyopiaButton.layer.shadowOpacity = 0.1
        
        informMyopiaButton.setImage("ℹ️".image(size: size), for: .normal)
        informMyopiaButton.setTitle("Информация и инструкции", for: .normal)
        informMyopiaButton.titleLabel?.textAlignment = .center
        informMyopiaButton.titleLabel?.numberOfLines = 0
        informMyopiaButton.setTitleColor(.systemBlue, for: .normal)
        
        informMyopiaButton.addTarget(self, action: #selector(infoButtonMyopAction), for: .touchUpInside)
        
    }
    
    func addHyperopiaViewSubviews() {
        hyperopiaView.addSubview(startHyperopiaView)
        hyperopiaView.addSubview(informHyperopiaButton)
        hyperopiaView.addSubview(hyperopiaResultButton)
        
        startHyperopiaView.translatesAutoresizingMaskIntoConstraints = false
        startHyperopiaView.widthAnchor.constraint(equalTo: hyperopiaView.widthAnchor, multiplier: 4/5).isActive = true
        startHyperopiaView.heightAnchor.constraint(equalTo: hyperopiaView.heightAnchor, multiplier: 1/2).isActive = true
        startHyperopiaView.centerXAnchor.constraint(equalTo: hyperopiaView.centerXAnchor).isActive = true
        startHyperopiaView.topAnchor.constraint(equalTo: hyperopiaView.topAnchor, constant: 10).isActive = true
        
        startHyperopiaView.backgroundColor = #colorLiteral(red: 0.912041011, green: 0.9828456094, blue: 1, alpha: 1)
        startHyperopiaView.layer.cornerRadius = 20
        
        startHyperopiaView.layer.shadowColor = UIColor.gray.cgColor
        startHyperopiaView.layer.shadowOpacity = 0.1
        
//        let tapStart = UITapGestureRecognizer(target: self, action: #selector(startHyperopiaViewAction))
//        startHyperopiaView.isUserInteractionEnabled = true
//        startHyperopiaView.addGestureRecognizer(tapStart)
        
        startHyperopiaView.addSubview(eyeHypView)
        eyeHypView.translatesAutoresizingMaskIntoConstraints = false
        eyeHypView.widthAnchor.constraint(equalTo: startHyperopiaView.widthAnchor, multiplier: 2/3).isActive = true
        eyeHypView.heightAnchor.constraint(equalTo: startHyperopiaView.heightAnchor, multiplier: 2/3).isActive = true
        eyeHypView.centerXAnchor.constraint(equalTo: startHyperopiaView.centerXAnchor).isActive = true
        eyeHypView.topAnchor.constraint(equalTo: hyperopiaView.topAnchor, constant: 0).isActive = true
        eyeHypView.backgroundColor = .clear
        
        eyeHypView.addSubview(hyperopiaLight)
        hyperopiaLight.translatesAutoresizingMaskIntoConstraints = false
        hyperopiaLight.widthAnchor.constraint(equalTo: eyeHypView.widthAnchor, multiplier: 1).isActive = true
        hyperopiaLight.heightAnchor.constraint(equalTo: eyeHypView.heightAnchor, multiplier: 1).isActive = true
        hyperopiaLight.centerXAnchor.constraint(equalTo: eyeHypView.centerXAnchor).isActive = true
        hyperopiaLight.topAnchor.constraint(equalTo: eyeHypView.topAnchor, constant: 0).isActive = true
        
        hyperopiaLight.backgroundColor = .clear
        
        let startButton = UIButton()
        startHyperopiaView.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.widthAnchor.constraint(equalTo: startHyperopiaView.widthAnchor, multiplier: 5/5).isActive = true
        startButton.heightAnchor.constraint(equalTo: startHyperopiaView.heightAnchor, multiplier: 1/3).isActive = true
        startButton.centerXAnchor.constraint(equalTo: startHyperopiaView.centerXAnchor).isActive = true
        startButton.bottomAnchor.constraint(equalTo: startHyperopiaView.bottomAnchor).isActive = true

        let size = CGSize(width: 50, height: 50)
        startButton.setImage("✅".image(size: size), for: .normal)
        startButton.setTitle("Тест на наличие дальнозоркости", for: .normal)
        startButton.titleLabel?.textAlignment = .center
        startButton.titleLabel?.numberOfLines = 0
        
        startButton.backgroundColor = .white
        startButton.layer.cornerRadius = 20
        
        startButton.layer.shadowColor = UIColor.lightGray.cgColor
        startButton.layer.shadowOpacity = 0.1

        startButton.setTitleColor(.systemBlue, for: .normal)
        startButton.addTarget(self, action: #selector(startHyperopiaViewAction), for: .touchUpInside)
        
        hyperopiaResultButton.translatesAutoresizingMaskIntoConstraints = false
        hyperopiaResultButton.leftAnchor.constraint(equalTo: startHyperopiaView.leftAnchor, constant: 0).isActive = true
        hyperopiaResultButton.topAnchor.constraint(equalTo: startHyperopiaView.bottomAnchor, constant: 10).isActive = true
        hyperopiaResultButton.bottomAnchor.constraint(equalTo: informHyperopiaButton.topAnchor, constant: -10).isActive = true
        hyperopiaResultButton.rightAnchor.constraint(equalTo: startHyperopiaView.rightAnchor, constant: 0).isActive = true
        //hyperopiaResultButton.setImage(UIImage(named: "folder"), for: .normal)
        
        hyperopiaResultButton.setImage("📁".image(size: size), for: .normal)
        hyperopiaResultButton.setTitle("Результаты теста дальнозоркости", for: .normal)
        
        hyperopiaResultButton.titleLabel?.numberOfLines = 0
        hyperopiaResultButton.titleLabel?.textAlignment = .center
        hyperopiaResultButton.setTitleColor(.systemBlue, for: .normal)
        hyperopiaResultButton.backgroundColor = .white
        hyperopiaResultButton.layer.shadowColor = UIColor.gray.cgColor
        hyperopiaResultButton.layer.shadowOpacity = 0.1
        hyperopiaResultButton.layer.cornerRadius = 20
        hyperopiaResultButton.addTarget(self, action: #selector(hyperopiaResultButtonAction), for: .touchUpInside)
        
        informHyperopiaButton.translatesAutoresizingMaskIntoConstraints = false
        informHyperopiaButton.widthAnchor.constraint(equalTo: hyperopiaView.widthAnchor, multiplier: 4/5).isActive = true
        informHyperopiaButton.heightAnchor.constraint(equalTo: hyperopiaView.heightAnchor, multiplier: 1/5).isActive = true
        informHyperopiaButton.centerXAnchor.constraint(equalTo: hyperopiaView.centerXAnchor).isActive = true
        informHyperopiaButton.bottomAnchor.constraint(equalTo: hyperopiaView.bottomAnchor, constant: -10).isActive = true
        
        informHyperopiaButton.backgroundColor = .white
        informHyperopiaButton.layer.cornerRadius = 20
        
        informHyperopiaButton.layer.shadowColor = UIColor.gray.cgColor
        informHyperopiaButton.layer.shadowOpacity = 0.1

        informHyperopiaButton.setTitleColor(.systemBlue, for: .normal)
        informHyperopiaButton.titleLabel?.textAlignment = .center
        informHyperopiaButton.titleLabel?.numberOfLines = 0
        informHyperopiaButton.setImage("ℹ️".image(size: size), for: .normal)
        informHyperopiaButton.setTitle("Информация и инструкции", for: .normal)
        informHyperopiaButton.addTarget(self, action: #selector(infoButtonHyperAction), for: .touchUpInside)
    }
    
    @objc func leftSwipeAnimate() {

        UIView.animate(withDuration: 0.3, animations: {
            self.hyperopiaView.transform = CGAffineTransform.init(translationX: -(self.hyperopiaView.frame.width+5), y: 0)
            self.myopiaView.transform = CGAffineTransform.init(translationX: -(self.hyperopiaView.frame.width+5), y: 0)
            self.hyperopiaView.backgroundColor = #colorLiteral(red: 0.912041011, green: 0.9828456094, blue: 1, alpha: 1)
            //self.myopiaView.backgroundColor = .red
        }) { (_) in
            
            self.hyperopiaView.layer.shadowOpacity = 0.1
            self.hyperopiaView.layer.shadowColor = UIColor.black.cgColor
        }
    }
    
    @objc func rightSwipeAnimate() {

        UIView.animate(withDuration: 0.3, animations: {
            self.myopiaView.transform = CGAffineTransform.init(translationX: (0), y: 0)
            self.hyperopiaView.transform = CGAffineTransform.init(translationX: (0), y: 0)
            //self.hyperopiaView.backgroundColor = .green
            self.myopiaView.backgroundColor = #colorLiteral(red: 0.912041011, green: 0.9828456094, blue: 1, alpha: 1)
        }) { (_) in

        }
    }
    
    @objc func settingsViewAction(){
        let settingsVC = SettingsTableViewController()
        self.navigationController?.pushViewController(settingsVC, animated: false)
    }
    
    @objc func myopiaResultButtonAction(){
        let resVC = ResultsTableViewController()
        resVC.state = "Miopia"
        self.navigationController?.pushViewController(resVC, animated: false)
    }
    
    @objc func hyperopiaResultButtonAction(){
        let resVC = ResultsTableViewController()
        resVC.state = "Hyperopia"
        self.navigationController?.pushViewController(resVC, animated: false)
    }
    
    @objc func userImageViewAction(){
        let userVC = UserViewController()
        
        self.navigationController?.pushViewController(userVC, animated: false)
    }
    
    @objc func startMyopiaViewAction(){
        let startVC = MiopiaViewController()
        let startVCGood = MiopiaAvtoDistanceViewController()
        if speechRecognBool{
            self.navigationController?.pushViewController(startVCGood, animated: false)
        }else{
            self.navigationController?.pushViewController(startVC, animated: false)
        }
    }
    
    @objc func startHyperopiaViewAction(){
        let startVC = HyperopiaViewController()
        let startVCGood = HyperopiaSpeechViewController()
        if speechRecognBool{
            self.navigationController?.pushViewController(startVCGood, animated: false)
        }else{
            self.navigationController?.pushViewController(startVC, animated: false)
        }
    }
    
    @objc func infoButtonMyopAction(){
        let infoVC = InfoStartViewController()
        self.navigationController?.pushViewController(infoVC, animated: false)
    }
    @objc func infoButtonHyperAction(){
        let infoVC = InfoHyperopiaViewController()
        self.navigationController?.pushViewController(infoVC, animated: false)
    }
    
}
