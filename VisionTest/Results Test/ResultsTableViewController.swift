

import UIKit
import CoreData

class ResultsTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var state = String()//смотреть из какого контроллера пришел запрос
    var changedUser = Int(0)//можно поменять юзера у которого смотреть результат
    var currentUser: User?

    let resultCellID = "ResultCell"
    let userCellID = "UserCell"//ячейка из настроек -- пользователь
    var resultsMiopiaArray: [MiopiaTestResult]?//результаты из CoreData но они не сортированы
    var resultsHyperopiaArray: [HyperopiaTestResult]?
    
    var sortedMiopiaArray: [MiopiaTestResult]?//отсортированные массивы по дате тестов
    var sortedHyperopiaArray: [HyperopiaTestResult]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.6561266184, green: 0.9085168242, blue: 0.9700091481, alpha: 1)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(navBarAction))
        
        self.tableView.register(CurrentUserTableViewCell.self, forCellReuseIdentifier: userCellID)
        self.tableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: resultCellID)
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        
        self.tabBarController?.tabBar.isHidden = true
        
        recieveTestsResults()
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
            var count = 0
            if state == "Miopia"{
                count = sortedMiopiaArray?.count ?? 0
            }else if state == "Hyperopia"{
                count = sortedHyperopiaArray?.count ?? 0
            }
            return count
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
            
            if state == "Miopia"{
                let recieveDate = sortedMiopiaArray?[indexPath.row].dateTest
                formatter.dateFormat = "dd.MM.yyyy"
                let result = formatter.string(from: recieveDate ?? currentDate)
                
                
                
                cell2.eyeLabel.text = sortedMiopiaArray?[indexPath.row].testingEye
                cell2.distanceTestLabel.text = "Дистанция теста:" + " " + " \(sortedMiopiaArray?[indexPath.row].distance ?? 0)"
                cell2.dateTestLabel.text = "Дата теста:" + " " + result
                cell2.testResultLabel.text = "Результат теста:" + " " + "\(sortedMiopiaArray?[indexPath.row].result ?? 0)"
            }else if state == "Hyperopia"{
                let recieveDate = sortedHyperopiaArray?[indexPath.row].dateTest
                formatter.dateFormat = "dd.MM.yyyy"
                let result = formatter.string(from: recieveDate ?? currentDate)
                
                cell2.eyeLabel.text = sortedHyperopiaArray?[indexPath.row].testingEye
                //cell2.distanceTestLabel.text = "Distance test: \(sortedMiopiaArray?[indexPath.row].distance ?? 0)"
                cell2.dateTestLabel.text = "Дата теста:" + " " + result
                cell2.testResultLabel.text = "Результат теста:" + " " + "\(sortedHyperopiaArray?[indexPath.row].result ?? 0)"
            }
            
            
            cell2.layer.cornerRadius = 20
            cell2.clipsToBounds = true
            
            cell2.isEditing = true
            
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
            return ""
        case 1:
            return "Результаты теста: "
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
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            if state == "Miopia"{
                
                for i in 0...resultsMiopiaArray!.count-1{//надо будет что-то с "!" делать потом
                    
                    if (sortedMiopiaArray![indexPath.row].isEqual(resultsMiopiaArray![i])){
                        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                        do {
                            let resultUser = try context.fetch(User.fetchRequest())
                            let currentUserCD = try context.fetch(CurrentUser.fetchRequest())
                            if changedUser == 0{
                                if resultUser.count > 0{
                                    changedUser = Int((currentUserCD.last as! CurrentUser).currentUser)
                                    currentUser = (resultUser[changedUser] as! User)
                                    if state == "Miopia"{
                                        resultsMiopiaArray = (currentUser?.relationship?.allObjects as! [MiopiaTestResult])
                                        context.delete(resultsMiopiaArray![i] as NSManagedObject)
                                    }
                                }
                            }else{
                                currentUser = (resultUser[changedUser] as! User)
                                
                                if state == "Miopia"{
                                    resultsMiopiaArray = (currentUser?.relationship?.allObjects as! [MiopiaTestResult])
                                    context.delete(resultsMiopiaArray![i] as NSManagedObject)
                                }
                            }
                            try? context.save()
                            
                        } catch let error as NSError {
                            print(error)
                        }
                    }
                }
                print(sortedMiopiaArray!.count)
                sortedMiopiaArray!.remove(at: indexPath.row)
                print(sortedMiopiaArray!.count)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                recieveTestsResults()
            }else if state == "Hyperopia"{
                
                for i in 0...resultsHyperopiaArray!.count-1{//надо будет что-то с "!" делать потом
                    
                    if (sortedHyperopiaArray![indexPath.row].isEqual(resultsHyperopiaArray![i])){
                        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                        do {
                            let resultUser = try context.fetch(User.fetchRequest())
                            let currentUserCD = try context.fetch(CurrentUser.fetchRequest())
                            if changedUser == 0{
                                if resultUser.count > 0{
                                    changedUser = Int((currentUserCD.last as! CurrentUser).currentUser)
                                    currentUser = (resultUser[changedUser] as! User)

                                    if state == "Hyperopia"{
                                        resultsHyperopiaArray = (currentUser?.relationship1?.allObjects as! [HyperopiaTestResult])
                                        context.delete(resultsHyperopiaArray![i] as NSManagedObject)
                                    }
                                }
                                
                            }else{
                                currentUser = (resultUser[changedUser] as! User)
                                
                                if state == "Hyperopia"{
                                    resultsHyperopiaArray = (currentUser?.relationship1?.allObjects as! [HyperopiaTestResult])
                                    context.delete(resultsHyperopiaArray![i] as NSManagedObject)
                                }
                            }
                            
                            try? context.save()
                            
                        } catch let error as NSError {
                            print(error)
                        }
                    }
                }
                print(sortedHyperopiaArray!.count)
                sortedHyperopiaArray!.remove(at: indexPath.row)
                print(sortedHyperopiaArray!.count)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                recieveTestsResults()
            }
        }
    }
    
    @objc func navBarAction(){
        let usersVC = UsersArrayTableViewController()
        usersVC.state = state
        usersVC.complition = {currUser in
            self.changedUser = currUser
            self.recieveTestsResults()
        }
        self.navigationController?.pushViewController(usersVC, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillAppear(false)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    fileprivate func recieveTestsResults() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let resultUser = try context.fetch(User.fetchRequest())
            let currentUserCD = try context.fetch(CurrentUser.fetchRequest())
//            _ = try context.fetch(MiopiaTestResult.fetchRequest())
            if changedUser == 0{
                if resultUser.count > 0{
                    changedUser = Int((currentUserCD.last as! CurrentUser).currentUser)
                    currentUser = (resultUser[changedUser] as! User)
                    if state == "Miopia"{
                        resultsMiopiaArray = (currentUser?.relationship?.allObjects as! [MiopiaTestResult])
                        sortedMiopiaArray = resultsMiopiaArray?.sorted(by: { $0.dateTest!.compare($1.dateTest!) == .orderedDescending })
                    }else if state == "Hyperopia"{
                        resultsHyperopiaArray = (currentUser?.relationship1?.allObjects as! [HyperopiaTestResult])
                        sortedHyperopiaArray = resultsHyperopiaArray?.sorted(by: { $0.dateTest!.compare($1.dateTest!) == .orderedDescending })
                    }
                }
            }else{
                currentUser = (resultUser[changedUser] as! User)
                
                if state == "Miopia"{
                    resultsMiopiaArray = (currentUser?.relationship?.allObjects as! [MiopiaTestResult])
                    sortedMiopiaArray = resultsMiopiaArray?.sorted(by: { $0.dateTest!.compare($1.dateTest!) == .orderedDescending })
                }else if state == "Hyperopia"{
                    resultsHyperopiaArray = (currentUser?.relationship1?.allObjects as! [HyperopiaTestResult])
                    sortedHyperopiaArray = resultsHyperopiaArray?.sorted(by: { $0.dateTest!.compare($1.dateTest!) == .orderedDescending })
                }
            }
            
        } catch let error as NSError {
            print(error)
        }
        tableView.reloadData()
    }
    
}
