

import UIKit
import CoreData

class SymbolTableViewCell: UITableViewCell, UITableViewDelegate{
    
    let cellID = "SymbolCell"
    var symbolSegment = UISegmentedControl(items: ["Landolt", "Snellen"])
    var symbolView = UIView()
    let settingsLabel = UILabel()
    var symbolArray = [UIView]()
    let snellen = SnellenRightView()
    let landolt = LandoltRightUIView()
    var currentSymbol = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code ььь
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: .subtitle, reuseIdentifier: cellID)
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let settings = try context.fetch(SettingsApp.fetchRequest())
            if settings.count > 0{
                currentSymbol = (settings.last as! SettingsApp).symbolTest ?? "Landolt"
            }else{
                currentSymbol = "Landolt"
            }
        } catch let error as NSError {
            print(error)
        }
        
        symbolArray = [landolt, snellen]
//                symbolView = landolt
        
        if currentSymbol == "Snellen"{
            symbolView = snellen
        }else{
            symbolView = landolt
        }
        
        addSubview(symbolView)
        addSubview(symbolSegment)
        addSubview(settingsLabel)
        
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        settingsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        settingsLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        settingsLabel.textAlignment = .left
        
        symbolView.translatesAutoresizingMaskIntoConstraints = false
        symbolView.leftAnchor.constraint(equalTo: settingsLabel.rightAnchor, constant: 0).isActive = true
        symbolView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        symbolView.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        
        symbolSegment.translatesAutoresizingMaskIntoConstraints = false
        symbolSegment.leftAnchor.constraint(equalTo: symbolView.rightAnchor, constant: 15).isActive = true
        symbolSegment.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        symbolSegment.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 2/4).isActive = true
        symbolSegment.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        if currentSymbol == "Snellen"{
            symbolSegment.selectedSegmentIndex = 1
        }else{
            symbolSegment.selectedSegmentIndex = 0
        }
        
        symbolSegment.addTarget(self, action: #selector(segmentAction(target:)), for: .valueChanged)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc func segmentAction(target: UISegmentedControl) {
        symbolSegment.removeFromSuperview()
        symbolView.removeFromSuperview()
        
        symbolView = symbolArray[target.selectedSegmentIndex]
        
        addSubview(symbolView)
        addSubview(symbolSegment)
        
        
        symbolView.translatesAutoresizingMaskIntoConstraints = false
        symbolView.leftAnchor.constraint(equalTo: settingsLabel.rightAnchor, constant: 0).isActive = true
        symbolView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        symbolView.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        symbolSegment.translatesAutoresizingMaskIntoConstraints = false
        symbolSegment.leftAnchor.constraint(equalTo: symbolView.rightAnchor, constant: 15).isActive = true
        symbolSegment.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        symbolSegment.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 2/4).isActive = true
        symbolSegment.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
    }
    
}
