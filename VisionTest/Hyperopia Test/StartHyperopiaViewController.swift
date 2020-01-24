

import UIKit

class StartHyperopiaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Hyperopia test"
        self.navigationItem.title = "Hyperopia test"
        let vc = HyperopiaViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        let vc = HyperopiaViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }



}
