

import UIKit

class StartMiopiaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Miopia test"
        self.navigationItem.title = "Miopia test"
        let vc = MiopiaViewController()
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        let vc = MiopiaViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }

    

}
