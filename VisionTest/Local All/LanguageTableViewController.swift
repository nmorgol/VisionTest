

import UIKit
import CoreData

class LanguageTableViewController: UITableViewController {
    
    let englishLanguage = ["English", "Russian"]
    let currentLanguage = ["English", "Русский"]
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var languageCurrent = "English"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let language = try context.fetch(Localization.fetchRequest())
            if language.count > 0{
                let recieveLang = (language.last as! Localization).identificator
                if recieveLang == "en_US"{
                    languageCurrent = "English"
                    
                }else if recieveLang == "ru_Ru"{
                    languageCurrent = "Russian"
                }
            }
            
        } catch let error as NSError{
            print(error)
        }
        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.tableFooterView = UIView()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return englishLanguage.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if (cell != nil){
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                   reuseIdentifier: "reuseIdentifier")
            cell?.textLabel?.text = englishLanguage[indexPath.row]
            cell?.detailTextLabel?.text = currentLanguage[indexPath.row]
            
            if languageCurrent == "English" && indexPath.row == 0{
                cell?.accessoryType = .checkmark
            }else if languageCurrent == "Russian" && indexPath.row == 1{
                cell?.accessoryType = .checkmark
            }
            
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            languageCurrent = "English"
        }else if indexPath.row == 1{
            languageCurrent = "Russian"
        }
        
        saveLanguage()
        
        tableView.reloadData()
    }
    
    
    func saveLanguage() {
        do {
            let language = try context.fetch(Localization.fetchRequest())
            if language.count > 0{
                for res in language{
                    context.delete(res as! NSManagedObject)
                    try context.save()
                }
            }
            
        } catch let error as NSError{
            print(error)
        }
        
        let newLanguage = Localization(context: context)
        var newVal = String()
        if languageCurrent == "English"{
            newVal = "en_US"
        }else if languageCurrent == "Russian"{
            newVal = "ru_Ru"
        }
            
        newLanguage.setValue(newVal, forKey: "identificator")
        do {
            try context.save()
        }catch let error as NSError{
            print(error)
        }
    }
}

