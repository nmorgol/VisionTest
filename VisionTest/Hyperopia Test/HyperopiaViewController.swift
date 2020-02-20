

import UIKit

import CoreData

class HyperopiaViewController: UIViewController {
    
    var currentText = String()
    
    var wordLabel = UILabel()
    var reciveTextField = UITextField()
    var authorizedLabel = UILabel()
    var eyeLabel = UILabel()
    let progress = UIProgressView()
    let stopButton = UIButton()
    
    var startFontCounter = 1//счетчик уменьшения размера шрифта
    var fontSize = 47.0//Float(47)//методом подбора = острота зрения 0.1
    
    var inputText = String()
    
    var timer: Timer!
    var timerCounter = 0
    var stopBool = true // для работы таймера от слова СТОП
    let stopLabel = UILabel()//всплывает по слову СТОП
    
    var rightRes = Float()
    var leftRes = Float()
    
    var animateCounter = Int(1)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hyperopia test"
        self.view.backgroundColor = .white
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        //disapearTrue = true
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        addEyeLabel(text: "Закройте левый глаз")
        
        addWordLabel()
        addStopButton()
        addProgressView()
        addReciveTextLabel()
        
        
        animatedEyeLabel()
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(true)

        timer.invalidate()
    }
    
    
//    @objc func actionResults() {
//        //disapearTrue = false
//        let resultVC = ResultsTableViewController()
//        resultVC.title = "Hyperopia test results"
//        resultVC.state = "Hyperopia"
//        self.navigationController?.pushViewController(resultVC, animated: true)
//    }
    
    
    // MARK: View
    func addWordLabel() {
        view.addSubview(wordLabel)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/5).isActive = true
        wordLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/15).isActive = true
        
        wordLabel.text = inputText
        wordLabel.textAlignment = .center
        //wordLabel.font = .italicSystemFont(ofSize: CGFloat(fontSize))
        
        wordLabel.numberOfLines = 0
        
    }
    
    func addStopButton() {
        view.addSubview(stopButton)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.centerYAnchor.constraint(equalTo: wordLabel.centerYAnchor).isActive = true
        stopButton.leftAnchor.constraint(equalTo: wordLabel.rightAnchor).isActive = true
        stopButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        stopButton.heightAnchor.constraint(equalTo: wordLabel.heightAnchor).isActive = true
        
        stopButton.setTitle("❌", for: .normal)
        stopButton.backgroundColor = .white
        stopButton.layer.cornerRadius = 10
        stopButton.layer.shadowOpacity = 0.1
        stopButton.layer.shadowColor = UIColor.lightGray.cgColor
        stopButton.addTarget(self, action: #selector(stopButtonAction), for: .touchUpInside)
    }
    
    func addProgressView() {
        view.addSubview(progress)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.topAnchor.constraint(equalTo: wordLabel.bottomAnchor).isActive = true
        progress.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        progress.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progress.progressViewStyle = .default
        
    }
    
    func addReciveTextLabel() {
        view.addSubview(reciveTextField)
        reciveTextField.translatesAutoresizingMaskIntoConstraints = false
        reciveTextField.topAnchor.constraint(equalTo: progress.bottomAnchor, constant: 5).isActive = true
        reciveTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reciveTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        reciveTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/15).isActive = true
        
        reciveTextField.textAlignment = .center
        reciveTextField.font = .boldSystemFont(ofSize: CGFloat(40))
        
        reciveTextField.backgroundColor = .lightGray
        
        reciveTextField.keyboardType = .numberPad
        reciveTextField.becomeFirstResponder()
    }
    
    
    func addEyeLabel(text: String){
        view.addSubview(eyeLabel)
        eyeLabel.translatesAutoresizingMaskIntoConstraints = false
        eyeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        eyeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //eyeLabel.centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor).isActive = true
        eyeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        eyeLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
        eyeLabel.font = .boldSystemFont(ofSize: 30)
        eyeLabel.text = text//"Закройте левый глаз"
        eyeLabel.textColor = .blue
        eyeLabel.textAlignment = .center
        eyeLabel.numberOfLines = 0
    }

    func addStopLabel(){
        
        self.view.addSubview(stopLabel)
        stopLabel.translatesAutoresizingMaskIntoConstraints = false
        stopLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stopLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stopLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/4).isActive = true
        stopLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 3/4).isActive = true

        stopLabel.backgroundColor = .white
        stopLabel.numberOfLines = 0
        
        
        stopLabel.text = "Тест завершен. \n Результаты: \n - правый глаз \(rightRes) \n - левый глаз \(leftRes)"

        stopLabel.isUserInteractionEnabled = true
