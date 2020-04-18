
import UIKit

class DegreeViewController: UIViewController {

    let sphereView = SphereView()
    let lastSpere = LastSphereView()
    let sectorView = SectorView()
    let degr90 = _0DegrView()
    let rotateView = Rotate90DegrView()
    let scaledView = ScaledView()
    let oneDegreeView = DegreeView()
    let minutesView = MinuteInDegreeView()
    let topDegreeMin = TopDegreeToMinuteView()
    let symbolDescr = SymbolDescribeView()
    
    let nextButton = UIButton()
    let textLabel = UILabel()
    var viewArray = [UIView]()
    var currentView = UIView()
    var numberView = 0
    
    let angleLabel = UILabel()
    let distLabel = UILabel()
    let razrLabel = UILabel()
    let helpAngleViewLeft = UIView()
    let helpAngleViewBottom = UIView()
    let helpRazrView = UIView()
    
    var textArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        viewArray = [lastSpere, sphereView, sectorView, degr90, rotateView, scaledView, oneDegreeView, minutesView, topDegreeMin, symbolDescr]
        currentView = viewArray[numberView]
        
        textArray = ["Из центра сферы угол обзора в любой плоскости равен 360°",
                     "Выделим 1/8 часть сферы",
                     "Оставим только выделеную область",
                     "Оставим выделеную область только в одной плоскости. Угол между осями координат равен 90°",
                     "Повернем влево на 45°",
                     "Немного увеличим и разделим на 90 равных частей. Две любые соседнии линии образуют угол равный 1 градусу (1°)",
                     "Оставим только один угол и немного увеличим. ",
                     "Как видно, при удалении от вершины угла, расстояние между линиями, образующими угол, увеличивается",
                     "Для наглядности отдалимся на некоторое расстояние от вершины угла и разделим 1° на 60 равных частей, каждая из которых равна 1 угловой минуте(1')",
                     "Размер символа рассчитывается таким образом, чтобы при установленной дистанции проведения теста разрыв символа составлял 1 угловую минуту при остроте зрения равной 1"]
        textLabel.text = textArray[numberView]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        addSphere()
        addNextButton()
        addLabel()
    }
    
    func addSphere() {
        view.addSubview(currentView)
        currentView.translatesAutoresizingMaskIntoConstraints = false
        currentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        currentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        currentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        currentView.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        currentView.backgroundColor = .clear
    }
    
    func addLabel() {
        view.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: currentView.bottomAnchor).isActive = true
        textLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 95/100).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor).isActive = true
        
        textLabel.backgroundColor = .clear
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .justified
    }

    func addNextButton() {
        self.view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        nextButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/20).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        nextButton.setTitle("дальше", for: .normal)
        nextButton.backgroundColor = .red
        
        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        
    }
    
    @objc func nextButtonAction() {
        if numberView == viewArray.count-1{
            numberView = 0
        }else{
            numberView += 1
        }
        textLabel.removeFromSuperview()
        currentView.removeFromSuperview()
        currentView = viewArray[numberView]
        textLabel.text = textArray[numberView]
        addSphere()
        addLabel()
        if numberView == viewArray.count-1{
            addAnglDistLabels()
        }
    }
    
    func addAnglDistLabels() {
        
        
        currentView.addSubview(helpAngleViewLeft)
        helpAngleViewLeft.translatesAutoresizingMaskIntoConstraints = false
        helpAngleViewLeft.leftAnchor.constraint(equalTo: currentView.leftAnchor).isActive = true
        helpAngleViewLeft.bottomAnchor.constraint(equalTo: currentView.bottomAnchor).isActive = true
        helpAngleViewLeft.widthAnchor.constraint(equalTo: currentView.widthAnchor, multiplier: 3/20).isActive = true
        helpAngleViewLeft.heightAnchor.constraint(equalTo: currentView.heightAnchor, multiplier: 1/4).isActive = true
        helpAngleViewLeft.backgroundColor = .clear
        
        currentView.addSubview(angleLabel)
        angleLabel.translatesAutoresizingMaskIntoConstraints = false
        angleLabel.leftAnchor.constraint(equalTo: helpAngleViewLeft.rightAnchor).isActive = true
        angleLabel.bottomAnchor.constraint(equalTo: helpAngleViewLeft.topAnchor).isActive = true
        angleLabel.widthAnchor.constraint(equalTo: currentView.widthAnchor, multiplier: 4/20).isActive = true
        angleLabel.heightAnchor.constraint(equalTo: currentView.widthAnchor, multiplier: 1/20).isActive = true
        
        angleLabel.backgroundColor = .clear
        angleLabel.text = "𝛂 = 0° 1′"
        
        currentView.addSubview(helpAngleViewBottom)
        helpAngleViewBottom.translatesAutoresizingMaskIntoConstraints = false
        helpAngleViewBottom.rightAnchor.constraint(equalTo: currentView.rightAnchor).isActive = true
        helpAngleViewBottom.bottomAnchor.constraint(equalTo: currentView.bottomAnchor).isActive = true
        helpAngleViewBottom.widthAnchor.constraint(equalTo: currentView.widthAnchor, multiplier: 6/20).isActive = true
        helpAngleViewBottom.heightAnchor.constraint(equalTo: currentView.heightAnchor, multiplier: 7/20).isActive = true
        helpAngleViewBottom.backgroundColor = .clear
        
        currentView.addSubview(distLabel)
        distLabel.translatesAutoresizingMaskIntoConstraints = false
        distLabel.leftAnchor.constraint(equalTo: helpAngleViewBottom.leftAnchor).isActive = true
        distLabel.bottomAnchor.constraint(equalTo: helpAngleViewBottom.topAnchor).isActive = true
        distLabel.widthAnchor.constraint(equalTo: currentView.widthAnchor, multiplier: 4/20).isActive = true
        distLabel.heightAnchor.constraint(equalTo: currentView.widthAnchor, multiplier: 1/20).isActive = true
        
        distLabel.backgroundColor = .clear
        distLabel.text = "5 m."
        distLabel.textAlignment = .center
        
        currentView.addSubview(helpRazrView)
        helpRazrView.translatesAutoresizingMaskIntoConstraints = false
        helpRazrView.leftAnchor.constraint(equalTo: currentView.leftAnchor).isActive = true
        helpRazrView.bottomAnchor.constraint(equalTo: currentView.bottomAnchor).isActive = true
        helpRazrView.widthAnchor.constraint(equalTo: currentView.widthAnchor, multiplier: 3/20).isActive = true
        helpRazrView.heightAnchor.constraint(equalTo: currentView.heightAnchor, multiplier: 1/2).isActive = true
        helpRazrView.backgroundColor = .clear
        
        currentView.addSubview(razrLabel)
        razrLabel.translatesAutoresizingMaskIntoConstraints = false
        razrLabel.leftAnchor.constraint(equalTo: helpRazrView.rightAnchor).isActive = true
        razrLabel.bottomAnchor.constraint(equalTo: helpRazrView.topAnchor).isActive = true
        razrLabel.widthAnchor.constraint(equalTo: currentView.widthAnchor, multiplier: 4/20).isActive = true
        razrLabel.heightAnchor.constraint(equalTo: currentView.widthAnchor, multiplier: 1/20).isActive = true
        
        razrLabel.backgroundColor = .clear
        razrLabel.text = "≈ 1.4 mm."
        razrLabel.textAlignment = .center
    }
    
}

