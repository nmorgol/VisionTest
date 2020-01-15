

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var state = String()
    var changedUser = Int(0)
    var currentUser = User()
    let cellID = "cellID"
    var resultsMiopiaArray = [MiopiaTestResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(navBarAction))
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        
        self.tabBarController?.tabBar.isHidden = true
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let resultUser = try context.fetch(User.fetchRequest())
            let currentUserCD = try context.fetch(CurrentUser.fetchRequest())
            if changedUser == 0{
                if resultUser.count > 0{
                    changedUser = Int((currentUserCD.last as! CurrentUser).currentUser)
                    currentUser = (resultUser[changedUser] as! User)
                }
            }else{
                currentUser = (resultUser[changedUser] as! User)
            }
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
        return 3//resultsMiopiaArray.count
        default:
            break
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        if indexPath.section == 0{
            let dataImg = UIImage(named: "placeholder")?.pngData()
            cell.imageView?.image = UIImage(data: currentUser.photo ?? dataImg!)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return " "
        case 1:
            return " "
        default:
            break
        }
        return " "
    }
    
    
    
    @objc func navBarAction(){
        let usersVC = UsersArrayTableViewController()
        usersVC.state = state
        usersVC.complition = {currUser in
            self.changedUser = currUser
        }
        self.navigationController?.pushViewController(usersVC, animated: false)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillAppear(false)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