//        let tap = UITapGestureRecognizer(target: self, action: #selector(stopLabelGestureAction))
//        stopLabel.addGestureRecognizer(tap)
 
    }
    
    func compareString(str1: String, str2: String) -> Bool {
        var boolCompare = false
        //let second1 = Array(str1)
        let second2 = Array(str2)
        
        if second2.count == 0 {//пришел как-то 0 и краш
            boolCompare = false
        }else{
            if str2.contains(str1){
                boolCompare = true
            }
        }
        return boolCompare
    }

    @objc func timerAction() {
        
        if stopBool == false {
            
            progress.setProgress(0.1*Float(Int(timerCounter)%10) + 0.1, animated: false)
            
            if timerCounter == 0 || timerCounter%10 == 0{
                
                inputText = String(Int.random(in: 100...999))
                print(inputText)
                reciveTextField.text = ""
                //wordLabel.font = .boldSystemFont(ofSize: CGFloat(fontSize))
                wordLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(fontSize))//вроде шрифт подобрал
                wordLabel.text = inputText
                
                print(fontSize)
                
            }else if ((timerCounter + 1)%10 == 0)  {
                
                if reciveTextField.text != nil{
                    if compareString(str1: inputText, str2: reciveTextField.text!){
                        
                        startFontCounter += 1
                        fontSize = (47.0/Double(startFontCounter))
                        
                    }
                }
                
                reciveTextField.text = ""
                inputText = ""
            }
            
            timerCounter += 1
        }
    }
    
    @objc func stopButtonAction() {
        if stopButton.currentTitle == "❌"{
            stopBool = true
            //timer.invalidate()
            timerCounter = 0
            
            saveResult()//надо до сброса счетчика ставить
            
            
            
            if eyeLabel.text == "Закройте левый глаз"{//надо до сброса счетчика ставить
                rightRes = ((Float(startFontCounter)-1.0)/10.0)
            }else if eyeLabel.text == "Закройте правый глаз"{
                leftRes = ((Float(startFontCounter)-1.0)/10.0)
            }
            
            startFontCounter = 1//сброс счетчика
            fontSize = 47.0/Double(startFontCounter)
            
            if eyeLabel.text == "Закройте левый глаз"{//надо до сброса счетчика ставить
                eyeLabel.text = "Закройте правый глаз"
            }else if eyeLabel.text == "Закройте правый глаз"{
                
                reciveTextField.resignFirstResponder()
                addStopLabel()
            }
            
            
            
            stopButton.setTitle( "✅", for: .normal)
        }else if stopButton.currentTitle == "✅"{
            stopButton.setTitle( "❌", for: .normal)
            
            animatedEyeLabel()
            //stopBool = false
            //timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
        
    }
    
    
    func saveResult(){
            
            do{
                let resultUser = try context.fetch(User.fetchRequest())
                let resCurrentUser = try context.fetch(CurrentUser.fetchRequest())
                if resCurrentUser.count > 0{
                    let curUserNum = (resCurrentUser.last as! CurrentUser).currentUser
                    let curUser = (resultUser[Int(curUserNum)] as! User)
                    let result = HyperopiaTestResult(context: context)
    //                print("результат", ((startFontCounter-1)/10))
                    result.result = ((Float(startFontCounter)-1.0)/10.0)
                    result.dateTest = Date()
                    if eyeLabel.text == "Закройте правый глаз"{
                        result.testingEye = "Левый глаз"
                    }else if eyeLabel.text == "Закройте левый глаз"{
                        result.testingEye = "Правый глаз"
                    }
                    
                    curUser.addToRelationship1(result)
                    
                    try context.save()
                    print(result)
                }
                
            }catch let error as NSError {
                print(error)
            }
        }
    @objc func animatedEyeLabel() {
        UILabel.animate(withDuration: 0.15/Double(animateCounter), animations: {
            
            self.eyeLabel.transform = CGAffineTransform.init(translationX: 0, y: -30)
        }) { (_) in
            
            UILabel.animate(withDuration: 0.15, animations: {
                self.eyeLabel.transform = CGAffineTransform.init(translationX: 0, y: 30)
            }) { (_) in
                UILabel.animate(withDuration: 0.10, animations: {
                    self.eyeLabel.transform = CGAffineTransform.init(translationX: 0, y: -15)
                }) { (_) in
                    UILabel.animate(withDuration: 0.05, animations: {
                        self.eyeLabel.transform = CGAffineTransform.init(translationX: 0, y: 7.5)
                    }) { (_) in
                        UILabel.animate(withDuration: 0.05, animations: {
                            self.eyeLabel.transform = CGAffineTransform.init(translationX: 0, y: -7.5)
                        }) { (_) in
                            self.stopBool = false
                        }
                    }
                }
            }
        }
    }
    
}
