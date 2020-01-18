

import UIKit
import CoreData

class ResultsTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var state = String()//смотреть из какого контроллера пришел запрос
    var changedUser = Int(0)//можно поменять юзера у которого смотреть результат
    var currentUser: User?
//    let cellID = "cellID"
    let resultCellID = "ResultCell"
    let userCellID = "UserCell"//ячейка из настроек -- пользователь
    var resultsMiopiaArray: [MiopiaTestResult]?
//    var resultsMiopiaArray = User.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(navBarAction))
        
        
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        self.tableView.register(CurrentUserTableViewCell.self, forCellReuseIdentifier: userCellID)
        self.tableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: resultCellID)
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        
        self.tabBarController?.tabBar.isHidden = true
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let resultUser = try context.fetch(User.fetchRequest())
            let currentUserCD = try context.fetch(CurrentUser.fetchRequest())
            _ = try context.fetch(MiopiaTestResult.fetchRequest())
            if changedUser == 0{
                if resultUser.count > 0{
                    changedUser = Int((currentUserCD.last as! CurrentUser).currentUser)
                    currentUser = (resultUser[changedUser] as! User)
                    resultsMiopiaArray = (currentUser?.relationship?.allObjects as! [MiopiaTestResult])
                    
                    resultsMiopiaArray = resultsMiopiaArray?.sorted(by: { $0.dateTest!.compare($1.dateTest!) == .orderedDescending })
                    
                }
            }else{
                currentUser = (resultUser[changedUser] as! User)
            }
            
        } catch let error as NSError {
            print(error)
        }
        tableView.reloadData()
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
            return resultsMiopiaArray?.count ?? 3
        default:
            break
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        if indexPath.section == 0{
            let cell1 = tableView.dequeueReusableCell(withIdentifier: userCellID, for: indexPath) as! CurrentUserTableViewCell
            
            let dataImg = UIImage(named: "placeholder")?.pngData()
            
            cell1.userPhotoImageView.image = UIImage(data: currentUser?.photo ?? dataImg!)
            cell1.userNameLabel.text = currentUser?.name ?? " "
            cell1.userInfoLabel.text = currentUser?.info ?? " "
            cell1.isUserInteractionEnabled = false
            
            cell = cell1
            return cell
            
        }else if indexPath.section == 1{

            let cell2 = tableView.dequeueReusableCell(withIdentifier: resultCellID, for: indexPath) as! ResultsTableViewCell
            
            let currentDate = Date()
            let formatter = DateFormatter()
            let recieveDate = resultsMiopiaArray?[indexPath.row].dateTest
            formatter.dateFormat = "dd.MM.yyyy"
            let result = formatter.string(from: recieveDate ?? currentDate)
            
            cell2.eyeLabel.text = resultsMiopiaArray?[indexPath.row].testingEye
            cell2.distanceTestLabel.text = "Distance test: \(resultsMiopiaArray?[indexPath.row].distance ?? 0)"
            cell2.dateTestLabel.text = "Date test:" + "" + result
            cell2.testResultLabel.text = "Test result:\(resultsMiopiaArray?[indexPath.row].result ?? 0)"
            
            cell2.layer.cornerRadius = 20
            cell2.clipsToBounds = true
            
            cell = cell2
            return cell
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = CGFloat()
        if  indexPath.section == 0{
            height = 150
        } else {
            height = 100
        }
        return height
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
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
