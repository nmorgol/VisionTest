

import UIKit
import CoreData
import Speech

class SettingsTableViewController: UITableViewController, UITextFieldDelegate, SFSpeechRecognizerDelegate {
    
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru_RU"))!
    
    let purchasesCellID = "PurchasesCell"
    let userCellID = "UserCell"
    let settingsCellID = "SettingsCell"
    let symbolCellId = "SymbolCell"
    let userInfoImageView = UIImageView()
    
    var name = ""
    var photo = Data()
    var userInfoText = "info"
    let otstup = "   "
    
    var avtoDetectDistBool = false
    var speechRecognBool = false
    var distanceTest = Float(0.5)
    var timeToStart = Float(0)
    var symbolTest = "Snellen"
    
    var labelTextField = UITextField()
    var coverView = UIView()
    var settingTextLabelTag = Int()
    let labelForTextField = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        self.tabBarItem = tabBarItem
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(actionSave))
        
        self.tableView.register(PurchasesTableViewCell.self, forCellReuseIdentifier: purchasesCellID)
        self.tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: settingsCellID)
        self.tableView.register(UserTableViewCell.self, forCellReuseIdentifier: userCellID)
        self.tableView.register(SymbolTableViewCell.self, forCellReuseIdentifier: symbolCellId)
        
        
        
        tableView.tableFooterView = UIView()
        
        labelTextField.delegate = self
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapTableView(recognizer:)))
//        self.view.addGestureRecognizer(tap)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let image = UIImage(named: "placeholder")?.pngData()!
        do {
            let resultUser = try context.fetch(User.fetchRequest())
            let resCurrentUser = try context.fetch(CurrentUser.fetchRequest())
            let settings = try context.fetch(SettingsApp.fetchRequest())
            
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
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
                
                cell2.settingLabel.text = otstup + "AvtoDetectDistance"
                cell2.settingSwitch.addTarget(self, action: #selector(avtodetectSwitchAction(paramSwitch:)), for: .valueChanged)
                cell2.settingSwitch.isOn = avtoDetectDistBool
                cell2.accessoryType = .detailButton
                
            }else{
                cell2.settingLabel.text = otstup + "SpeechRecognition"
                cell2.settingSwitch.addTarget(self, action: #selector(speechSwitchAction(paramSwitch:)), for: .valueChanged)
                cell2.settingSwitch.isOn = speechRecognBool
                cell2.accessoryType = .detailButton
            }
//            cell2.accessoryType = .detailButton
            cell = cell2
            return cell
            
        }
        else if indexPath.section == 2{
            
            if indexPath.row == 0{
                let cell3 = tableView.dequeueReusableCell(withIdentifier: settingsCellID, for: indexPath) as! SettingsTableViewCell
                cell3.settingLabel.text = otstup + "Set distance for test "
                cell3.deteilLabel.text = "m."
                cell3.accessoryType = .detailButton
                cell3.settingTextLabel.text = "\(distanceTest)"
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(labelDistTextAction(_:)))
                tap.numberOfTapsRequired = 1
                cell3.settingTextLabel.isUserInteractionEnabled = true
                cell3.settingTextLabel.addGestureRecognizer(tap)
                
                cell = cell3
                
            }else if indexPath.row == 1{
                let cell3 = tableView.dequeueReusableCell(withIdentifier: settingsCellID, for: indexPath) as! SettingsTableViewCell
                cell3.settingLabel.text = otstup + "Set time before start"
                cell3.deteilLabel.text = "s."
                cell3.accessoryType = .detailButton
                cell3.settingTextLabel.text = "\(timeToStart)"
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(labelTimeTextAction(_:)))
                tap.numberOfTapsRequired = 1
                cell3.settingTextLabel.isUserInteractionEnabled = true
                cell3.settingTextLabel.addGestureRecognizer(tap)
                
                cell = cell3
                
            }else if indexPath.row == 2{
                let cell3 = tableView.dequeueReusableCell(withIdentifier: symbolCellId, for: indexPath) as! SymbolTableViewCell
                
                cell3.settingsLabel.text = otstup + "Set symbol "
//                cell3.symbolSegment.selectedSegmentIndex = 0
                cell3.symbolSegment.addTarget(self, action: #selector(segmetAction), for: .valueChanged)

                if cell3.symbolView.isEqual(cell3.landolt){
                    symbolTest = "Landolt"
                }else{symbolTest = "Snellen"}
                cell3.backgroundColor = .white
                
                cell = cell3
            }
            
            return cell
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return " "
        case 1:
            return "In-app purchases settings"
        case 2:
            return "Myopia settings"
        default:
            break
        }
        return "11"
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
                accessoryButtonAction(title: "AvtoDetectDistance")
            }else{
               accessoryButtonAction(title: "SpeechRecognize")
            }
        case 2:
            if indexPath.row == 0{
                accessoryButtonAction(title: "DistanceTest")
            }else{
                accessoryButtonAction(title: "TimeBeforeTest")
            }
        default:
            print("default")
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
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func removeCoverImage(recognizer: UITapGestureRecognizer){
        userInfoImageView.removeFromSuperview()
        self.navigationController?.navigationBar.isHidden = false
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
    }
     
    @objc func labelDistTextAction(_ sender: UILabel){
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
        
        distanceTest = Float(labelTextField.text!) ?? (0.5)
        labelTextField.text = ""
        labelTextField.resignFirstResponder()
        labelTextField.removeFromSuperview()
        coverView.removeFromSuperview()
        tableView.reloadData()
    }
    
    @objc func labelTimeTextAction(_ sender: UILabel){
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
        
        timeToStart = Float(labelTextField.text!) ?? (0)
        labelTextField.text = ""
        labelTextField.resignFirstResponder()
        labelForTextField.removeFromSuperview()
        labelTextField.removeFromSuperview()
        coverView.removeFromSuperview()
        tableView.reloadData()
    }
    
//    @objc func removeCoverImage(recognizer: UITapGestureRecognizer){
//        userInfoImageView.removeFromSuperview()
//        self.navigationController?.navigationBar.isHidden = false
//        self.tabBarController?.tabBar.isHidden = false
//    }
    
//    @objc func infoButtonAction(){
//        let infoVC = InfoViewController()
//        self.navigationController?.pushViewController(infoVC, animated: false)
//    }
    
    @objc func accessoryButtonAction(title: String){
        let infoVC = InfoViewController()
        infoVC.title = title
        self.navigationController?.pushViewController(infoVC, animated: false)
    }
}

