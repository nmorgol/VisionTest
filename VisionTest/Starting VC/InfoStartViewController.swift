

import UIKit

class InfoStartViewController: UIViewController {

    let segmentedContr = UISegmentedControl(items: ["Информация","Инструкция"])
    
    //информация
    let scrolView = UIScrollView()
    
    let viewForDescrMyopia = UIView()
    let myopiaDescrLabel = UILabel()
    let eyeView = EyeView()
    let myopiaLight = MyopiaLightView()
    
    let viewForTable = UIView()
    let tableDescrLabel = UILabel()
    let tableImageView = UIImageView()
    
    let symbolDescribeView = UIView()
    let firstLabel = UILabel()
    let landoltView = LandoltLeftUIView()
    let landoltLabel = UILabel()
    let secondLandoltLabel = UILabel()
    let snelenView = SnellenLeftView()
    let snelenLabel = UILabel()
    
    
    //инструкция
    let scrollInfoView = UIScrollView()
    
    let attantionView = UIView()
    let attantionLabel = UILabel()
    let eyeNormView = EyeView()
    let normLight = NormalLightView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = #colorLiteral(red: 0.6561266184, green: 0.9085168242, blue: 0.9700091481, alpha: 1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        addSegmContr()
        addScrollView()

        addMyopViews()
        addTableViews()
        addSybolDiscrView()
    }

    func addSegmContr() {
        segmentedContr.selectedSegmentIndex = 0
        
        view.addSubview(segmentedContr)
        segmentedContr.translatesAutoresizingMaskIntoConstraints = false
        segmentedContr.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        segmentedContr.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segmentedContr.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentedContr.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedContr.addTarget(self, action: #selector(segmentContrAction), for: .valueChanged)
        
        
    }
    
    
    @objc func segmentContrAction() {
        if segmentedContr.selectedSegmentIndex == 0{
            
            addScrollView()
            addMyopViews()
            addTableViews()
            addSybolDiscrView()
            
        }else if segmentedContr.selectedSegmentIndex == 1{
            scrolView.removeFromSuperview()
            
            addScrollInfoView()
        }
    }
    
    
     
    func addScrollView() {
        
        view.addSubview(scrolView)
        scrolView.translatesAutoresizingMaskIntoConstraints = false
        scrolView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        scrolView.topAnchor.constraint(equalTo: segmentedContr.bottomAnchor).isActive = true
        
        scrolView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrolView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrolView.contentSize = CGSize(width: view.frame.width, height: 1890)
        
    }
    
    func addMyopViews() {
        
        scrolView.addSubview(viewForDescrMyopia)
        
        viewForDescrMyopia.translatesAutoresizingMaskIntoConstraints = false
        viewForDescrMyopia.widthAnchor.constraint(equalTo: scrolView.widthAnchor, multiplier: 95/100).isActive = true
        viewForDescrMyopia.topAnchor.constraint(equalTo: scrolView.topAnchor, constant: 10).isActive = true
        viewForDescrMyopia.heightAnchor.constraint(equalToConstant: 520).isActive = true
        viewForDescrMyopia.centerXAnchor.constraint(equalTo: scrolView.centerXAnchor).isActive = true
        viewForDescrMyopia.backgroundColor = .white
        
        viewForDescrMyopia.layer.cornerRadius = 20
        viewForDescrMyopia.layer.shadowOpacity = 0.1
        viewForDescrMyopia.layer.shadowColor = UIColor.gray.cgColor
        
        viewForDescrMyopia.addSubview(eyeView)
        viewForDescrMyopia.addSubview(myopiaLight)
        
        eyeView.translatesAutoresizingMaskIntoConstraints = false
        eyeView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        eyeView.topAnchor.constraint(equalTo: viewForDescrMyopia.topAnchor, constant: 0).isActive = true
        eyeView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        eyeView.centerXAnchor.constraint(equalTo: viewForDescrMyopia.centerXAnchor).isActive = true
        eyeView.backgroundColor = .clear
        
        myopiaLight.translatesAutoresizingMaskIntoConstraints = false
        myopiaLight.widthAnchor.constraint(equalToConstant: 200).isActive = true
        myopiaLight.topAnchor.constraint(equalTo: viewForDescrMyopia.topAnchor, constant: 0).isActive = true
        myopiaLight.heightAnchor.constraint(equalToConstant: 200).isActive = true
        myopiaLight.centerXAnchor.constraint(equalTo: viewForDescrMyopia.centerXAnchor).isActive = true
        myopiaLight.backgroundColor = .clear
        
        viewForDescrMyopia.addSubview(myopiaDescrLabel)
        
        myopiaDescrLabel.translatesAutoresizingMaskIntoConstraints = false
        myopiaDescrLabel.widthAnchor.constraint(equalTo: viewForDescrMyopia.widthAnchor).isActive = true
        myopiaDescrLabel.topAnchor.constraint(equalTo: eyeView.bottomAnchor, constant: 0).isActive = true
        myopiaDescrLabel.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        myopiaDescrLabel.numberOfLines = 0
        myopiaDescrLabel.textAlignment = .natural
        myopiaDescrLabel.text = "   Близорукость, или миопия – самая распространенная причина низкого зрения у человека в наши дни. \n\n   Попадающие в глаз лучи света фокусируются до сетчатки, когда роговица и хрусталик чрезмерно сильно изменяют их ход. \n    Человек плохо видит при миопии из-за несоответствия силы оптики глаза и размера глазного яблока, при котором лучи света формируют изображение раньше, чем они достигнут сетчатки. И когда они все-таки попадают на нее, то картинка становиться размытой."

        
    }
    
    func addTableViews() {
        
        scrolView.addSubview(viewForTable)
        
        viewForTable.translatesAutoresizingMaskIntoConstraints = false
        viewForTable.widthAnchor.constraint(equalTo: scrolView.widthAnchor, multiplier: 95/100).isActive = true
        viewForTable.topAnchor.constraint(equalTo: viewForDescrMyopia.bottomAnchor, constant: 10).isActive = true
        viewForTable.heightAnchor.constraint(equalToConstant: 520).isActive = true
        viewForTable.centerXAnchor.constraint(equalTo: scrolView.centerXAnchor).isActive = true
        
        viewForTable.backgroundColor = .white
        viewForTable.layer.cornerRadius = 20
        viewForTable.layer.shadowOpacity = 0.1
        viewForTable.layer.shadowColor = UIColor.gray.cgColor
        
        
        viewForTable.addSubview(tableImageView)
        
        tableImageView.translatesAutoresizingMaskIntoConstraints = false
        tableImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        tableImageView.topAnchor.constraint(equalTo: viewForTable.topAnchor, constant: 10).isActive = true
        tableImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        tableImageView.centerXAnchor.constraint(equalTo: viewForTable.centerXAnchor).isActive = true
        tableImageView.backgroundColor = .clear
        tableImageView.image = UIImage(named: "eye test tables")
        tableImageView.contentMode = .scaleAspectFit
        
        viewForTable.addSubview(tableDescrLabel)
        
        tableDescrLabel.translatesAutoresizingMaskIntoConstraints = false
        tableDescrLabel.widthAnchor.constraint(equalTo: viewForTable.widthAnchor).isActive = true
        tableDescrLabel.topAnchor.constraint(equalTo: tableImageView.bottomAnchor, constant: 0).isActive = true
        tableDescrLabel.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        tableDescrLabel.numberOfLines = 0
        tableDescrLabel.textAlignment = .natural
        tableDescrLabel.text = "   Чтобы определить остроту зрения человека, подбирая контактные линзы, очки или ради профилактики, применяют специальные таблицы, которые бывают разных видов. Но в целом процедура диагностики происходит по одному принципу:\n 1. Человека усаживают напротив таблицы на определенном расстоянии.\n 2. Врач указывает на строку или символ на таблице, просит человека его назвать.\n 3. Если человек хорошо может различить указанный символ, врач указывает на более мелкий шрифт."
        
        
    }
    
    func addSybolDiscrView() {
        scrolView.addSubview(symbolDescribeView)
        
        symbolDescribeView.translatesAutoresizingMaskIntoConstraints = false
        symbolDescribeView.widthAnchor.constraint(equalTo: scrolView.widthAnchor, multiplier: 95/100).isActive = true
        symbolDescribeView.topAnchor.constraint(equalTo: viewForTable.bottomAnchor, constant: 10).isActive = true
        symbolDescribeView.heightAnchor.constraint(equalToConstant: 820).isActive = true
        symbolDescribeView.centerXAnchor.constraint(equalTo: scrolView.centerXAnchor).isActive = true
        
        symbolDescribeView.backgroundColor = .white
        symbolDescribeView.layer.cornerRadius = 20
        symbolDescribeView.layer.shadowOpacity = 0.1
        symbolDescribeView.layer.shadowColor = UIColor.gray.cgColor
        
        
        symbolDescribeView.addSubview(firstLabel)
        
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.widthAnchor.constraint(equalTo: symbolDescribeView.widthAnchor, multiplier: 1).isActive = true
        firstLabel.topAnchor.constraint(equalTo: symbolDescribeView.topAnchor, constant: 0).isActive = true
        firstLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        firstLabel.numberOfLines = 0
        firstLabel.textAlignment = .natural
        firstLabel.text = "   В приложении (в тесте на наличие близорукости)  используются оптотипы Ландольта (символ 'С') и оптотипы Снеллена (символ 'Ш')."
        
        symbolDescribeView.addSubview(landoltView)
        
        landoltView.translatesAutoresizingMaskIntoConstraints = false
        landoltView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        landoltView.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 20).isActive = true
        landoltView.leftAnchor.constraint(equalTo: symbolDescribeView.leftAnchor, constant: 20).isActive = true
        landoltView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        symbolDescribeView.addSubview(landoltLabel)
        
        landoltLabel.translatesAutoresizingMaskIntoConstraints = false
        landoltLabel.rightAnchor.constraint(equalTo: symbolDescribeView.rightAnchor).isActive = true
        landoltLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 0).isActive = true
        landoltLabel.leftAnchor.constraint(equalTo: landoltView.rightAnchor, constant: 20).isActive = true
        landoltLabel.heightAnchor.constraint(equalToConstant: 210).isActive = true
        
        landoltLabel.numberOfLines = 0
        landoltLabel.textAlignment = .natural
        landoltLabel.text = "Оптотипы Ландольта по форме представляют собой черные кольца разной величины с разрывами, обращенными в разные стороны, и по распознаванию этого разрыва можно определить минимальный угол разрешения глаза."// Ширина кольца Ландольта и ширина разрыва в 5 раз меньше его наружного диаметра, то есть соотношение этих параметров – 5 : 1 : 1. Направление разрыва кольца может иметь четыре варианта (вверху, внизу, справа и слева)."
        
        
        symbolDescribeView.addSubview(secondLandoltLabel)
        
        secondLandoltLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLandoltLabel.rightAnchor.constraint(equalTo: symbolDescribeView.rightAnchor).isActive = true
        secondLandoltLabel.topAnchor.constraint(equalTo: landoltLabel.bottomAnchor, constant: 0).isActive = true
        secondLandoltLabel.leftAnchor.constraint(equalTo: symbolDescribeView.leftAnchor, constant: 0).isActive = true
        secondLandoltLabel.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        secondLandoltLabel.numberOfLines = 0
        secondLandoltLabel.textAlignment = .natural
        secondLandoltLabel.text = "Ширина кольца Ландольта и ширина разрыва в 5 раз меньше его наружного диаметра, то есть соотношение этих параметров – 5 : 1 : 1. Направление разрыва кольца может иметь четыре варианта (вверху, внизу, справа и слева)."
        
        symbolDescribeView.addSubview(snelenView)
        
        snelenView.translatesAutoresizingMaskIntoConstraints = false
        snelenView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        snelenView.topAnchor.constraint(equalTo: secondLandoltLabel.bottomAnchor, constant: 60).isActive = true
        snelenView.leftAnchor.constraint(equalTo: symbolDescribeView.leftAnchor, constant: 20).isActive = true
        snelenView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        symbolDescribeView.addSubview(snelenLabel)
        
        snelenLabel.translatesAutoresizingMaskIntoConstraints = false
        snelenLabel.rightAnchor.constraint(equalTo: symbolDescribeView.rightAnchor).isActive = true
        snelenLabel.topAnchor.constraint(equalTo: secondLandoltLabel.bottomAnchor, constant: 0).isActive = true
        snelenLabel.leftAnchor.constraint(equalTo: snelenView.rightAnchor, constant: 20).isActive = true
        snelenLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        snelenLabel.numberOfLines = 0
        snelenLabel.textAlignment = .natural
        snelenLabel.text = "Оптотип Снеллена - вписанная в квадрат фигура, подобная букве 'Ш', которая может иметь 4 ориентации. Такие знаки также широко используются в офтальмологии."
    }
    
    
    
    
    func addScrollInfoView() {
        
        view.addSubview(scrollInfoView)
        scrollInfoView.translatesAutoresizingMaskIntoConstraints = false
        scrollInfoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        scrollInfoView.topAnchor.constraint(equalTo: segmentedContr.bottomAnchor).isActive = true
        
        scrollInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollInfoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollInfoView.contentSize = CGSize(width: view.frame.width, height: 1890)
        
    }
    
    
}
