

import UIKit

class StartMiopiaViewController: UIViewController {

    var speechBool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Miopia test"
        self.navigationItem.title = "Miopia test"
        
        
        
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
        ifDistanceBoolIsTrue(distanceB: speechBool)
        
        
    }

    func ifDistanceBoolIsTrue(distanceB: Bool) {
        if distanceB == true{
            
            let vc = MiopiaAvtoDistanceViewController()
            
            self.navigationController?.pushViewController(vc, animated: false)
            
        }else{
            
            let vc = MiopiaViewController()
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }

}
