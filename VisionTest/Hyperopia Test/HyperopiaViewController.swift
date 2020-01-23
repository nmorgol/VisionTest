

import UIKit

import CoreData

class HyperopiaViewController: UIViewController {
    
    
    
    let wordArray = ["Верх","Низ","Лево","Право"]
    var currentText = String()
    var speechBool = false
    var wordLabel = UILabel()
    var fontSize = Float()
    
    let textForRec = "Взлететь вверх"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hyperopia test"
        self.navigationItem.title = "Hyperopia test"
        self.view.backgroundColor = .white
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Results", style: .plain, target: self, action: #selector(actionResults))
        fontSize = 17
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let resultSettings = try context.fetch(SettingsApp.fetchRequest())
            
            if resultSettings.count > 0 {
                speechBool = (resultSettings.last as! SettingsApp).speechRecognize
            }
        } catch let error as NSError {
            print(error)
        }
        
        
        
        if speechBool == true && currentText != ""{
            if compareString(str1: currentText, str2: textForRec) == true{
                fontSize -= 3
            } else {fontSize += 3}
            ifSpeechBoolIsTrue(speechB: speechBool)
        }
        ifSpeechBoolIsTrue(speechB: speechBool)
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        addWordLabel()
    }
    
    
    
    @objc func actionResults() {
        let resultVC = ResultsTableViewController()
        resultVC.title = "Hyperopia test results"
        resultVC.state = "Hyperopia"
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
    
    
    
    func addWordLabel() {
        view.addSubview(wordLabel)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        wordLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/20).isActive = true
        
        wordLabel.text = wordArray.randomElement()
        wordLabel.textAlignment = .center
        wordLabel.font = .boldSystemFont(ofSize: CGFloat(fontSize))
        
        //        wordLabel.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
    }
    
    func compareString(str1: String, str2: String) -> Bool {
        var boolCompare = false
        let second1 = Array(str1)
        let second2 = Array(str2)
        for i in 0...second2.count-1{
            if (second2[i]==second1[0]) && ((second2.count-i) >= (second1.count)){
                for j in 0...second1.count-1{
                    if second2[i+j] == second1[j]{
                        boolCompare = true
                    }else{
                        boolCompare = false
                    }
                }
            }
        }
        return boolCompare
    }
    
    
    
    func ifSpeechBoolIsTrue(speechB: Bool) {
        if speechB == true{
            
            let vc = HyperopiaSpeechViewController()
            //vc.inputText = textForRec
            vc.fontSize = fontSize
            self.navigationController?.pushViewController(vc, animated: false)
            vc.comletion = {text in
                self.currentText = text
                print(self.currentText)
            }
        }
    }
}
