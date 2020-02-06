

import UIKit

import CoreData

class HyperopiaViewController: UIViewController {
    
    
    
    let wordArray = ["Верх","Низ","Лево","Право"]
    var currentText = String()
    var speechBool = false
    var wordLabel = UILabel()
    var fontSize = Float()
    
    let textForRec = "Взлететь вверх"
    
    
    var disapearTrue = true //подпорка для того чтобы не отрабатывал метод self.navigationController?.popViewController(animated:false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = "Hyperopia test"
//        self.navigationItem.title = "Hyperopia test"
        self.view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Results", style: .plain, target: self, action: #selector(actionResults))
        fontSize = 17
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        disapearTrue = true
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let resultSettings = try context.fetch(SettingsApp.fetchRequest())
            
            if resultSettings.count > 0 {
                speechBool = (resultSettings.last as! SettingsApp).speechRecognize
            }
        } catch let error as NSError {
            print(error)
        }
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()
        addWordLabel()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(true)
        if disapearTrue {
                self.navigationController?.popViewController(animated: false)
        }
        
    }
    
    
    @objc func actionResults() {
        disapearTrue = false
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
        
        
    }
    

    
    
    func ifSpeechBoolIsTrue(speechB: Bool) {
        if speechB == true{
            
            let vc = HyperopiaSpeechViewController()
            //vc.inputText = textForRec
            //vc.fontSize = fontSize
            self.navigationController?.pushViewController(vc, animated: false)
            vc.comletion = {text in
                self.currentText = text
                print(self.currentText)
            }
        }else{
            let vc = HyperopiaViewController()
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
