

import UIKit
import CoreData

class MiopiaViewController: UIViewController {
    
    let startLabel = UILabel()
    let startTestButton = UIButton()
    let goToInfoButton = UIButton()
    let canselForeverButton = UIButton()
    var canselStartLabel = Bool()
    
    var rezRightEye = Float()
    var rezLeftEye = Float()
    
    let helpSymbolView = UIView()//для символа
    let helpWorkView = UIView()//для кнопок
    let deviceNameLabel = UILabel()
    let distanceLabel = UILabel()
    var distance = Float(4)//расстояние для первого запуска
    //кнопки
    let topButton = UIButton()
    let bottomButton = UIButton()
    let rightButton = UIButton()
    let leftButton = UIButton()
    let centralButton = UIButton()
    
    let rightSnellenView = SnellenRightView()
    let leftSnellenView = SnellenLeftView()
    let topSnellenView = SnellenTopView()
    let bottomSnellenView = SnellenBottomView()
    
    let rightLandoltView = LandoltRightUIView()
    let leftLandoltView = LandoltLeftUIView()
    let topLandoltView = LandoltTopUIView()
    let bottomLandoltView = LandoltBottomUIView()
    
    
    var viewArray = [UIView]()
    var workViewArray = [UIView]()
    var currentView = UIView()
    
    var koef = Float()//коэфициент рассчета размера символа
    var counter = Float(1)//счетчик нажатий
    
    var wrongCounter = Float(0)//считаем неправильные результаты
    var superWrong = Float(0)//счетчик неправильных нажатий итогового принятия решения
    var visualAcuity = Float()//острота зрения
    
    var currentEye = ""
    
    var disapearTrue = true//подпорка для того чтобы не отрабатывал метод self.navigationController?.popViewController(animated: false)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var locale = "en_US"
    let myopiaText = MyopiaAvtoDistanceText()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        
        //disapearTrue = true // для того чтобы можно было зайти в результ VC
        
        viewArray = [rightLandoltView, leftLandoltView, topLandoltView, bottomLandoltView]
        
        koef = ((UIDevice.modelWidth)/70)*5/4//0.5 //(70) - 70мм для (5) - расстояние 5м , а 0.5 - расстояние теста == 4м итого размер символа должен быть 7мм
        // MARK: - CoreData
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let resultSettings = try context.fetch(SettingsApp.fetchRequest())
            
            if resultSettings.count > 0 {
                distance = (resultSettings.last as! SettingsApp).distanceTest
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
            let canselInfo = try context.fetch(CanselInstruction.fetchRequest())
            canselStartLabel = (canselInfo.last as! CanselInstruction).myopiaLightCansel
            //print("значение \(canselInfo)")
            
        } catch let error as NSError {
            print(error)
        }
        
        
        workViewArray = viewArray
        
        currentView = workViewArray.randomElement()!
        
        addHelpSymbolView()
        addHelpWorkView()
        addButton()
        addDeviceNameLabel()
        addDistanceLabel()
        addLandoltSnellenView(addingView: currentView, koef: koef)
//        addStartLabel()
//        deleteStartLabel()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(false)
//        startAlert()
        addStartLabel()
        deleteStartLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(true)
        
