

import UIKit

class InfoStartViewController: UIViewController {

    var state = false
    var timer = Timer()
    
    let segmentedContr = UISegmentedControl(items: ["Информация","Инструкция"])
    
    //информация
    let scrolView = UIScrollView()
    
    let viewForDescrMyopia = UIView()
    let myopiaDescrLabel = UILabel()
    let eyeView = EyeView()
    let myopiaLight = MyopiaLightView()
    
    let attantionView = UIView()
    let ahtungLabel = UILabel()
    let attantionLabel = UILabel()
    let eyeNormView = EyeView()
    let normLight = NormalLightView()
    let landoltAtentionView = LandoltLeftUIView()
    
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
    let symbolDescrButton = UIButton()
    
    
    //инструкция
    let scrollInfoView = UIScrollView()
    
    let firstInstrView = UIView()
    let howDoTestLabel = UILabel()
    let basicMiopScreenImageView = UIImageView()
    let symbolDiscrLBS = SpeakLeftBottomView()
    let stopBtnDiscrLBS = SpeakLeftBottomView()
    let actionBtnDiscrLTS = SpeakLeftTopView()
    let deviceDetectDiscrRTS = SpeakRightTopView()
    let distanceDiscrRBS = SpeakRightBottomView()
    let distanceDiscrLabel = UILabel()
    let deviceDetectLabel = UILabel()
    let actionBtnLabel = UILabel()
    let stopBtnDiscrLabel = UILabel()
    let symbolDiscrLabel = UILabel()
    
    let bigLabel = UILabel()
    
    
    let secondInstrView = UIView()
    let howDoRecognLabel = UILabel()
    let speechRecScreenImageView = UIImageView()
    let speechSymbolDiscrLBS = SpeakLeftBottomView()
    let lineDescrLTS = SpeakLeftTopView()
    let speechSymbolDiscrLabel = UILabel()
    let lineDescrLabel = UILabel()
    
    let thirdInstrView = UIView()
    let howDoAutoDetectLabel = UILabel()
    
    //MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = #colorLiteral(red: 0.6561266184, green: 0.9085168242, blue: 0.9700091481, alpha: 1)
        
//        viewArray = [lastSpere, sphereView, sectorView, degr90, rotateView, scaledView, oneDegreeView, minutesView]
//        currentView = viewArray[numberView]
//        textArray = ["1", "2", "3", "4", "5", "6", "7", "8"]
        
