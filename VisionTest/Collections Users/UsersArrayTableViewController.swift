

import UIKit
import CoreData

class UsersArrayTableViewController: UITableViewController {
    
    var state = String()//определить откуда был переход
    var stateBool = false
    
    var complition:((Int)->())?
    
    var usersArray = [User]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let cellID = "UsersArrayCell"
    var userPhotoArray = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(state)
        do {
            usersArray = try context.fetch(User.fetchRequest())
        } catch let error as NSError {
            print(error)
        }
//        print(usersArray.count)
        if usersArray.count > 0{
            for i in 0...usersArray.count-1{//чтобы не тупила при прокрутке
                let imgPng = UIImage(named: "placeholder")?.pngData()
                let image = UIImage(data: usersArray[i].photo ?? imgPng!)
                userPhotoArray.append(image ?? UIImage(named: "placeholder")!)
            }
        }
        
        self.tableView.register(UserArrayTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        
        self.tabBarController?.tabBar.isHidden = true
//        tableView.tableFooterView = UIView()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! UserArrayTableViewCell
//        cell.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5).isActive = true
//        let dataPh = UIImage(named: "placeholder")?.pngData()
//        cell.userPhotoImageView.image = UIImage(data: usersArray[indexPath.row].photo ?? dataPh!)
//        cell.userPhotoImageView.image = UIImage(data: usersArray[indexPath.row].photo ?? dataPh!, scale: 0.000001 )
        cell.userPhotoImageView.image = userPhotoArray[indexPath.row]
        cell.userNameLabel.text = usersArray[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            do {
                let result = try context.fetch(CurrentUser.fetchRequest())
                
                for res in result{
                    context.delete(res as! NSManagedObject)
                }

                try? context.save()
                
            } catch let error as NSError {
                print(error)
            }
            let newCurrentUser = CurrentUser(context: context)
            newCurrentUser.setValue(Float(indexPath.row), forKey: "currentUser")
            do {
                try context.save()
            }catch let error as NSError{
                print(error)
            }
            let curUser = indexPath.row
            complition?(curUser)
            self.navigationController?.popViewController(animated: false)
        
        
        
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        var boolReturn = UITableViewCell.EditingStyle(rawValue: 0)
        if stateBool{
            boolReturn = .delete
        }else{
            boolReturn = UITableViewCell.EditingStyle.none
        }
        
        return boolReturn!
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && stateBool{
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            do {//удалили пользователя
                usersArray = try context.fetch(User.fetchRequest())
                context.delete(usersArray[indexPath.row] as NSManagedObject)
                
                try? context.save()
                
                usersArray = try context.fetch(User.fetchRequest())
            } catch let error as NSError {
                print(error)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            if usersArray.count == 0{//если пользователей не осталось - создаем нового
                let userNew = User(context: context)//добавили нового пользователя
                let imgPng = UIImage(named: "placeholder")?.pngData()
                userNew.setValue(imgPng, forKey: "photo")
                userNew.setValue("name", forKey: "name")
                userNew.setValue(" ", forKey: "info")
                
                do {
                    try context.save()
                    usersArray = try context.fetch(User.fetchRequest())
                }catch let error as NSError{
                    print(error)
                }
            }
            
            
            do {//удалили текущего пользователя
                let result = try context.fetch(CurrentUser.fetchRequest())
                
                for res in result{
                    context.delete(res as! NSManagedObject)
                }

                try? context.save()
                
            } catch let error as NSError {
                print(error)
            }
//            let newCurrentUser = CurrentUser(context: context)
//            newCurrentUser.setValue(Float(usersArray.count-1), forKey: "currentUser")
            do {//создали нового текущего пользователя
                let newCurrentUser = CurrentUser(context: context)
                newCurrentUser.setValue(Float(usersArray.count-1), forKey: "currentUser")
                try context.save()
            }catch let error as NSError{
                print(error)
            }
            
            //tableView.reloadData()
        }
        tableView.reloadData()
    }

    
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillAppear(false)
//        self.tabBarController?.tabBar.isHidden = false
        do {
            let curUs = try context.fetch(CurrentUser.fetchRequest())
            print(curUs)
        } catch let error as NSError {
            print(error)
        }
        
    }
    
}
