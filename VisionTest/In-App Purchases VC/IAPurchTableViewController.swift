

import UIKit
import StoreKit
import CoreData

class IAPurchTableViewController: UITableViewController {

    let iapManager = IAPManager.shared
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var moreThanOneUser = false
    var autoDetectDistance = false
    var speechrecognize = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do{
            let iap = try context.fetch(InAppPurchases.fetchRequest())
            if iap.count > 0{
                moreThanOneUser = (iap.last as! InAppPurchases).moreThanOneUser
                autoDetectDistance = (iap.last as! InAppPurchases).autoDetectDistance
                speechrecognize = (iap.last as! InAppPurchases).speechRecognition
            }
        }catch let error as NSError{
            print(error)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Восстановить покупки", style: .plain, target: self, action: #selector(restorePurchases))
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        tableView.tableFooterView = UIView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(IAPManager.productNotificationIdentifier), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(moreThanOneUserAction), name: NSNotification.Name(IAPProducts.moreThanOneUser.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(speechRecognitionAction), name: NSNotification.Name(IAPProducts.speechRecognition.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(autoDetectDistanceAction), name: NSNotification.Name(IAPProducts.automaticDistanceDetection.rawValue), object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return IAPManager.shared.products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

//        var cell = UITableViewCell(style: .value1, reuseIdentifier: "reuseIdentifier")
//        cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if (cell != nil){
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                        reuseIdentifier: "reuseIdentifier")
        }
        
        let product = IAPManager.shared.products[indexPath.row]
        cell?.textLabel?.text = product.localizedTitle + " - " + self.priceStringFor(product: product)
        cell?.detailTextLabel?.text = "Не расходуемая покупка"
        
        
        return cell!
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = iapManager.products[indexPath.row].productIdentifier
        iapManager.purchase(productWith: identifier)
        
    }
    
    
    
    
    func priceStringFor(product: SKProduct) -> String {
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .currency
        numberFormater.locale = product.priceLocale
        
        return numberFormater.string(from: product.price)!
    }
    
    
    @objc private func reload(){
        self.tableView.reloadData()
    }
    
    @objc public func restorePurchases(){
        iapManager.restoreComplitedTransactions()
    }
    
    @objc private func moreThanOneUserAction(){
        
        moreThanOneUser = true
        actionSave()
    }
    @objc private func speechRecognitionAction(){
        speechrecognize = true
        actionSave()
    }
    @objc private func autoDetectDistanceAction(){
        autoDetectDistance = true
        actionSave()
    }
    
    @objc func actionSave() {
        
        let appDelegat = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegat.persistentContainer.viewContext
        
        do {
            let iap = try context.fetch(InAppPurchases.fetchRequest())
            
            for res in iap{
                context.delete(res as! NSManagedObject)
            }

            try? context.save()
            
        } catch let error as NSError {
            print(error)
        }
        let iapNew = InAppPurchases(context: context)
        iapNew.setValue(autoDetectDistance, forKey: "autoDetectDistance")
        iapNew.setValue(speechrecognize, forKey: "speechRecognition")
        iapNew.setValue(moreThanOneUser, forKey: "moreThanOneUser")
        
        do {
            try context.save()
        }catch let error as NSError{
            print(error)
        }
    }
}