        if state {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(navAction))
        }
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(animateButton), userInfo: nil, repeats: true)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        addSegmContr()
        addScrollView()

        addMyopViews()
        
        addAttentionView()
        addTableViews()
        addSybolDiscrView()
        //addDegreeView()
        
        
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
    
    //MARK: segmentContrAction()
    @objc func segmentContrAction() {
        if segmentedContr.selectedSegmentIndex == 0{
            
            scrollInfoView.removeFromSuperview()
            
            addScrollView()
            addMyopViews()
            addAttentionView()
            addTableViews()
            addSybolDiscrView()
            //addDegreeView()
            
        }else if segmentedContr.selectedSegmentIndex == 1{
            scrolView.removeFromSuperview()
            
            addScrollInfoView()
            addFirstInstrView()
            addSecondInstrView()
            addThirdInstrView()
        }
    }
    
    
     //MARK: описание
    func addScrollView() {
        
        view.addSubview(scrolView)
        scrolView.translatesAutoresizingMaskIntoConstraints = false
        scrolView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        scrolView.topAnchor.constraint(equalTo: segmentedContr.bottomAnchor).isActive = true
        
        scrolView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrolView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrolView.contentSize = CGSize(width: view.frame.width, height: 2260)
        
    }
    //MARK: окно миопия
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
        myopiaDescrLabel.widthAnchor.constraint(equalTo: viewForDescrMyopia.widthAnchor, multiplier: 95/100).isActive = true
        myopiaDescrLabel.topAnchor.constraint(equalTo: eyeView.bottomAnchor, constant: 0).isActive = true
        myopiaDescrLabel.heightAnchor.constraint(equalToConstant: 320).isActive = true
        myopiaDescrLabel.centerXAnchor.constraint(equalTo: viewForDescrMyopia.centerXAnchor).isActive = true
        
        myopiaDescrLabel.numberOfLines = 0
        myopiaDescrLabel.textAlignment = .natural
        myopiaDescrLabel.text = "   Близорукость, или миопия – самая распространенная причина низкого зрения у человека в наши дни. \n\n   Попадающие в глаз лучи света фокусируются до сетчатки, когда роговица и хрусталик чрезмерно сильно изменяют их ход. \n    Человек плохо видит при миопии из-за несоответствия силы оптики глаза и размера глазного яблока, при котором лучи света формируют изображение раньше, чем они достигнут сетчатки. И когда они все-таки попадают на нее, то картинка становиться размытой."

        
    }
    //MARK: окно внимание
    func addAttentionView() {
        scrolView.addSubview(attantionView)
        
        attantionView.translatesAutoresizingMaskIntoConstraints = false
        attantionView.widthAnchor.constraint(equalTo: scrolView.widthAnchor, multiplier: 95/100).isActive = true
        attantionView.topAnchor.constraint(equalTo: viewForDescrMyopia.bottomAnchor, constant: 10).isActive = true
        attantionView.heightAnchor.constraint(equalToConstant: 520).isActive = true
        attantionView.centerXAnchor.constraint(equalTo: scrolView.centerXAnchor).isActive = true
        attantionView.backgroundColor = .white
        
        attantionView.layer.cornerRadius = 20
        attantionView.layer.shadowOpacity = 0.1
        attantionView.layer.shadowColor = UIColor.gray.cgColor
        
        attantionView.addSubview(eyeNormView)
        attantionView.addSubview(normLight)
        attantionView.addSubview(landoltAtentionView)
        attantionView.addSubview(ahtungLabel)
        
        ahtungLabel.translatesAutoresizingMaskIntoConstraints = false
        ahtungLabel.widthAnchor.constraint(equalTo: attantionView.widthAnchor).isActive = true
        ahtungLabel.topAnchor.constraint(equalTo: attantionView.topAnchor, constant: 0).isActive = true
        ahtungLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        ahtungLabel.numberOfLines = 0
        ahtungLabel.textAlignment = .center
        ahtungLabel.text = "Внимание!"
        ahtungLabel.textColor = .red
        ahtungLabel.font = .boldSystemFont(ofSize: 17)
        
        
        eyeNormView.translatesAutoresizingMaskIntoConstraints = false
        eyeNormView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        eyeNormView.topAnchor.constraint(equalTo: ahtungLabel.bottomAnchor, constant: 0).isActive = true
        eyeNormView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        eyeNormView.rightAnchor.constraint(equalTo: attantionView.rightAnchor, constant: -50).isActive = true
        eyeNormView.backgroundColor = .clear
        
        normLight.translatesAutoresizingMaskIntoConstraints = false
        normLight.widthAnchor.constraint(equalToConstant: 200).isActive = true
        normLight.topAnchor.constraint(equalTo: ahtungLabel.bottomAnchor, constant: 0).isActive = true
        normLight.heightAnchor.constraint(equalToConstant: 200).isActive = true
        normLight.rightAnchor.constraint(equalTo: attantionView.rightAnchor, constant: -50).isActive = true
        normLight.backgroundColor = .clear
        
        let distanceLabel = UILabel()
        eyeNormView.addSubview(distanceLabel)
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        distanceLabel.bottomAnchor.constraint(equalTo: eyeNormView.bottomAnchor, constant: -35).isActive = true
        distanceLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        distanceLabel.leftAnchor.constraint(equalTo: eyeNormView.leftAnchor, constant: 5).isActive = true
        distanceLabel.backgroundColor = .clear
        
        distanceLabel.text = "5 м."
        distanceLabel.font = .boldSystemFont(ofSize: 10)
        distanceLabel.textColor = .red
        distanceLabel.textAlignment = .center
        
        landoltAtentionView.translatesAutoresizingMaskIntoConstraints = false
        landoltAtentionView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        landoltAtentionView.rightAnchor.constraint(equalTo: eyeNormView.leftAnchor, constant: 0).isActive = true
        landoltAtentionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        landoltAtentionView.centerYAnchor.constraint(equalTo: eyeNormView.centerYAnchor).isActive = true
        landoltAtentionView.backgroundColor = .clear
        
        
        attantionView.addSubview(attantionLabel)
        
        attantionLabel.translatesAutoresizingMaskIntoConstraints = false
        attantionLabel.widthAnchor.constraint(equalTo: attantionView.widthAnchor, multiplier: 95/100).isActive = true
        attantionLabel.topAnchor.constraint(equalTo: eyeNormView.bottomAnchor, constant: 0).isActive = true
        attantionLabel.heightAnchor.constraint(equalToConstant: 320).isActive = true
        attantionLabel.centerXAnchor.constraint(equalTo: attantionView.centerXAnchor).isActive = true
        
        attantionLabel.numberOfLines = 0
        attantionLabel.textAlignment = .natural
        attantionLabel.text = "   При нормальном зрении точка ясного видения находится как бы в бесконечности. Для человеческого глаза бесконечность начинается на расстоянии 5 метров: при расположении предмета не ближе 5 метров на сетчатке глаза с нормальным зрением собираются параллельные лучи. Именно поэтому проверку остроты зрения осуществляют с такого расстояния."
    }
    //MARK: окно таблицы
    func addTableViews() {
        
        scrolView.addSubview(viewForTable)
        
        viewForTable.translatesAutoresizingMaskIntoConstraints = false
        viewForTable.widthAnchor.constraint(equalTo: scrolView.widthAnchor, multiplier: 95/100).isActive = true
        viewForTable.topAnchor.constraint(equalTo: attantionView.bottomAnchor, constant: 10).isActive = true
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
        tableDescrLabel.widthAnchor.constraint(equalTo: viewForTable.widthAnchor, multiplier: 95/100).isActive = true
        tableDescrLabel.topAnchor.constraint(equalTo: tableImageView.bottomAnchor, constant: 0).isActive = true
        tableDescrLabel.heightAnchor.constraint(equalToConstant: 320).isActive = true
        tableDescrLabel.centerXAnchor.constraint(equalTo: viewForTable.centerXAnchor).isActive = true
        
        tableDescrLabel.numberOfLines = 0
        tableDescrLabel.textAlignment = .natural
        tableDescrLabel.text = "   Чтобы определить остроту зрения человека, подбирая контактные линзы, очки или ради профилактики, применяют специальные таблицы, которые бывают разных видов. Но в целом процедура диагностики происходит по одному принципу:\n 1. Человека усаживают напротив таблицы на определенном расстоянии.\n 2. Врач указывает на строку или символ на таблице, просит человека его назвать.\n 3. Если человек хорошо может различить указанный символ, врач указывает на более мелкий шрифт."
        
        
    }
    //MARK: окно символов в тесте
    func addSybolDiscrView() {
        scrolView.addSubview(symbolDescribeView)
        
        symbolDescribeView.translatesAutoresizingMaskIntoConstraints = false
        symbolDescribeView.widthAnchor.constraint(equalTo: scrolView.widthAnchor, multiplier: 95/100).isActive = true
        symbolDescribeView.topAnchor.constraint(equalTo: viewForTable.bottomAnchor, constant: 10).isActive = true
        symbolDescribeView.heightAnchor.constraint(equalToConstant: 650).isActive = true
        symbolDescribeView.centerXAnchor.constraint(equalTo: scrolView.centerXAnchor).isActive = true
        
        symbolDescribeView.backgroundColor = .white
        symbolDescribeView.layer.cornerRadius = 20
        symbolDescribeView.layer.shadowOpacity = 0.1
        symbolDescribeView.layer.shadowColor = UIColor.gray.cgColor
        
        
        symbolDescribeView.addSubview(firstLabel)
        
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.widthAnchor.constraint(equalTo: symbolDescribeView.widthAnchor, multiplier: 95/100).isActive = true
        firstLabel.topAnchor.constraint(equalTo: symbolDescribeView.topAnchor, constant: 0).isActive = true
        firstLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        firstLabel.centerXAnchor.constraint(equalTo: symbolDescribeView.centerXAnchor).isActive = true
        
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
        
        symbolDescribeView.addSubview(symbolDescrButton)
        
        symbolDescrButton.translatesAutoresizingMaskIntoConstraints = false
        symbolDescrButton.topAnchor.constraint(equalTo: landoltView.bottomAnchor, constant: 10).isActive = true
        symbolDescrButton.bottomAnchor.constraint(equalTo: landoltLabel.bottomAnchor, constant: -10).isActive = true
        symbolDescrButton.leftAnchor.constraint(equalTo: symbolDescribeView.leftAnchor, constant: 10).isActive = true
        symbolDescrButton.rightAnchor.constraint(equalTo: landoltLabel.leftAnchor, constant: -10).isActive = true
        
        symbolDescrButton.backgroundColor = .white
        //symbolDescrButton.layer.borderWidth = 0.3
        symbolDescrButton.layer.cornerRadius = 5
        symbolDescrButton.layer.shadowOpacity = 0.1
        symbolDescrButton.layer.shadowColor = UIColor.black.cgColor
        symbolDescrButton.setTitle("Подробнее о размерах символа...", for: .normal)
        symbolDescrButton.setTitleColor(.systemBlue, for: .normal)
        symbolDescrButton.titleLabel?.font = .systemFont(ofSize: 10)
        symbolDescrButton.titleLabel?.numberOfLines = 0
        symbolDescrButton.addTarget(self, action: #selector(symbolDescrButtonAction), for: .touchUpInside)
        
        symbolDescribeView.addSubview(secondLandoltLabel)
        
        secondLandoltLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLandoltLabel.rightAnchor.constraint(equalTo: symbolDescribeView.rightAnchor).isActive = true
        secondLandoltLabel.topAnchor.constraint(equalTo: landoltLabel.bottomAnchor, constant: 0).isActive = true
        secondLandoltLabel.leftAnchor.constraint(equalTo: symbolDescribeView.leftAnchor, constant: 5).isActive = true
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
    
    //MARK: окно про 1 угловую минуту
//    func addDegreeView() {
//        scrolView.addSubview(minuteDegreeView)
//        minuteDegreeView.translatesAutoresizingMaskIntoConstraints = false
//        minuteDegreeView.topAnchor.constraint(equalTo: symbolDescribeView.bottomAnchor, constant: 10).isActive = true
//        minuteDegreeView.widthAnchor.constraint(equalTo: scrolView.widthAnchor, multiplier: 95/100).isActive = true
//        minuteDegreeView.heightAnchor.constraint(equalToConstant: 650).isActive = true
//        minuteDegreeView.centerXAnchor.constraint(equalTo: scrolView.centerXAnchor).isActive = true
//
//        minuteDegreeView.backgroundColor = .white
//        minuteDegreeView.layer.cornerRadius = 20
//        minuteDegreeView.layer.shadowOpacity = 0.1
//        minuteDegreeView.layer.shadowColor = UIColor.gray.cgColor
//
//
//
//        minuteDegreeView.addSubview(nextButton)
//        nextButton.translatesAutoresizingMaskIntoConstraints = false
//        nextButton.bottomAnchor.constraint(equalTo: minuteDegreeView.bottomAnchor).isActive = true
//        nextButton.widthAnchor.constraint(equalTo: minuteDegreeView.widthAnchor, multiplier: 1/3).isActive = true
//        nextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        nextButton.centerXAnchor.constraint(equalTo: minuteDegreeView.centerXAnchor).isActive = true
//
//        nextButton.setTitle("дальше", for: .normal)
//        nextButton.setTitleColor(.black, for: .normal)
//        nextButton.backgroundColor = .white
//        nextButton.layer.cornerRadius = 10
//        nextButton.layer.shadowOpacity = 0.1
//        nextButton.layer.shadowColor = UIColor.gray.cgColor
//        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
//
//        addRemovedView()
//
//    }
//
//    func addRemovedView() {
//        minuteDegreeView.addSubview(currentView)
//        currentView.translatesAutoresizingMaskIntoConstraints = false
//        currentView.widthAnchor.constraint(equalTo: minuteDegreeView.widthAnchor).isActive = true
//        currentView.heightAnchor.constraint(equalTo: minuteDegreeView.widthAnchor).isActive = true
//        currentView.topAnchor.constraint(equalTo: minuteDegreeView.topAnchor, constant: 20).isActive = true
//        currentView.centerXAnchor.constraint(equalTo: minuteDegreeView.centerXAnchor).isActive = true
//
//        currentView.backgroundColor = .clear
//
//        minuteDegreeView.addSubview(degreeDescrLabel)
//        degreeDescrLabel.translatesAutoresizingMaskIntoConstraints = false
//        degreeDescrLabel.widthAnchor.constraint(equalTo: minuteDegreeView.widthAnchor).isActive = true
//        degreeDescrLabel.topAnchor.constraint(equalTo: currentView.bottomAnchor).isActive = true
//        degreeDescrLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor).isActive = true
//
//        degreeDescrLabel.text = textArray[numberView]
//    }
//
//    @objc func nextButtonAction() {
//        if numberView == viewArray.count-1{
//            numberView = 0
//        }else{
//            numberView += 1
//        }
//
//        currentView.removeFromSuperview()
//        degreeDescrLabel.removeFromSuperview()
//        currentView = viewArray[numberView]
//        degreeDescrLabel.text = textArray[numberView]
//        addRemovedView()
//
//    }
    
    
    
    //MARK: инструкция
    
    func addScrollInfoView() {
        
        view.addSubview(scrollInfoView)
        scrollInfoView.translatesAutoresizingMaskIntoConstraints = false
        scrollInfoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        scrollInfoView.topAnchor.constraint(equalTo: segmentedContr.bottomAnchor).isActive = true
        
        scrollInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollInfoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollInfoView.contentSize = CGSize(width: view.frame.width, height: 1890)
        
    }
    
    
    //MARK:addFirstInstrView()
    func addFirstInstrView() {
        scrollInfoView.addSubview(firstInstrView)
        
        firstInstrView.translatesAutoresizingMaskIntoConstraints = false
        firstInstrView.widthAnchor.constraint(equalTo: scrollInfoView.widthAnchor, multiplier: 95/100).isActive = true
        firstInstrView.topAnchor.constraint(equalTo: scrollInfoView.topAnchor, constant: 10).isActive = true
        firstInstrView.heightAnchor.constraint(equalToConstant: 650).isActive = true
        firstInstrView.centerXAnchor.constraint(equalTo: scrollInfoView.centerXAnchor).isActive = true
        
        firstInstrView.backgroundColor = #colorLiteral(red: 0.912041011, green: 0.9828456094, blue: 1, alpha: 1)
        firstInstrView.layer.cornerRadius = 20
        firstInstrView.layer.shadowOpacity = 0.1
        firstInstrView.layer.shadowColor = UIColor.gray.cgColor
        
        
        firstInstrView.addSubview(basicMiopScreenImageView)
        
        basicMiopScreenImageView.translatesAutoresizingMaskIntoConstraints = false
        basicMiopScreenImageView.widthAnchor.constraint(equalTo: firstInstrView.widthAnchor, multiplier: 1/2).isActive = true
        basicMiopScreenImageView.heightAnchor.constraint(equalTo: basicMiopScreenImageView.widthAnchor, multiplier: 2.1).isActive = true
        basicMiopScreenImageView.centerXAnchor.constraint(equalTo: firstInstrView.centerXAnchor).isActive = true
        basicMiopScreenImageView.centerYAnchor.constraint(equalTo: firstInstrView.centerYAnchor).isActive = true
        basicMiopScreenImageView.backgroundColor = .clear
        basicMiopScreenImageView.image = UIImage(named: "basic miopia test screen")
        basicMiopScreenImageView.layer.borderWidth = 0.5
        
        
        addSymbolDescrView()
        
        addStopBtnDescrView()
        
        addActionBtnDescrView()
        
        addDeviceDescrView()
        
        addDistanceDescrView()
        
        addHowDoTestLabel()
        
        
    }
    
    func addHowDoTestLabel() {
        
        firstInstrView.addSubview(howDoTestLabel)
        howDoTestLabel.translatesAutoresizingMaskIntoConstraints = false
        howDoTestLabel.rightAnchor.constraint(equalTo: firstInstrView.rightAnchor, constant: -20).isActive = true
        howDoTestLabel.topAnchor.constraint(equalTo: firstInstrView.topAnchor, constant: 20).isActive = true
        howDoTestLabel.heightAnchor.constraint(equalTo: firstInstrView.heightAnchor, multiplier: 1/7).isActive = true
        howDoTestLabel.leftAnchor.constraint(equalTo: firstInstrView.leftAnchor, constant: 20).isActive = true
        howDoTestLabel.backgroundColor = .clear
        howDoTestLabel.numberOfLines = 0
        howDoTestLabel.font = .systemFont(ofSize: 15)
        howDoTestLabel.text = "   Расположите телефон на расстоянии, уcтановленном в настройках приложения. Называйте направления символа вашему ассистенту, который будет нажимать соответствующие кнопки на экране телефона. "
    }
    
    fileprivate func addSymbolDescrView() {
        firstInstrView.addSubview(symbolDiscrLBS)
        symbolDiscrLBS.radius = 10
        symbolDiscrLBS.fat = 10
        symbolDiscrLBS.ratio = 1/2
        
        symbolDiscrLBS.translatesAutoresizingMaskIntoConstraints = false
        symbolDiscrLBS.rightAnchor.constraint(equalTo: firstInstrView.rightAnchor, constant: -5).isActive = true
        symbolDiscrLBS.topAnchor.constraint(equalTo: basicMiopScreenImageView.topAnchor, constant: 0).isActive = true
        symbolDiscrLBS.heightAnchor.constraint(equalTo: basicMiopScreenImageView.heightAnchor, multiplier: 1/3).isActive = true
        symbolDiscrLBS.leftAnchor.constraint(equalTo: basicMiopScreenImageView.centerXAnchor, constant: 10).isActive = true
        symbolDiscrLBS.backgroundColor = .clear
        
        
        symbolDiscrLBS.addSubview(symbolDiscrLabel)
        symbolDiscrLabel.translatesAutoresizingMaskIntoConstraints = false
        symbolDiscrLabel.rightAnchor.constraint(equalTo: symbolDiscrLBS.rightAnchor, constant: -5).isActive = true
        symbolDiscrLabel.topAnchor.constraint(equalTo: symbolDiscrLBS.topAnchor, constant: 5).isActive = true
        symbolDiscrLabel.heightAnchor.constraint(equalTo: symbolDiscrLBS.heightAnchor, multiplier: 10/11).isActive = true
        symbolDiscrLabel.widthAnchor.constraint(equalTo: symbolDiscrLBS.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        symbolDiscrLabel.backgroundColor = .clear
        symbolDiscrLabel.text = "Оптотипы Ландольта по форме представляют собой черные кольца разной величины с разрывами, обращенными в разные стороны, и по распознаванию этого разрыва можно определить минимальный угол разрешения глаза.  Направление разрыва кольца может иметь четыре варианта (вверху, внизу, справа и слева)"
        symbolDiscrLabel.font = .systemFont(ofSize: 7)
        symbolDiscrLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        
        symbolDiscrLabel.isUserInteractionEnabled = true
        
        symbolDiscrLabel.addGestureRecognizer(tap)
        lupaInView(view: symbolDiscrLabel)
    }
    
    fileprivate func addStopBtnDescrView() {
        firstInstrView.addSubview(stopBtnDiscrLBS)
        stopBtnDiscrLBS.radius = 10
        stopBtnDiscrLBS.fat = 10
        stopBtnDiscrLBS.ratio = 1/2
        
        stopBtnDiscrLBS.translatesAutoresizingMaskIntoConstraints = false
        stopBtnDiscrLBS.rightAnchor.constraint(equalTo: firstInstrView.rightAnchor, constant: -5).isActive = true
        stopBtnDiscrLBS.topAnchor.constraint(equalTo: basicMiopScreenImageView.centerYAnchor, constant: 0).isActive = true
        stopBtnDiscrLBS.heightAnchor.constraint(equalTo: basicMiopScreenImageView.heightAnchor, multiplier: 1/4).isActive = true
        stopBtnDiscrLBS.leftAnchor.constraint(equalTo: basicMiopScreenImageView.centerXAnchor, constant: 10).isActive = true
        stopBtnDiscrLBS.backgroundColor = .clear
        
        
        stopBtnDiscrLBS.addSubview(stopBtnDiscrLabel)
        stopBtnDiscrLabel.translatesAutoresizingMaskIntoConstraints = false
        stopBtnDiscrLabel.rightAnchor.constraint(equalTo: stopBtnDiscrLBS.rightAnchor, constant: -5).isActive = true
        stopBtnDiscrLabel.topAnchor.constraint(equalTo: stopBtnDiscrLBS.topAnchor, constant: 5).isActive = true
        stopBtnDiscrLabel.heightAnchor.constraint(equalTo: stopBtnDiscrLBS.heightAnchor, multiplier: 10/11).isActive = true
        stopBtnDiscrLabel.widthAnchor.constraint(equalTo: stopBtnDiscrLBS.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        stopBtnDiscrLabel.backgroundColor = .clear
        stopBtnDiscrLabel.text = "Когда невозможно определить в какую сторону направлен символ - нажмите кнопку с символом '❌'. Тест будет остановлен, результат сохранится. Вам будет предложено пройти тест для другого глаза. Если Вы выйдете до окончания теста - результаты сохранены не будут."
        stopBtnDiscrLabel.font = .systemFont(ofSize: 7)
        stopBtnDiscrLabel.numberOfLines = 0
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        stopBtnDiscrLabel.isUserInteractionEnabled = true
        stopBtnDiscrLabel.addGestureRecognizer(tap)
        
        lupaInView(view: stopBtnDiscrLabel)
    }
    
    
    fileprivate func addActionBtnDescrView() {
        firstInstrView.addSubview(actionBtnDiscrLTS)
        actionBtnDiscrLTS.radius = 10
        actionBtnDiscrLTS.fat = 10
        actionBtnDiscrLTS.ratio = 1/2
        //actionBtnDiscrLTS.fillColor = .red
        
        actionBtnDiscrLTS.translatesAutoresizingMaskIntoConstraints = false
        actionBtnDiscrLTS.rightAnchor.constraint(equalTo: firstInstrView.rightAnchor, constant: -5).isActive = true
        actionBtnDiscrLTS.bottomAnchor.constraint(equalTo: basicMiopScreenImageView.bottomAnchor, constant: 50).isActive = true
        actionBtnDiscrLTS.heightAnchor.constraint(equalTo: basicMiopScreenImageView.heightAnchor, multiplier: 1/4).isActive = true
        actionBtnDiscrLTS.leftAnchor.constraint(equalTo: basicMiopScreenImageView.centerXAnchor, constant: 10).isActive = true
        actionBtnDiscrLTS.backgroundColor = .clear
        
        
        actionBtnDiscrLTS.addSubview(actionBtnLabel)
        actionBtnLabel.translatesAutoresizingMaskIntoConstraints = false
        actionBtnLabel.rightAnchor.constraint(equalTo: actionBtnDiscrLTS.rightAnchor, constant: -5).isActive = true
        actionBtnLabel.topAnchor.constraint(equalTo: actionBtnDiscrLTS.topAnchor, constant: 5).isActive = true
        actionBtnLabel.heightAnchor.constraint(equalTo: actionBtnDiscrLTS.heightAnchor, multiplier: 10/11).isActive = true
        actionBtnLabel.widthAnchor.constraint(equalTo: actionBtnDiscrLTS.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        actionBtnLabel.backgroundColor = .clear
        actionBtnLabel.text = "Если Вы можете различить в какую сторону направлен символ - Ваш ассистент должен нажать на кнопку, которую Вы ему назовете. \n В случае совпадения направления символа и стрелки на кнопке  - появится символ более мелкого размера. "
        actionBtnLabel.font = .systemFont(ofSize: 7)
        actionBtnLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        actionBtnLabel.isUserInteractionEnabled = true
        actionBtnLabel.addGestureRecognizer(tap)
        
        lupaInView(view: actionBtnLabel)
    }
    
    fileprivate func addDeviceDescrView() {
        firstInstrView.addSubview(deviceDetectDiscrRTS)
        deviceDetectDiscrRTS.radius = 10
        deviceDetectDiscrRTS.fat = 10
        deviceDetectDiscrRTS.ratio = 15/100
        
        deviceDetectDiscrRTS.translatesAutoresizingMaskIntoConstraints = false
        deviceDetectDiscrRTS.rightAnchor.constraint(equalTo: basicMiopScreenImageView.leftAnchor, constant: 10).isActive = true
        deviceDetectDiscrRTS.topAnchor.constraint(equalTo: basicMiopScreenImageView.bottomAnchor, constant: -20).isActive = true
        deviceDetectDiscrRTS.heightAnchor.constraint(equalTo: basicMiopScreenImageView.heightAnchor, multiplier: 1/4).isActive = true
        deviceDetectDiscrRTS.leftAnchor.constraint(equalTo: firstInstrView.leftAnchor, constant: 5).isActive = true
        deviceDetectDiscrRTS.backgroundColor = .clear
        
        
        deviceDetectDiscrRTS.addSubview(deviceDetectLabel)
        deviceDetectLabel.translatesAutoresizingMaskIntoConstraints = false
        deviceDetectLabel.leftAnchor.constraint(equalTo: deviceDetectDiscrRTS.leftAnchor, constant: 5).isActive = true
        deviceDetectLabel.topAnchor.constraint(equalTo: deviceDetectDiscrRTS.topAnchor, constant: 5).isActive = true
        deviceDetectLabel.heightAnchor.constraint(equalTo: deviceDetectDiscrRTS.heightAnchor, multiplier: 10/11).isActive = true
        deviceDetectLabel.widthAnchor.constraint(equalTo: deviceDetectDiscrRTS.widthAnchor, multiplier: 85/100, constant: -10).isActive = true
        deviceDetectLabel.backgroundColor = .clear
        deviceDetectLabel.text = "Устройство, на котором запущено приложение. В зависимости от ширины экрана устройства происходит расчет размеров символа для определения остроты зрения."
        deviceDetectLabel.font = .systemFont(ofSize: 7)
        deviceDetectLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        deviceDetectLabel.isUserInteractionEnabled = true
        deviceDetectLabel.addGestureRecognizer(tap)
        
        lupaInView(view: deviceDetectLabel)
    }
    
    fileprivate func addDistanceDescrView() {
        firstInstrView.addSubview(distanceDiscrRBS)
        distanceDiscrRBS.radius = 10
        distanceDiscrRBS.fat = 5
        distanceDiscrRBS.ratio = 1/10
        
        distanceDiscrRBS.translatesAutoresizingMaskIntoConstraints = false
        distanceDiscrRBS.rightAnchor.constraint(equalTo: basicMiopScreenImageView.leftAnchor, constant: 5).isActive = true
        distanceDiscrRBS.bottomAnchor.constraint(equalTo: deviceDetectDiscrRTS.topAnchor, constant: -20).isActive = true
        distanceDiscrRBS.heightAnchor.constraint(equalTo: basicMiopScreenImageView.heightAnchor, multiplier: 1/4).isActive = true
        distanceDiscrRBS.leftAnchor.constraint(equalTo: firstInstrView.leftAnchor, constant: 5).isActive = true
        distanceDiscrRBS.backgroundColor = .clear
        
        
        distanceDiscrRBS.addSubview(distanceDiscrLabel)
        distanceDiscrLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceDiscrLabel.leftAnchor.constraint(equalTo: distanceDiscrRBS.leftAnchor, constant: 5).isActive = true
        distanceDiscrLabel.topAnchor.constraint(equalTo: distanceDiscrRBS.topAnchor, constant: 5).isActive = true
        distanceDiscrLabel.heightAnchor.constraint(equalTo: distanceDiscrRBS.heightAnchor, multiplier: 10/11).isActive = true
        distanceDiscrLabel.widthAnchor.constraint(equalTo: distanceDiscrRBS.widthAnchor, multiplier: 85/100, constant: -10).isActive = true
        distanceDiscrLabel.backgroundColor = .clear
        distanceDiscrLabel.text = " Расстояние, установленное для проведения теста. В зависимости от расстояния происходит расчет размеров символа для определения остроты зрения. Изменить расстояние проведения теста можно в настройках приложения."
        distanceDiscrLabel.font = .systemFont(ofSize: 7)
        distanceDiscrLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        distanceDiscrLabel.isUserInteractionEnabled = true
        distanceDiscrLabel.addGestureRecognizer(tap)
        
        lupaInView(view: distanceDiscrLabel)
    }
    //MARK:bigLabel
    @objc func bigLabelAction(recognizer: UIGestureRecognizer) {
        //var bottomAnch = symbolDiscrLBS.bottomAnchor
        var text = String()
        if recognizer.view == symbolDiscrLabel{
            
            text = symbolDiscrLabel.text ?? ""
            
        }else if recognizer.view == stopBtnDiscrLabel{
            text = stopBtnDiscrLabel.text ?? ""
            
        }else if recognizer.view == actionBtnLabel{
            text = actionBtnLabel.text ?? ""
            
        }else if recognizer.view == deviceDetectLabel{
            text = deviceDetectLabel.text ?? ""
            
        }else if recognizer.view == distanceDiscrLabel{
            text = distanceDiscrLabel.text ?? ""
            
        }else if recognizer.view == speechSymbolDiscrLabel{
            text = speechSymbolDiscrLabel.text ?? ""
            
        }
        else if recognizer.view == lineDescrLabel{
            text = lineDescrLabel.text ?? ""
            
        }
        
        //bigLabel.center = view.center
        bigLabel.frame = CGRect(origin: CGPoint(x: view.frame.width/6, y: view.frame.height/4),
                                size: CGSize(width: view.frame.width*2/3, height: view.frame.height/2))
        
        view.addSubview(bigLabel)
        
        bigLabel.text = text
        bigLabel.backgroundColor = .white
        bigLabel.numberOfLines = 0
        bigLabel.layer.cornerRadius = 20
        bigLabel.clipsToBounds = true
        bigLabel.layer.borderWidth = 1
        bigLabel.textAlignment = .center
        
        bigLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelRemove))
        bigLabel.addGestureRecognizer(tap)
    }
    
    
    @objc func bigLabelRemove(){
        bigLabel.removeFromSuperview()
    }
    //MARK: addSecondInstrView()
    func addSecondInstrView() {
        scrollInfoView.addSubview(secondInstrView)
        
        secondInstrView.translatesAutoresizingMaskIntoConstraints = false
        secondInstrView.widthAnchor.constraint(equalTo: scrollInfoView.widthAnchor, multiplier: 95/100).isActive = true
        secondInstrView.topAnchor.constraint(equalTo: firstInstrView.bottomAnchor, constant: 10).isActive = true
        secondInstrView.heightAnchor.constraint(equalToConstant: 650).isActive = true
        secondInstrView.centerXAnchor.constraint(equalTo: scrollInfoView.centerXAnchor).isActive = true
        
        secondInstrView.backgroundColor = #colorLiteral(red: 0.912041011, green: 0.9828456094, blue: 1, alpha: 1)
        secondInstrView.layer.cornerRadius = 20
        secondInstrView.layer.shadowOpacity = 0.1
        secondInstrView.layer.shadowColor = UIColor.gray.cgColor
        
        addHowDoRecognLabel()
        
    }
    
    func addHowDoRecognLabel() {
        secondInstrView.addSubview(howDoRecognLabel)
        
        howDoRecognLabel.translatesAutoresizingMaskIntoConstraints = false
        howDoRecognLabel.widthAnchor.constraint(equalTo: secondInstrView.widthAnchor, multiplier: 95/100).isActive = true
        howDoRecognLabel.topAnchor.constraint(equalTo: secondInstrView.topAnchor, constant: 10).isActive = true
        howDoRecognLabel.heightAnchor.constraint(equalTo: secondInstrView.heightAnchor, multiplier: 1/2, constant: 0).isActive = true
        howDoRecognLabel.centerXAnchor.constraint(equalTo: scrollInfoView.centerXAnchor).isActive = true
        
        howDoRecognLabel.text = "Для распознавания речи включите соответствующий переключатель в настройках приложения. Также установите время, которое Вам потребуется чтобы отойти от телефона на установленное расстояние.\n \nПри включении распознавания речи тест на наличие миопии можно проводить самостоятельно.\n Необходимо использовать беспроводную гарнитуру.\n "
        
        howDoRecognLabel.numberOfLines = 0
        
        secondInstrView.addSubview(speechRecScreenImageView)
        
        speechRecScreenImageView.translatesAutoresizingMaskIntoConstraints = false
        speechRecScreenImageView.widthAnchor.constraint(equalTo: secondInstrView.widthAnchor, multiplier: 1/3).isActive = true
        speechRecScreenImageView.heightAnchor.constraint(equalTo: speechRecScreenImageView.widthAnchor, multiplier: 2.1).isActive = true
        speechRecScreenImageView.leftAnchor.constraint(equalTo: secondInstrView.leftAnchor, constant: 20).isActive = true
        speechRecScreenImageView.bottomAnchor.constraint(equalTo: secondInstrView.bottomAnchor, constant: -40).isActive = true
        speechRecScreenImageView.backgroundColor = .clear
        speechRecScreenImageView.image = UIImage(named: "Speech Recognition myopia Test screen")
        speechRecScreenImageView.layer.borderWidth = 0.5
        
        addSpeechSymbolDescrView()
        
        addLineDescrView()
    }
    
    func addSpeechSymbolDescrView() {
        
        secondInstrView.addSubview(speechSymbolDiscrLBS)
        
        speechSymbolDiscrLBS.radius = 10
        speechSymbolDiscrLBS.fat = 10
        speechSymbolDiscrLBS.ratio = 3/10
        
        speechSymbolDiscrLBS.translatesAutoresizingMaskIntoConstraints = false
        speechSymbolDiscrLBS.topAnchor.constraint(equalTo: speechRecScreenImageView.topAnchor).isActive = true
        speechSymbolDiscrLBS.leftAnchor.constraint(equalTo: speechRecScreenImageView.centerXAnchor, constant: 10).isActive = true
        speechSymbolDiscrLBS.heightAnchor.constraint(equalTo: speechRecScreenImageView.heightAnchor, multiplier: 1/3).isActive = true
        speechSymbolDiscrLBS.rightAnchor.constraint(equalTo: secondInstrView.rightAnchor, constant: -20).isActive = true
        speechSymbolDiscrLBS.backgroundColor = .clear
        
        speechSymbolDiscrLBS.addSubview(speechSymbolDiscrLabel)
        
        speechSymbolDiscrLabel.translatesAutoresizingMaskIntoConstraints = false
        speechSymbolDiscrLabel.topAnchor.constraint(equalTo: speechSymbolDiscrLBS.topAnchor, constant: 5).isActive = true
        speechSymbolDiscrLabel.rightAnchor.constraint(equalTo: speechSymbolDiscrLBS.rightAnchor, constant: -5).isActive = true
        speechSymbolDiscrLabel.heightAnchor.constraint(equalTo: speechSymbolDiscrLBS.heightAnchor, constant: -10).isActive = true
        speechSymbolDiscrLabel.widthAnchor.constraint(equalTo: speechSymbolDiscrLBS.widthAnchor, multiplier: 7/10, constant: -10).isActive = true
        speechSymbolDiscrLabel.backgroundColor = .clear
        
        speechSymbolDiscrLabel.text = "Если Вы можете различить в какую сторону направлен символ - произнесите в микрофон гарнитуры направление символа: 'вправо', 'влево', 'вверх' или 'вниз'. Когда Вы правильно назвали 3 из 4-х направлений - на экране появится символ более мелкого размера. Если невозможно определить направление символа - произнесите слово 'СТОП'. Тест завершится. Результат будет сохранен."
        speechSymbolDiscrLabel.font = .systemFont(ofSize: 7)
        speechSymbolDiscrLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        speechSymbolDiscrLabel.isUserInteractionEnabled = true
        speechSymbolDiscrLabel.addGestureRecognizer(tap)
        
        lupaInView(view: speechSymbolDiscrLabel)
    }
    
    func addLineDescrView() {
        
        secondInstrView.addSubview(lineDescrLTS)
        
        lineDescrLTS.radius = 10
        lineDescrLTS.fat = 5
        lineDescrLTS.ratio = 3/10
        
        lineDescrLTS.translatesAutoresizingMaskIntoConstraints = false
        lineDescrLTS.topAnchor.constraint(equalTo: speechRecScreenImageView.centerYAnchor,  constant: 20).isActive = true
        lineDescrLTS.leftAnchor.constraint(equalTo: speechRecScreenImageView.centerXAnchor, constant: 20).isActive = true
        lineDescrLTS.heightAnchor.constraint(equalTo: speechRecScreenImageView.heightAnchor, multiplier: 1/7).isActive = true
        lineDescrLTS.rightAnchor.constraint(equalTo: secondInstrView.rightAnchor, constant: -20).isActive = true
        lineDescrLTS.backgroundColor = .clear
        
        lineDescrLTS.addSubview(lineDescrLabel)
        
        lineDescrLabel.translatesAutoresizingMaskIntoConstraints = false
        lineDescrLabel.topAnchor.constraint(equalTo: lineDescrLTS.topAnchor, constant: 5).isActive = true
        lineDescrLabel.rightAnchor.constraint(equalTo: lineDescrLTS.rightAnchor, constant: -5).isActive = true
        lineDescrLabel.heightAnchor.constraint(equalTo: lineDescrLTS.heightAnchor, constant: -10).isActive = true
        lineDescrLabel.widthAnchor.constraint(equalTo: lineDescrLTS.widthAnchor, multiplier: 7/10, constant: -10).isActive = true
        lineDescrLabel.backgroundColor = .clear
        
        lineDescrLabel.text = "Индикатор оставшегося времени до момента появления нового символа."
        lineDescrLabel.font = .systemFont(ofSize: 7)
        lineDescrLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        lineDescrLabel.isUserInteractionEnabled = true
        lineDescrLabel.addGestureRecognizer(tap)
        
        lupaInView(view: lineDescrLabel)
    }
    //MARK:addThirdInstrView()
    
    func addThirdInstrView() {
        
        scrollInfoView.addSubview(thirdInstrView)
        
        thirdInstrView.translatesAutoresizingMaskIntoConstraints = false
        thirdInstrView.widthAnchor.constraint(equalTo: scrollInfoView.widthAnchor, multiplier: 95/100).isActive = true
        thirdInstrView.topAnchor.constraint(equalTo: secondInstrView.bottomAnchor, constant: 10).isActive = true
        thirdInstrView.heightAnchor.constraint(equalToConstant: 550).isActive = true
        thirdInstrView.centerXAnchor.constraint(equalTo: scrollInfoView.centerXAnchor).isActive = true
        
        thirdInstrView.backgroundColor = #colorLiteral(red: 0.912041011, green: 0.9828456094, blue: 1, alpha: 1)
        thirdInstrView.layer.cornerRadius = 20
        thirdInstrView.layer.shadowOpacity = 0.1
        thirdInstrView.layer.shadowColor = UIColor.gray.cgColor
        
        addAutoDetectLabel()
    }
    
    func addAutoDetectLabel() {
        
        thirdInstrView.addSubview(howDoAutoDetectLabel)
        howDoAutoDetectLabel.translatesAutoresizingMaskIntoConstraints = false
        howDoAutoDetectLabel.rightAnchor.constraint(equalTo: thirdInstrView.rightAnchor, constant: -20).isActive = true
        howDoAutoDetectLabel.topAnchor.constraint(equalTo: thirdInstrView.topAnchor, constant: 20).isActive = true
        howDoAutoDetectLabel.heightAnchor.constraint(equalTo: thirdInstrView.heightAnchor, multiplier: 7/8).isActive = true
        howDoAutoDetectLabel.leftAnchor.constraint(equalTo: thirdInstrView.leftAnchor, constant: 20).isActive = true
        howDoAutoDetectLabel.backgroundColor = .clear
        howDoAutoDetectLabel.numberOfLines = 0
        howDoAutoDetectLabel.font = .systemFont(ofSize: 15)
        howDoAutoDetectLabel.text = "  Включите в настройках приложения переключатель автоматического определения расстояния. Для автоматического определения расстояния в помещении должно быть хорошее освещение.\n Установите время, которое Вам потребуется, чтобы отойти на планируемое расстояние.  \n\n!!!  При определении расстояния в кадре должно быть не более одного человека, стоящего лицом к фронтальной камере телефона:\n\n 📱    →    🧍 = ✅   \n \n Если будет более одного человека - расстояние может быть определено некорректно:\n\n 📱    →    👫 = 🚫 \n\n  Далее тест проводится также как при включенном распознавании речи."
    }
    
    func lupaInView(view: UIView){
        let labelLupa = UILabel()
        view.addSubview(labelLupa)
        labelLupa.translatesAutoresizingMaskIntoConstraints = false
        labelLupa.text = "🔎"
        labelLupa.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        labelLupa.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        labelLupa.widthAnchor.constraint(equalToConstant: 40).isActive = true
        labelLupa.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelLupa.alpha = 0.7
        labelLupa.font = .boldSystemFont(ofSize: 20)
    }
    
    @objc func navAction(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func symbolDescrButtonAction(){
        let degreeVC = DegreeViewController()
        self.navigationController?.pushViewController(degreeVC, animated: false)
        timer.invalidate()
        
    }
    
    @objc func animateButton(){
        
        UIButton.animate(withDuration: 0.1, animations: {
            self.symbolDescrButton.transform = CGAffineTransform(translationX: 0, y: 20)
        }) { (_) in
            UIButton.animate(withDuration: 0.1, animations: {
                self.symbolDescrButton.transform = CGAffineTransform(translationX: 0, y: -20)
            }) { (_) in
                UIButton.animate(withDuration: 0.05, animations: {
                    self.symbolDescrButton.transform = CGAffineTransform(translationX: 0, y: 5)
                }) { (_) in
                    UIButton.animate(withDuration: 0.05, animations: {
                        self.symbolDescrButton.transform = CGAffineTransform(translationX: 0, y: -5)
                    }) { (_) in
                        
                    }
                }
            }
        }
    }
    
}
