

import UIKit
import CoreData

class SymbolTableViewCell: UITableViewCell, UITableViewDelegate{
    
    let cellID = "SymbolCell"
    var symbolSegment = UISegmentedControl(items: ["Landolt", "E Chart"])
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
        let currentSymbolArray = ["Landolt", "Snellen"]
        currentSymbol = currentSymbolArray[target.selectedSegmentIndex]
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
        
        actionSave()
    }
    @objc func actionSave() {
        
        let appDelegat = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegat.persistentContainer.viewContext
        
        var avtoDetectDistBool = false
        var speechRecognBool = false
        var distanceTest = Float(0.5)
        var timeToStart = Float(0.0)
        
        do {
            let result = try context.fetch(SettingsApp.fetchRequest())
            
            if result.count > 0 {
            
            avtoDetectDistBool = (result.last as! SettingsApp).avtoDetectDistance
            speechRecognBool = (result.last as! SettingsApp).speechRecognize
            distanceTest = (result.last as! SettingsApp).distanceTest
            timeToStart = (result.last as! SettingsApp).timeBeforeTest
            
            for res in result{
                context.delete(res as! NSManagedObject)
            }

            try? context.save()
        }
        } catch let error as NSError {
            print(error)
        }
        
        let settingsNew = SettingsApp(context: context)
        settingsNew.setValue(avtoDetectDistBool, forKey: "avtoDetectDistance")
        settingsNew.setValue(speechRecognBool, forKey: "speechRecognize")
        settingsNew.setValue(distanceTest, forKey: "distanceTest")
        settingsNew.setValue(timeToStart, forKey: "timeBeforeTest")
        settingsNew.setValue(currentSymbol, forKey: "symbolTest")
        
        do {
            try context.save()
        }catch let error as NSError{
            print(error)
        }
    }
}
