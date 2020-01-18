

import UIKit
import CoreData

class UsersArrayTableViewController: UITableViewController {
    
    var state = String()//определить откуда был переход
    
    var complition:((Int)->())?
    
    var usersArray = [User]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let cellID = "UsersArrayCell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(state)
        do {
            usersArray = try context.fetch(User.fetchRequest())
        } catch let error as NSError {
            print(error)
        }
        print(usersArray.count)
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
        let dataPh = UIImage(named: "placeholder")?.pngData()
//        cell.userPhotoImageView.image = UIImage(data: usersArray[indexPath.row].photo ?? dataPh!)
        cell.userPhotoImageView.image = UIImage(data: usersArray[indexPath.row].photo ?? dataPh!, scale: 0.000001 )
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
    

    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillAppear(false)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
