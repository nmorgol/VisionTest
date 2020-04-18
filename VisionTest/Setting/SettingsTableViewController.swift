

import UIKit
import CoreData
import Speech

class SettingsTableViewController: UITableViewController, UITextFieldDelegate, SFSpeechRecognizerDelegate {
    
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru_RU"))!
    
    let purchasesCellID = "PurchasesCell"
    let userCellID = "UserCell"
    let settingsCellID = "SettingsCell"
    let symbolCellId = "SymbolCell"
    let cellIAPurchasesID = "cellID"
    
    let userInfoImageView = UIImageView()
    
    var name = ""
    var photo = Data()
    var userInfoText = "info"
    let otstup = "   "
    
    var avtoDetectDistBool = false
    var speechRecognBool = false
    var distanceTest = Float(4.0)
    var timeToStart = Float(0)
    var symbolTest = "Snellen"
    
    var labelTextField = UITextField()
    var coverView = UIView()
    var settingTextLabelTag = Int()
    let labelForTextField = UILabel()
    
    let lock1 = LockUIView()
    let lock2 = LockUIView()
    
    var iapAutoDetectDistance = false
    var iapSpeechRecognition = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.6561266184, green: 0.9085168242, blue: 0.9700091481, alpha: 1)
//        let tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
//        self.tabBarItem = tabBarItem
        
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(actionSave))
        
        self.tableView.register(PurchasesTableViewCell.self, forCellReuseIdentifier: purchasesCellID)
        self.tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: settingsCellID)
        self.tableView.register(UserTableViewCell.self, forCellReuseIdentifier: userCellID)
        self.tableView.register(SymbolTableViewCell.self, forCellReuseIdentifier: symbolCellId)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIAPurchasesID)
        
        tableView.tableFooterView = UIView()
        
        labelTextField.delegate = self
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapTableView(recognizer:)))
//        self.view.addGestureRecognizer(tap)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        
//        self.navigationController?.navigationBar.isHidden = false
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let image = UIImage(named: "placeholder")?.pngData()!
        do {
            let resultUser = try context.fetch(User.fetchRequest())
            let resCurrentUser = try context.fetch(CurrentUser.fetchRequest())
            let settings = try context.fetch(SettingsApp.fetchRequest())
            let iap = try context.fetch(InAppPurchases.fetchRequest())
            
            if iap.count > 0{
                iapSpeechRecognition = (iap.last as! InAppPurchases).speechRecognition
                iapAutoDetectDistance = (iap.last as! InAppPurchases).autoDetectDistance
                
                print(iapSpeechRecognition)
                
            }
            
            if resCurrentUser.count > 0 {
                let curUser = (resCurrentUser.last as! CurrentUser).currentUser
                name = (resultUser[Int(curUser)] as! User).name ?? ""
                userInfoText = (resultUser[Int(curUser)] as! User).info ?? "info"
                print(curUser)
                photo = ((resultUser[Int(curUser)] as! User).photo) ?? image!}
            else{
                name = "name"
                userInfoText = "info"
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
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(false)
//        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 3
        case 3:
            return 1
        default:
            break
        }
        return 0
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0 {
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: userCellID, for: indexPath) as! UserTableViewCell
            cell1.userPhotoImageView.image = UIImage(data: photo)//UIImage(named: "placeholder")
            let gestureUserPhotoView = UITapGestureRecognizer(target: self, action: #selector(tapGestureUserInfoAction(tapGestureRecognizer:)))
            cell1.userPhotoImageView.addGestureRecognizer(gestureUserPhotoView)
            gestureUserPhotoView.numberOfTapsRequired = 1
            cell1.userPhotoImageView.isUserInteractionEnabled = true
            
            cell1.userNameLabel.text = name
            cell1.userInfoLabel.text = userInfoText
            cell1.userInfoLabel.isUserInteractionEnabled = true

            cell1.accessoryBtn.addTarget(self, action: #selector(userCellAction), for: .touchUpInside)
            
            cell = cell1
            return cell
            
        }
            
        else if indexPath.section == 1{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: purchasesCellID, for: indexPath) as! PurchasesTableViewCell
            if indexPath.row == 0{
                
                cell2.settingLabel.text = otstup + "Автоопределение расстояния"
                cell2.settingLabel.numberOfLines = 0
                cell2.settingLabel.textAlignment = .center
                cell2.settingSwitch.addTarget(self, action: #selector(avtodetectSwitchAction(paramSwitch:)), for: .valueChanged)
                cell2.settingSwitch.isOn = avtoDetectDistBool
                cell2.accessoryType = .detailButton
                
                if !iapAutoDetectDistance{
                    cell2.settingSwitch.addSubview(lock1)
                    lock1.translatesAutoresizingMaskIntoConstraints = false
                    lock1.heightAnchor.constraint(equalTo: cell2.heightAnchor, multiplier: 1).isActive = true
                    lock1.widthAnchor.constraint(equalTo: lock1.heightAnchor, multiplier: 1).isActive = true
                    lock1.leftAnchor.constraint(equalTo: cell2.settingSwitch.leftAnchor).isActive = true
                    lock1.centerYAnchor.constraint(equalTo: cell2.settingSwitch.centerYAnchor).isActive = true
                    lock1.backgroundColor = .white
                    lock1.alpha = 0.5
                    cell2.settingSwitch.isEnabled = false
                }else{
                    lock1.removeFromSuperview()
                    cell2.settingSwitch.isEnabled = true
                }
                
            }else{
                cell2.settingLabel.text = otstup + "Распознавание речи"
                cell2.settingLabel.numberOfLines = 0
                cell2.settingLabel.textAlignment = .center
                cell2.settingSwitch.addTarget(self, action: #selector(speechSwitchAction(paramSwitch:)), for: .valueChanged)
                cell2.settingSwitch.isOn = speechRecognBool
                cell2.accessoryType = .detailButton
                
                if !iapSpeechRecognition{
                    cell2.settingSwitch.addSubview(lock2)
                    lock2.translatesAutoresizingMaskIntoConstraints = false
                    lock2.heightAnchor.constraint(equalTo: cell2.heightAnchor, multiplier: 1).isActive = true
                    lock2.widthAnchor.constraint(equalTo: lock2.heightAnchor, multiplier: 1).isActive = true
                    lock2.leftAnchor.constraint(equalTo: cell2.settingSwitch.leftAnchor).isActive = true
                    lock2.centerYAnchor.constraint(equalTo: cell2.settingSwitch.centerYAnchor).isActive = true
                    lock2.backgroundColor = .white
                    lock2.alpha = 0.5
                    cell2.settingSwitch.isEnabled = false
                }else{
                    lock2.removeFromSuperview()
                    cell2.settingSwitch.isEnabled = true
                }
                
            }
//            cell2.accessoryType = .detailButton
            cell = cell2
            
            return cell
            
        }
        else if indexPath.section == 2{
            
            if indexPath.row == 0{
                let cell3 = tableView.dequeueReusableCell(withIdentifier: settingsCellID, for: indexPath) as! SettingsTableViewCell
                cell3.settingLabel.text = otstup + "Установите дистанцию теста "
                cell3.settingLabel.numberOfLines = 0
                cell3.settingLabel.textAlignment = .center
                cell3.deteilLabel.text = "m."
                cell3.accessoryType = .detailButton
                cell3.settingTextLabel.text = "\(distanceTest)"
                cell3.settingTextLabel.textColor = .systemBlue
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(labelDistTextAction(_:)))
                tap.numberOfTapsRequired = 1
                cell3.settingTextLabel.isUserInteractionEnabled = true
                cell3.settingTextLabel.addGestureRecognizer(tap)
                
                cell = cell3
                
            }else if indexPath.row == 1{
                let cell3 = tableView.dequeueReusableCell(withIdentifier: settingsCellID, for: indexPath) as! SettingsTableViewCell
                cell3.settingLabel.text = otstup + "Установите время до старта теста"
                cell3.settingLabel.numberOfLines = 0
                cell3.settingLabel.textAlignment = .center
                cell3.deteilLabel.text = "s."
                cell3.accessoryType = .detailButton
                cell3.settingTextLabel.text = "\(timeToStart)"
                cell3.settingTextLabel.textColor = .systemBlue
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(labelTimeTextAction(_:)))
                tap.numberOfTapsRequired = 1
                cell3.settingTextLabel.isUserInteractionEnabled = true
                cell3.settingTextLabel.addGestureRecognizer(tap)
                
                cell = cell3
                
            }else if indexPath.row == 2{
                let cell3 = tableView.dequeueReusableCell(withIdentifier: symbolCellId, for: indexPath) as! SymbolTableViewCell
                
                cell3.settingsLabel.text = otstup + "Выберите символ "
                cell3.settingsLabel.numberOfLines = 0
                cell3.settingsLabel.textAlignment = .center
//                cell3.symbolSegment.selectedSegmentIndex = 0
                cell3.symbolSegment.addTarget(self, action: #selector(segmetAction), for: .valueChanged)

                if cell3.symbolView.isEqual(cell3.landolt){
                    symbolTest = "Landolt"
                }else{symbolTest = "Snellen"}
                cell3.backgroundColor = .white
                
                cell = cell3
            }
            return cell
            
        }else if indexPath.section == 3{
            let cell4 = tableView.dequeueReusableCell(withIdentifier: cellIAPurchasesID, for: indexPath)
            cell4.textLabel?.text = "Покупки"
            cell4.accessoryType = .disclosureIndicator
            cell = cell4
            return cell
        }
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//        case 0:
//            return "Информация о пользователе"
//        case 1:
//            return "Настройки приложения"
//        case 2:
//            return "Настройки теста близорукости"
//        case 3:
//            return "Встроенные покупки"
//        default:
//            break
//        }
//        return "11"
//    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label : UILabel = UILabel()
        label.textColor = .white
        label.backgroundColor = .systemBlue
        switch section {
        case 0:
            label.text = "Информация о пользователе"
        case 1:
            label.text = "Настройки приложения"
        case 2:
            label.text = "Настройки теста зрения вдаль"
        case 3:
            label.text = "Встроенные покупки"
        default:
            break
        }
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = CGFloat()
        if  indexPath.section == 0{
            height = 150
        } else {
            height = 50
        }
        return height
    }
    

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print(0)
        case 1:
            if indexPath.row == 0{
                accessoryButtonAction(title: "Автоопределение расстояния")
            }else{
               accessoryButtonAction(title: "Распознавание речи")
            }
        case 2:
            if indexPath.row == 0{
                accessoryButtonAction(title: "Дистанция теста")
            }else{
                accessoryButtonAction(title: "Время до начала теста")
            }
        default:
            print("default")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3{
            if indexPath.row == 0{
                let vc = IAPurchTableViewController()
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    
    
   
    @objc func actionSave() {
        
        let appDelegat = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegat.persistentContainer.viewContext
        
        do {
            let result = try context.fetch(SettingsApp.fetchRequest())
            
            for res in result{
                context.delete(res as! NSManagedObject)
            }

            try? context.save()
            
        } catch let error as NSError {
            print(error)
        }
        let settingsNew = SettingsApp(context: context)
        settingsNew.setValue(avtoDetectDistBool, forKey: "avtoDetectDistance")
        settingsNew.setValue(speechRecognBool, forKey: "speechRecognize")
        

        settingsNew.setValue(distanceTest, forKey: "distanceTest")
        settingsNew.setValue(timeToStart, forKey: "timeBeforeTest")
        settingsNew.setValue(symbolTest, forKey: "symbolTest")
        
        do {
            try context.save()
        }catch let error as NSError{
            print(error)
        }
    }
    
    @objc func tapGestureUserPhotoAction(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let vc = CameraViewController()
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    @objc func tapGestureUserInfoAction(tapGestureRecognizer: UITapGestureRecognizer){
        self.view.addSubview(userInfoImageView)
        userInfoImageView.translatesAutoresizingMaskIntoConstraints = false
        userInfoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        userInfoImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        userInfoImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        userInfoImageView.image = UIImage(data: photo)
        userInfoImageView.contentMode = .scaleAspectFit
        userInfoImageView.backgroundColor = .white
        userInfoImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeCoverImage))
        userInfoImageView.addGestureRecognizer(tap)
        //self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func removeCoverImage(recognizer: UITapGestureRecognizer){
        userInfoImageView.removeFromSuperview()
        //self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }

    
    @objc func segmetAction() {
        tableView.reloadData()
        
    }
    
    @objc func userCellAction(){
        let userVC = UserViewController()
        self.navigationController?.pushViewController(userVC, animated: false)
    }
    
    @objc func avtodetectSwitchAction(paramSwitch: UISwitch){
        if paramSwitch.isOn{
            avtoDetectDistBool = true
            
        }else{
            avtoDetectDistBool = false
        }
        actionSave()
    }
    
    @objc func speechSwitchAction(paramSwitch: UISwitch){
        if paramSwitch.isOn{
            speechRecognBool = true
            
            speechRecognizer.delegate = self
            SFSpeechRecognizer.requestAuthorization { authStatus in

                // Divert to the app's main thread so that the UI
                // can be updated.
                OperationQueue.main.addOperation {
                    switch authStatus {
                    case .authorized:
//
                        print(true)
                    case .denied:

                        print("User denied access to speech recognition")
                    case .restricted:

                        print("Speech recognition restricted on this device")
                    case .notDetermined:

                        print("Speech recognition not yet authorized")
                    default:
                        print(false)
                    }
                }
            }
        }else{
            speechRecognBool = false
        }
        actionSave()
    }
     
    @objc func labelDistTextAction(_ sender: UILabel){
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(coverView)
        coverView.addSubview(labelTextField)
        coverView.addSubview(labelForTextField)
        
        coverView.translatesAutoresizingMaskIntoConstraints = false
        coverView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        coverView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        coverView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        coverView.backgroundColor = .white
        coverView.isOpaque = true
        coverView.alpha = 0.95
        
        labelTextField.translatesAutoresizingMaskIntoConstraints = false
        labelTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4).isActive = true
        labelTextField.heightAnchor.constraint(equalTo: labelTextField.widthAnchor, multiplier: 1/3).isActive = true
        labelTextField.centerXAnchor.constraint(equalTo: coverView.centerXAnchor).isActive = true
        labelTextField.centerYAnchor.constraint(equalTo: coverView.centerYAnchor).isActive = true
        labelTextField.backgroundColor = .systemGray4
        labelTextField.keyboardType = .decimalPad
        labelTextField.textAlignment = .center
        labelTextField.becomeFirstResponder()
        
        labelForTextField.translatesAutoresizingMaskIntoConstraints = false
        labelForTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4).isActive = true
        labelForTextField.heightAnchor.constraint(equalTo: labelTextField.widthAnchor, multiplier: 1/3).isActive = true
        labelForTextField.centerXAnchor.constraint(equalTo: coverView.centerXAnchor).isActive = true
        labelForTextField.bottomAnchor.constraint(equalTo: labelTextField.topAnchor).isActive = true
        labelForTextField.backgroundColor = .clear
        labelForTextField.text = "Установите расстояние для теста - м."
        labelForTextField.font = .systemFont(ofSize: 13)
        labelForTextField.textAlignment = .center
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(resingFirstREspDist))
        coverView.isUserInteractionEnabled = true
        coverView.addGestureRecognizer(tap)
        
        labelTextField.delegate = self
        

    }
    
    
    @objc func resingFirstREspDist(){
        self.navigationController?.navigationBar.isHidden = false
        distanceTest = Float(labelTextField.text!) ?? (4.0)
        labelTextField.text = ""
        labelTextField.resignFirstResponder()
        labelTextField.removeFromSuperview()
        coverView.removeFromSuperview()
        tableView.reloadData()
        actionSave()
    }
    
    @objc func labelTimeTextAction(_ sender: UILabel){
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(coverView)
        coverView.addSubview(labelTextField)
        coverView.addSubview(labelForTextField)
        
        coverView.translatesAutoresizingMaskIntoConstraints = false
        coverView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        coverView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        coverView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        coverView.backgroundColor = .white
        coverView.isOpaque = true
        coverView.alpha = 0.95
        
        labelTextField.translatesAutoresizingMaskIntoConstraints = false
        labelTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4).isActive = true
        labelTextField.heightAnchor.constraint(equalTo: labelTextField.widthAnchor, multiplier: 1/3).isActive = true
        labelTextField.centerXAnchor.constraint(equalTo: coverView.centerXAnchor).isActive = true
        labelTextField.centerYAnchor.constraint(equalTo: coverView.centerYAnchor).isActive = true
        labelTextField.backgroundColor = .systemGray4
        labelTextField.keyboardType = .decimalPad
        labelTextField.textAlignment = .center
        
        labelTextField.becomeFirstResponder()
        
        labelForTextField.translatesAutoresizingMaskIntoConstraints = false
        labelForTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4).isActive = true
        labelForTextField.heightAnchor.constraint(equalTo: labelTextField.widthAnchor, multiplier: 1/3).isActive = true
        labelForTextField.centerXAnchor.constraint(equalTo: coverView.centerXAnchor).isActive = true
        labelForTextField.bottomAnchor.constraint(equalTo: labelTextField.topAnchor).isActive = true
        labelForTextField.backgroundColor = .clear
        labelForTextField.text = "Установите время до начала теста - сек."
        labelForTextField.font = .systemFont(ofSize: 13)
        
        labelForTextField.textAlignment = .center
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(resingFirstREspTime))
        coverView.isUserInteractionEnabled = true
        coverView.addGestureRecognizer(tap)
        
        labelTextField.delegate = self
    }
    @objc func resingFirstREspTime(){
        self.navigationController?.navigationBar.isHidden = false
        timeToStart = Float(labelTextField.text!) ?? (5.0)
        labelTextField.text = ""
        labelTextField.resignFirstResponder()
        labelForTextField.removeFromSuperview()
        labelTextField.removeFromSuperview()
        coverView.removeFromSuperview()
        tableView.reloadData()
        actionSave()
    }
    
    
    @objc func accessoryButtonAction(title: String){
        let infoVC = InfoViewController()
        infoVC.title = title
        self.navigationController?.pushViewController(infoVC, animated: false)
    }
}