        currentView.removeFromSuperview()
        //        koef = (UIDevice.modelWidth)/50
        counter = Float(1)//сбросили счетчик - при следующ загрузке вью размер символа будет начальным
        if disapearTrue{
            self.navigationController?.popViewController(animated: false)
        }
        
    }
    
    
    func addStartLabel(){
        
        self.view.addSubview(startLabel)
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        startLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        startLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        //startLabel.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        startLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        startLabel.text = myopiaText.startLabelText[locale]
        startLabel.textAlignment = .center
        startLabel.numberOfLines = 0
        startLabel.textColor = .black
        startLabel.font = .systemFont(ofSize: 30)
        startLabel.backgroundColor = .white
        //startLabel.alpha = 0.8
        startLabel.isUserInteractionEnabled = true
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(tapGestureRecognizer:)))
//        startLabel.addGestureRecognizer(tap)
        
        topButton.isEnabled = false
        bottomButton.isEnabled = false
        leftButton.isEnabled = false
        rightButton.isEnabled = false
        centralButton.isEnabled = false
        
        startLabel.addSubview(canselForeverButton)
        let text1: String = myopiaText.canselForeverButtonTitle[locale] ?? "Больше не показывать это окно"
        canselForeverButton.setTitle(text1, for: .normal)
        canselForeverButton.titleLabel?.numberOfLines = 0
        canselForeverButton.titleLabel?.textAlignment = .center
        canselForeverButton.setTitleColor(.systemBlue, for: .normal)
        canselForeverButton.backgroundColor = .white
        canselForeverButton.addTarget(self, action: #selector(canselForeverButtonAction), for: .touchUpInside)
        canselForeverButton.layer.shadowColor = UIColor.lightGray.cgColor
        canselForeverButton.layer.shadowOpacity = 0.1
        
        
        canselForeverButton.translatesAutoresizingMaskIntoConstraints = false
        canselForeverButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        canselForeverButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: 60).isActive = true
        canselForeverButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/17).isActive = true
        canselForeverButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        startLabel.addSubview(startTestButton)
        let text2:String = myopiaText.startLabelText[locale] ?? "Начать тест"
        startTestButton.setTitle(text2, for: .normal)
        startTestButton.setTitleColor(.systemBlue, for: .normal)
        startTestButton.addTarget(self, action: #selector(tapAction(tapGestureRecognizer:)), for: .touchUpInside)
        startTestButton.backgroundColor = .white
        startTestButton.layer.shadowColor = UIColor.lightGray.cgColor
        startTestButton.layer.shadowOpacity = 0.1
        
        startTestButton.translatesAutoresizingMaskIntoConstraints = false
        startTestButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        startTestButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: 50).isActive = true
        startTestButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/20).isActive = true
        startTestButton.bottomAnchor.constraint(equalTo: canselForeverButton.topAnchor, constant: -15).isActive = true
        
        startLabel.addSubview(goToInfoButton)
        let text3:String = myopiaText.goToInfoButtonTitle[locale] ?? "К инструкции"
        goToInfoButton.setTitle(text3, for: .normal)
        goToInfoButton.setTitleColor(.systemBlue, for: .normal)
        goToInfoButton.addTarget(self, action: #selector(goToInfoButtonAction), for: .touchUpInside)
        goToInfoButton.backgroundColor = .white
        goToInfoButton.layer.shadowColor = UIColor.lightGray.cgColor
        goToInfoButton.layer.shadowOpacity = 0.1
        
        goToInfoButton.translatesAutoresizingMaskIntoConstraints = false
        goToInfoButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        goToInfoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: 50).isActive = true
        goToInfoButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/20).isActive = true
        goToInfoButton.bottomAnchor.constraint(equalTo: canselForeverButton.topAnchor, constant: -15).isActive = true
        
        
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
            buttonArray[i].addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
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
        centralButton.removeTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        centralButton.addTarget(self, action: #selector(centralButtonAction), for: .touchUpInside)
    }
    
    func addDeviceNameLabel() {
        helpWorkView.addSubview(deviceNameLabel)
        deviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        deviceNameLabel.leftAnchor.constraint(equalTo: helpWorkView.leftAnchor).isActive = true
        deviceNameLabel.widthAnchor.constraint(equalTo: helpWorkView.widthAnchor, multiplier: 1/3).isActive = true
        deviceNameLabel.heightAnchor.constraint(equalTo: helpWorkView.heightAnchor, multiplier: 1/9).isActive = true
        deviceNameLabel.bottomAnchor.constraint(equalTo: helpWorkView.bottomAnchor).isActive = true
        
        deviceNameLabel.numberOfLines = 0
        deviceNameLabel.text = "Device detected:  " + UIDevice.modelName
        deviceNameLabel.font = .boldSystemFont(ofSize: 10)
        deviceNameLabel.textAlignment = .center
    }
    func addDistanceLabel() {
        helpWorkView.addSubview(distanceLabel)
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.leftAnchor.constraint(equalTo: helpWorkView.leftAnchor).isActive = true
        distanceLabel.widthAnchor.constraint(equalTo: helpWorkView.widthAnchor, multiplier: 1/3).isActive = true
        distanceLabel.heightAnchor.constraint(equalTo: helpWorkView.heightAnchor, multiplier: 1/9).isActive = true
        distanceLabel.bottomAnchor.constraint(equalTo: deviceNameLabel.topAnchor).isActive = true
        
        distanceLabel.numberOfLines = 0
        distanceLabel.text = "Distance set:  " + "\(distance)" + "m"
        distanceLabel.font = .boldSystemFont(ofSize: 10)
        distanceLabel.textAlignment = .center
    }
    
    func addLandoltSnellenView(addingView:UIView, koef: Float) {
        helpSymbolView.addSubview(addingView)
        addingView.translatesAutoresizingMaskIntoConstraints = false
        addingView.centerYAnchor.constraint(equalTo: helpSymbolView.centerYAnchor).isActive = true
        addingView.centerXAnchor.constraint(equalTo: helpSymbolView.centerXAnchor).isActive = true
        addingView.widthAnchor.constraint(equalTo: helpSymbolView.widthAnchor, multiplier: CGFloat(1/koef)).isActive = true
        addingView.heightAnchor.constraint(equalTo: helpSymbolView.heightAnchor, multiplier: CGFloat(1/koef)).isActive = true
    }
    
    @objc func buttonAction(sender: UIButton) {
        var helpInt = Int()
        for i in 0 ... workViewArray.count-1{
            if workViewArray[i].isEqual(currentView){
                helpInt = i
            }
        }
        if sender.tag == helpInt {//если угадал символ
            currentView.removeFromSuperview()
            currentView = workViewArray.randomElement()!
            
            counter += 1
            let koeficient = koef*counter
            
            wrongCounter = 0
            
            addLandoltSnellenView(addingView: currentView, koef: koeficient)
        }
//        else{//если не угадал символ
//
//            if currentEye == "Right eye"{
//                saveResult()
//                addStartLabel()
//                canselForeverButton.removeFromSuperview()
//                startTestButton.removeFromSuperview()
//                goToInfoButton.removeFromSuperview()
//                startLabel.text = "Тест завершен. \nРезультат правый глаз: \(rezRightEye)\nРезультат левый глаз: \(rezLeftEye) "
//                startLabel.font = .systemFont(ofSize: 17)
//
//            }else{
//                wrongAnswer()
//            }
//        }
    }
    
    @objc func centralButtonAction(){
        saveResult()
        wrongCounter = 1//для срабатывания метода wrongAnswer()
        superWrong = 1//для срабатывания метода wrongAnswer()
        if currentEye == "Right eye"{
            
            addStartLabel()
            canselForeverButton.removeFromSuperview()
//            startTestButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//            goToInfoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            startTestButton.removeFromSuperview()
            goToInfoButton.removeFromSuperview()
            let text1:String = myopiaText.startLabelText1[locale] ?? " "
            let text2:String = myopiaText.startLabelText2[locale] ?? " "
            startLabel.text = text1 + "\(rezRightEye)" + text2 + "\(rezLeftEye)"
            //startLabel.text = "Тест завершен. \nРезультат правый глаз: \(rezRightEye)\nРезультат левый глаз: \(rezLeftEye) "
            startLabel.font = .systemFont(ofSize: 17)
        }else{
            wrongAnswer()
            
        }
    }
    
    @objc func tapAction(tapGestureRecognizer: UITapGestureRecognizer){
        startLabel.removeFromSuperview()
        topButton.isEnabled = true
        bottomButton.isEnabled = true
        leftButton.isEnabled = true
        rightButton.isEnabled = true
        centralButton.isEnabled = true
        
        startAlert()
    }
    
    @objc func goToInfoButtonAction(){
        
        let vc = InfoStartViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
        
        
        vc.navigationController?.title = "Информация и инструкции"
        vc.navigationController?.view.backgroundColor = .blue
        vc.state = true
        
        let navVC = UINavigationController(rootViewController: vc)
        navVC.view.backgroundColor = .blue
        navVC.view.alpha = 1
        
        let goBackItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(navAction))//(title: "Закрыть", style: .done, target: self, action: #selector(navAction))
        
        navVC.navigationItem.rightBarButtonItem = goBackItem
        navVC.navigationItem.title = "Информация и инструкции"
        //navVC.title = "Информация и инструкции"
        self.present(navVC, animated: false, completion: nil)
        //self.dismiss(animated: true, completion: nil)
        //startLabel.removeFromSuperview()
    }
    
    
    func saveResult(){
        do{
            let resultUser = try context.fetch(User.fetchRequest())
            let resCurrentUser = try context.fetch(CurrentUser.fetchRequest())
            if resCurrentUser.count > 0{
                let curUserNum = (resCurrentUser.last as! CurrentUser).currentUser
                let curUser = (resultUser[Int(curUserNum)] as! User)
                let result = MiopiaTestResult(context: context)
                
                result.distance = distance
                result.result = (counter-1)/10
                result.dateTest = Date()
                if currentEye == "Left eye"{
                    result.testingEye = "Правый глаз"
                    rezRightEye = (counter-1)/10
                }else if currentEye == "Right eye"{
                    result.testingEye = "Левый глаз"
                    rezLeftEye = (counter-1)/10
                }
                
                curUser.addToRelationship(result)
                
                try context.save()
            }
            
        }catch let error as NSError {
            print(error)
        }
    }
    
    func wrongAnswer(){
        wrongCounter += 1
        if wrongCounter == 2{
            wrongCounter = 0
            
            superWrong += 1
            print(superWrong)
            if superWrong == 2{
                self.currentView.removeFromSuperview()
                let text1:String = myopiaText.alert1_1[locale] ?? "тест завершен"
                let text2:String = myopiaText.alert1_2[locale] ?? "тострота зрения равна:"
                
                let alertContr = UIAlertController(title: text1, message: text2+"\((counter-1)/10)", preferredStyle: .alert)
                let alertAct = UIAlertAction(title: "ok", style: .default) { (action) in
                    self.counter = 1
                    self.wrongCounter = 0
                    self.superWrong = 0
                    
                    self.currentView = self.workViewArray.randomElement()!
                    
                    let koeficient = self.koef*self.counter
                    
                    self.addLandoltSnellenView(addingView: self.currentView, koef: koeficient)
                    //self.saveResult()
                    self.startAlert()
                    
                }
                alertContr.addAction(alertAct)
                self.present(alertContr, animated: true, completion: nil)
            }else{
                currentView.removeFromSuperview()
                currentView = workViewArray.randomElement()!
                
                if counter > 1{
                    counter -= 1
                }
                
                let koeficient = koef*counter
                
                addLandoltSnellenView(addingView: currentView, koef: koeficient)
            }
            
        }else{
            currentView.removeFromSuperview()
            currentView = workViewArray.randomElement()!
            
            let koeficient = koef*counter
            
            addLandoltSnellenView(addingView: currentView, koef: koeficient)
        }
    }
    
    func startAlert(){
        if currentEye == "Right eye"{
            currentEye = "Left eye"
            
        }else if currentEye == "Left eye"{
            currentEye = "Right eye"
            
        }else{
            currentEye = "Left eye"
        }
        createStartAlert()
    }
    
    func createStartAlert(){
        var eye = ""
        let text1:String = myopiaText.leftEye[locale] ?? "левый глаз"
        let text2:String = myopiaText.rightEye[locale] ?? "правый глаз"
        let text3:String = myopiaText.close[locale] ?? "Закройте"
        
        if currentEye == "Right eye"{
            eye = text2
            
        }else if currentEye == "Left eye"{
            eye = text1
            
        }
        
        let alert = UIAlertController(title: "", message: text3 + " \(eye)", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok", style: .default) { (action) in
            print("ok")
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteStartLabel(){
        if canselStartLabel{
            startLabel.removeFromSuperview()
            topButton.isEnabled = true
            bottomButton.isEnabled = true
            leftButton.isEnabled = true
            rightButton.isEnabled = true
            centralButton.isEnabled = true
            startAlert()
        }
    }
    @objc func canselForeverButtonAction(){
        let newCansel = CanselInstruction(context: context)
        
        newCansel.setValue(true, forKey: "myopiaLightCansel")
        
        do {
            try context.save()
        }catch let error as NSError{
            print(error)
        }
        
        startLabel.removeFromSuperview()
        topButton.isEnabled = true
        bottomButton.isEnabled = true
        leftButton.isEnabled = true
        rightButton.isEnabled = true
        centralButton.isEnabled = true
        startAlert()
    }
    
    @objc func navAction(){
        self.dismiss(animated: false, completion: nil)
    }
    
}
