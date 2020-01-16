

import UIKit
import CoreData

class MiopiaViewController: UIViewController {
    
    let helpSymbolView = UIView()//для символа
    let helpWorkView = UIView()//для кнопок
    let deviceNameLabel = UILabel()
    let distanceLabel = UILabel()
    var distance = Float(0.5)//расстояние для первого запуска
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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Miopia test"
        self.navigationItem.title = "Miopia test"
        self.view.backgroundColor = .white
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Results", style: .plain, target: self, action: #selector(actionResults))
        
        viewArray = [rightLandoltView, leftLandoltView, topLandoltView, bottomLandoltView]
        
        koef = ((UIDevice.modelWidth)/70)*5/0.5 //(70) - 70мм для (5) - расстояние 5м , а 0.5 - расстояние теста == 0.5м итого размер символа должен быть 7мм
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        // MARK: - CoreData
        
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(true)
        currentView.removeFromSuperview()
        //        koef = (UIDevice.modelWidth)/50
        counter = Float(1)//сбросили счетчик - при следующ загрузке вью размер символа будет начальным
    }
    //метод self.navigationItem.leftBarButtonItem
    @objc func actionResults() {
        let resultVC = ResultsTableViewController()
        resultVC.title = "Miopia test results"
        resultVC.state = "Miopia"
        self.navigationController?.pushViewController(resultVC, animated: true)
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
        }else{//если не угадал символ
            
//            wrongCounter += 1
//            if wrongCounter == 2{
//                wrongCounter = 0
//
//                superWrong += 1
//                print(superWrong)
//                if superWrong == 2{
//                    let alertContr = UIAlertController(title: "тест завершен", message: "острота зрения равна:\((counter-1)/10)", preferredStyle: .alert)
//                    let alertAct = UIAlertAction(title: "ok", style: .default) { (action) in
//                        self.counter = 1
//                        self.wrongCounter = 0
//                        self.superWrong = 0
//                        self.currentView.removeFromSuperview()
//                        self.currentView = self.workViewArray.randomElement()!
//
//                        let koeficient = self.koef*self.counter
//
//                        self.addLandoltSnellenView(addingView: self.currentView, koef: koeficient)
//                    }
//                    alertContr.addAction(alertAct)
//                    self.present(alertContr, animated: true, completion: nil)
//                }else{
//                    currentView.removeFromSuperview()
//                    currentView = workViewArray.randomElement()!
//
//                    if counter > 1{
//                        counter -= 1
//                    }
//
//                    let koeficient = koef*counter
//
//                    addLandoltSnellenView(addingView: currentView, koef: koeficient)
//                }
//
//            }else{
//                currentView.removeFromSuperview()
//                currentView = workViewArray.randomElement()!
//
//                let koeficient = koef*counter
//
//                addLandoltSnellenView(addingView: currentView, koef: koeficient)
//            }
            wrongAnswer()
        }
        
    }
    
    @objc func centralButtonAction(){
        saveResult()
        wrongCounter = 1
        superWrong = 1
        wrongAnswer()
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
                let alertContr = UIAlertController(title: "тест завершен", message: "острота зрения равна:\((counter-1)/10)", preferredStyle: .alert)
                let alertAct = UIAlertAction(title: "ok", style: .default) { (action) in
                    self.counter = 1
                    self.wrongCounter = 0
                    self.superWrong = 0
                    self.currentView.removeFromSuperview()
                    self.currentView = self.workViewArray.randomElement()!
                    
                    let koeficient = self.koef*self.counter
                    
                    self.addLandoltSnellenView(addingView: self.currentView, koef: koeficient)
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
    
    
}
