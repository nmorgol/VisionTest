

import UIKit

class StartViewController: UIViewController {

    let userView = UIView()
    let userImageView = UIImageView()
    let userNameLabel = UILabel()
    let userInfoTextView = UITextView()
    
    
    var avtoDetectDistBool = false
    var speechRecognBool = false
    var distanceTest = Float(0.5)
    var timeToStart = Float(0)
    var symbolTest = "Snellen"
    
    var name = "name"
    var photo = Data()
    
    let settingsView = UIView()
    let settingsLabel = UILabel()
    let settingsButton = UIButton()
    
    let myopiaView = UIView()
    let startMyopiaView = UIView()
    let informMyopiaView = UIView()
    let myopiaResultButton = UIButton()
    
    let hyperopiaView = UIView()
    let startHyperopiaView = UIView()
    let informHyperopiaView = UIView()
    let hyperopiaResultButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.6561266184, green: 0.9085168242, blue: 0.9700091481, alpha: 1)
        addUserView()
        addSettingsView()
        addMyopiaView()
        addHyperopiaView()
        
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
            
            if resCurrentUser.count > 0 {
                let curUser = (resCurrentUser.last as! CurrentUser).currentUser
                name = (resultUser[Int(curUser)] as! User).name ?? ""
                photo = ((resultUser[Int(curUser)] as! User).photo) ?? image!
            }
            else{
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
            
        } catch let error as NSError {
            print(error)
        }
        
        addUserSubviews()
        
        addMyopiaViewSubviews()
        addHyperopiaViewSubviews()
        addSettingsSubviews()
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
    }
    
    
    func addMyopiaView() {
        view.addSubview(myopiaView)
        myopiaView.translatesAutoresizingMaskIntoConstraints = false
        myopiaView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10).isActive = true
        myopiaView.topAnchor.constraint(equalTo: userView.bottomAnchor, constant: 5).isActive = true
        myopiaView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myopiaView.bottomAnchor.constraint(equalTo: settingsView.topAnchor, constant: -5).isActive = true
        
        myopiaView.backgroundColor = .white
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
        
        hyperopiaView.backgroundColor = .green
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
        
    }
    
    func addUserSubviews(){
        userView.addSubview(userImageView)
        userView.addSubview(userNameLabel)
//        userView.addSubview(myopiaResultButton)
//        userView.addSubview(hyperopiaResultButton)
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
        
//        myopiaResultButton.translatesAutoresizingMaskIntoConstraints = false
//        myopiaResultButton.leftAnchor.constraint(equalTo: userView.leftAnchor, constant: 10).isActive = true
//        myopiaResultButton.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 10).isActive = true
//        myopiaResultButton.bottomAnchor.constraint(equalTo: userView.bottomAnchor, constant: -10).isActive = true
//        myopiaResultButton.rightAnchor.constraint(equalTo: userView.centerXAnchor, constant: -5).isActive = true
//
//        myopiaResultButton.setTitle("Результаты теста близорукости", for: .normal)
//
//        myopiaResultButton.titleLabel?.numberOfLines = 0
//        myopiaResultButton.titleLabel?.textAlignment = .center
//        myopiaResultButton.setTitleColor(.systemBlue, for: .normal)
//        myopiaResultButton.backgroundColor = .white
//        myopiaResultButton.layer.shadowColor = UIColor.gray.cgColor
//        myopiaResultButton.layer.shadowOpacity = 0.1
//        myopiaResultButton.layer.cornerRadius = 10
//        myopiaResultButton.addTarget(self, action: #selector(myopiaResultButtonAction), for: .touchUpInside)
//
//        hyperopiaResultButton.translatesAutoresizingMaskIntoConstraints = false
//        hyperopiaResultButton.leftAnchor.constraint(equalTo: userView.centerXAnchor, constant: 5).isActive = true
//        hyperopiaResultButton.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 10).isActive = true
//        hyperopiaResultButton.bottomAnchor.constraint(equalTo: userView.bottomAnchor, constant: -10).isActive = true
//        hyperopiaResultButton.rightAnchor.constraint(equalTo: userView.rightAnchor, constant: -10).isActive = true
//
//        hyperopiaResultButton.setTitle("Результаты теста дальнозоркости", for: .normal)
//        hyperopiaResultButton.titleLabel?.numberOfLines = 0
//        hyperopiaResultButton.titleLabel?.textAlignment = .center
//        hyperopiaResultButton.setTitleColor(.systemBlue, for: .normal)
//        hyperopiaResultButton.backgroundColor = .white
//        hyperopiaResultButton.layer.shadowColor = UIColor.gray.cgColor
//        hyperopiaResultButton.layer.shadowOpacity = 0.1
//        hyperopiaResultButton.layer.cornerRadius = 10
//        hyperopiaResultButton.addTarget(self, action: #selector(hyperopiaResultButtonAction), for: .touchUpInside)
    }
    
    func addSettingsSubviews(){
        settingsView.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.centerYAnchor.constraint(equalTo: settingsView.centerYAnchor).isActive = true
        settingsButton.centerXAnchor.constraint(equalTo: settingsView.centerXAnchor).isActive = true
        settingsButton.widthAnchor.constraint(equalTo: settingsView.widthAnchor, multiplier: 4/5).isActive = true
        settingsButton.heightAnchor.constraint(equalTo: settingsView.heightAnchor, multiplier: 3/5).isActive = true
        
         
        settingsButton.backgroundColor = .white
        settingsButton.layer.cornerRadius = 10

        
        settingsButton.layer.shadowColor = UIColor.gray.cgColor
        settingsButton.layer.shadowOpacity = 0.1
        

        settingsButton.titleLabel?.numberOfLines = 0
        settingsButton.titleLabel?.textColor = .systemBlue
        settingsButton.titleLabel?.textAlignment = .center
        
        settingsButton.setImage(UIImage(named: "settingsIcon"), for: .normal)
        settingsButton.setTitle("Установите оптимальные настройки приложения", for: .normal)
        settingsButton.setTitleColor(.systemBlue, for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsViewAction), for: .touchUpInside)
        
    }
    
    func addMyopiaViewSubviews() {
        myopiaView.addSubview(startMyopiaView)
        myopiaView.addSubview(informMyopiaView)
        myopiaView.addSubview(myopiaResultButton)
        
        startMyopiaView.translatesAutoresizingMaskIntoConstraints = false
        startMyopiaView.widthAnchor.constraint(equalTo: myopiaView.widthAnchor, multiplier: 4/5).isActive = true
        startMyopiaView.heightAnchor.constraint(equalTo: myopiaView.heightAnchor, multiplier: 1/2).isActive = true
        startMyopiaView.centerXAnchor.constraint(equalTo: myopiaView.centerXAnchor).isActive = true
        startMyopiaView.topAnchor.constraint(equalTo: myopiaView.topAnchor, constant: 10).isActive = true
        
        startMyopiaView.backgroundColor = .white
        startMyopiaView.layer.cornerRadius = 20
        
        startMyopiaView.layer.shadowColor = UIColor.gray.cgColor
        startMyopiaView.layer.shadowOpacity = 0.1
        
        let tapStart = UITapGestureRecognizer(target: self, action: #selector(startMyopiaViewAction))
        startMyopiaView.isUserInteractionEnabled = true
        startMyopiaView.addGestureRecognizer(tapStart)
        
        let startButton = UIButton()
        startMyopiaView.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.widthAnchor.constraint(equalTo: startMyopiaView.widthAnchor, multiplier: 4/5).isActive = true
        startButton.heightAnchor.constraint(equalTo: startMyopiaView.heightAnchor, multiplier: 3/5).isActive = true
        startButton.centerXAnchor.constraint(equalTo: startMyopiaView.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: startMyopiaView.centerYAnchor).isActive = true
        
        startButton.setTitle("Тест на наличие близорукости", for: .normal)
        startButton.titleLabel?.textAlignment = .center
        startButton.titleLabel?.numberOfLines = 0
        
        startButton.setTitleColor(.systemBlue, for: .normal)
        
        myopiaResultButton.translatesAutoresizingMaskIntoConstraints = false
        myopiaResultButton.leftAnchor.constraint(equalTo: startMyopiaView.leftAnchor, constant: 0).isActive = true
        myopiaResultButton.topAnchor.constraint(equalTo: startMyopiaView.bottomAnchor, constant: 10).isActive = true
        myopiaResultButton.bottomAnchor.constraint(equalTo: informMyopiaView.topAnchor, constant: -10).isActive = true
        myopiaResultButton.rightAnchor.constraint(equalTo: startMyopiaView.rightAnchor, constant: 0).isActive = true
        myopiaResultButton.setImage(UIImage(named: "folder"), for: .normal)
        myopiaResultButton.setTitle("Результаты теста близорукости", for: .normal)
        
        myopiaResultButton.titleLabel?.numberOfLines = 0
        myopiaResultButton.titleLabel?.textAlignment = .center
        myopiaResultButton.setTitleColor(.systemBlue, for: .normal)
        myopiaResultButton.backgroundColor = .white
        myopiaResultButton.layer.shadowColor = UIColor.gray.cgColor
        myopiaResultButton.layer.shadowOpacity = 0.1
        myopiaResultButton.layer.cornerRadius = 10
        myopiaResultButton.addTarget(self, action: #selector(myopiaResultButtonAction), for: .touchUpInside)
        
        informMyopiaView.translatesAutoresizingMaskIntoConstraints = false
        informMyopiaView.widthAnchor.constraint(equalTo: myopiaView.widthAnchor, multiplier: 4/5).isActive = true
        informMyopiaView.bottomAnchor.constraint(equalTo: myopiaView.bottomAnchor, constant: -10).isActive = true
        informMyopiaView.centerXAnchor.constraint(equalTo: myopiaView.centerXAnchor).isActive = true
        informMyopiaView.heightAnchor.constraint(equalTo: myopiaView.heightAnchor, multiplier: 1/5).isActive = true
        
        informMyopiaView.backgroundColor = .white
        informMyopiaView.layer.cornerRadius = 20
        
        informMyopiaView.layer.shadowColor = UIColor.gray.cgColor
        informMyopiaView.layer.shadowOpacity = 0.1
        
        let infoLabel = UILabel()
        informMyopiaView.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.widthAnchor.constraint(equalTo: informMyopiaView.widthAnchor, multiplier: 4/5).isActive = true
        infoLabel.heightAnchor.constraint(equalTo: informMyopiaView.heightAnchor, multiplier: 3/5).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: informMyopiaView.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: informMyopiaView.centerYAnchor).isActive = true
        infoLabel.text = "Информация"
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        infoLabel.font = .boldSystemFont(ofSize: 17)
        
    }
    
    func addHyperopiaViewSubviews() {
        hyperopiaView.addSubview(startHyperopiaView)
        hyperopiaView.addSubview(informHyperopiaView)
        hyperopiaView.addSubview(hyperopiaResultButton)
        
        startHyperopiaView.translatesAutoresizingMaskIntoConstraints = false
        startHyperopiaView.widthAnchor.constraint(equalTo: hyperopiaView.widthAnchor, multiplier: 4/5).isActive = true
        startHyperopiaView.heightAnchor.constraint(equalTo: hyperopiaView.heightAnchor, multiplier: 1/2).isActive = true
        startHyperopiaView.centerXAnchor.constraint(equalTo: hyperopiaView.centerXAnchor).isActive = true
        startHyperopiaView.topAnchor.constraint(equalTo: hyperopiaView.topAnchor, constant: 10).isActive = true
        
        startHyperopiaView.backgroundColor = .white
        startHyperopiaView.layer.cornerRadius = 20
        
        startHyperopiaView.layer.shadowColor = UIColor.gray.cgColor
        startHyperopiaView.layer.shadowOpacity = 0.1
        
        let tapStart = UITapGestureRecognizer(target: self, action: #selector(startHyperopiaViewAction))
        startHyperopiaView.isUserInteractionEnabled = true
        startHyperopiaView.addGestureRecognizer(tapStart)
        
        let startButton = UIButton()
        startHyperopiaView.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.widthAnchor.constraint(equalTo: startHyperopiaView.widthAnchor, multiplier: 4/5).isActive = true
        startButton.heightAnchor.constraint(equalTo: startHyperopiaView.heightAnchor, multiplier: 3/5).isActive = true
        startButton.centerXAnchor.constraint(equalTo: startHyperopiaView.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: startHyperopiaView.centerYAnchor).isActive = true
        
        startButton.setTitle("Тест на наличие дальнозоркости", for: .normal)
        startButton.titleLabel?.textAlignment = .center
        startButton.titleLabel?.numberOfLines = 0
        
        startButton.setTitleColor(.systemBlue, for: .normal)
        
        hyperopiaResultButton.translatesAutoresizingMaskIntoConstraints = false
        hyperopiaResultButton.leftAnchor.constraint(equalTo: startHyperopiaView.leftAnchor, constant: 0).isActive = true
        hyperopiaResultButton.topAnchor.constraint(equalTo: startHyperopiaView.bottomAnchor, constant: 10).isActive = true
        hyperopiaResultButton.bottomAnchor.constraint(equalTo: informHyperopiaView.topAnchor, constant: -10).isActive = true
        hyperopiaResultButton.rightAnchor.constraint(equalTo: startHyperopiaView.rightAnchor, constant: 0).isActive = true
        hyperopiaResultButton.setImage(UIImage(named: "folder"), for: .normal)
        hyperopiaResultButton.setTitle("Результаты теста дальнозоркости", for: .normal)
        
        hyperopiaResultButton.titleLabel?.numberOfLines = 0
        hyperopiaResultButton.titleLabel?.textAlignment = .center
        hyperopiaResultButton.setTitleColor(.systemBlue, for: .normal)
        hyperopiaResultButton.backgroundColor = .white
        hyperopiaResultButton.layer.shadowColor = UIColor.gray.cgColor
        hyperopiaResultButton.layer.shadowOpacity = 0.1
        hyperopiaResultButton.layer.cornerRadius = 10
        hyperopiaResultButton.addTarget(self, action: #selector(hyperopiaResultButtonAction), for: .touchUpInside)
        
        informHyperopiaView.translatesAutoresizingMaskIntoConstraints = false
        informHyperopiaView.widthAnchor.constraint(equalTo: hyperopiaView.widthAnchor, multiplier: 4/5).isActive = true
        informHyperopiaView.heightAnchor.constraint(equalTo: hyperopiaView.heightAnchor, multiplier: 1/5).isActive = true
        informHyperopiaView.centerXAnchor.constraint(equalTo: hyperopiaView.centerXAnchor).isActive = true
        informHyperopiaView.bottomAnchor.constraint(equalTo: hyperopiaView.bottomAnchor, constant: -10).isActive = true
        
        informHyperopiaView.backgroundColor = .white
        informHyperopiaView.layer.cornerRadius = 20
        
        informHyperopiaView.layer.shadowColor = UIColor.gray.cgColor
        informHyperopiaView.layer.shadowOpacity = 0.1
        
        let infoLabel = UILabel()
        informHyperopiaView.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.widthAnchor.constraint(equalTo: informHyperopiaView.widthAnchor, multiplier: 4/5).isActive = true
        infoLabel.heightAnchor.constraint(equalTo: informHyperopiaView.heightAnchor, multiplier: 3/5).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: informHyperopiaView.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: informHyperopiaView.centerYAnchor).isActive = true
        infoLabel.text = "Информация"
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        infoLabel.font = .boldSystemFont(ofSize: 17)
        
    }
    
    @objc func leftSwipeAnimate() {
//        myopiaView.backgroundColor = .red
//        hyperopiaView.backgroundColor = .green
        UIView.animate(withDuration: 0.3, animations: {
            self.hyperopiaView.transform = CGAffineTransform.init(translationX: -(self.hyperopiaView.frame.width+5), y: 0)
            self.myopiaView.transform = CGAffineTransform.init(translationX: -(self.hyperopiaView.frame.width+5), y: 0)
            self.hyperopiaView.backgroundColor = .white
            self.myopiaView.backgroundColor = .red
        }) { (_) in
            //self.hyperopiaView.
            self.hyperopiaView.layer.shadowOpacity = 0.1
            self.hyperopiaView.layer.shadowColor = UIColor.black.cgColor
        }
    }
    
    @objc func rightSwipeAnimate() {
//        myopiaView.backgroundColor = .red
//        hyperopiaView.backgroundColor = .green
        UIView.animate(withDuration: 0.3, animations: {
            self.myopiaView.transform = CGAffineTransform.init(translationX: (0), y: 0)
            self.hyperopiaView.transform = CGAffineTransform.init(translationX: (0), y: 0)
            self.hyperopiaView.backgroundColor = .green
            self.myopiaView.backgroundColor = .white
        }) { (_) in
//            self.myopiaView.backgroundColor = .white
//            self.hyperopiaView.backgroundColor = .green
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
    
    
}
