

import UIKit
import CoreData

class StartHyperopiaViewController: UIViewController {
    
    var speechBool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hyperopia test"
        self.navigationItem.title = "Hyperopia test"
        //        let vc = HyperopiaViewController()
        //        self.navigationController?.pushViewController(vc, animated: false)
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
        
        
        //        let vc = HyperopiaViewController()
        //        self.navigationController?.pushViewController(vc, animated: false)
        ifSpeechBoolIsTrue(speechB: speechBool)
    }
    
    
    func ifSpeechBoolIsTrue(speechB: Bool) {
        if speechB == true{
            print(speechBool)
            let vc = HyperopiaSpeechViewController()
            
            self.navigationController?.pushViewController(vc, animated: false)
            
        }else{
            print(speechBool)
            let vc = HyperopiaViewController()
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
}
