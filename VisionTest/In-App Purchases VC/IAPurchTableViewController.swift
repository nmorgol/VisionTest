

import UIKit
import StoreKit

class IAPurchTableViewController: UITableViewController {

    let iapManager = IAPManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        tableView.tableFooterView = UIView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(IAPManager.productNotificationIdentifier), object: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let product = IAPManager.shared.products[indexPath.row]
        cell.textLabel?.text = product.localizedTitle + " - " + self.priceStringFor(product: product)
        
        
        return cell
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

}
