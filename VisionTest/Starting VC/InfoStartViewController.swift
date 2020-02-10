

import UIKit

class InfoStartViewController: UIViewController {

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
    
    
    //инструкция
    let scrollInfoView = UIScrollView()
    let firstInstrView = UIView()
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
    //MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = #colorLiteral(red: 0.6561266184, green: 0.9085168242, blue: 0.9700091481, alpha: 1)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        addSegmContr()
        addScrollView()

        addMyopViews()
        
        addAttentionView()
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
    
    //MARK: segmentContrAction()
    @objc func segmentContrAction() {
        if segmentedContr.selectedSegmentIndex == 0{
            
            scrollInfoView.removeFromSuperview()
            
            addScrollView()
            addMyopViews()
            addAttentionView()
            addTableViews()
            addSybolDiscrView()
            
        }else if segmentedContr.selectedSegmentIndex == 1{
            scrolView.removeFromSuperview()
            
            addScrollInfoView()
            addFirstInstrView()
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
    
    
    
    
    
    
    
    
    
    
    func addFirstInstrView() {
        scrollInfoView.addSubview(firstInstrView)
        
        firstInstrView.translatesAutoresizingMaskIntoConstraints = false
        firstInstrView.widthAnchor.constraint(equalTo: scrollInfoView.widthAnchor, multiplier: 95/100).isActive = true
        firstInstrView.topAnchor.constraint(equalTo: scrollInfoView.topAnchor, constant: 10).isActive = true
        firstInstrView.heightAnchor.constraint(equalToConstant: 650).isActive = true
        firstInstrView.centerXAnchor.constraint(equalTo: scrollInfoView.centerXAnchor).isActive = true
        
        firstInstrView.backgroundColor = .white
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
        stopBtnDiscrLabel.text = "Когда невозможно определить в какую сторону напрвлен символ - нажмите на эту кнопку. Тест будет остановлен, результат сохранится. Вам будет предложено пройти тест для другого глаза. Если Вы не нажмете на эту кнопку при выходе с этой страницы приложения - результаты сохранены не будут."
        stopBtnDiscrLabel.font = .systemFont(ofSize: 7)
        stopBtnDiscrLabel.numberOfLines = 0
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        stopBtnDiscrLBS.isUserInteractionEnabled = true
        stopBtnDiscrLBS.addGestureRecognizer(tap)
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
        actionBtnLabel.text = "Если Вы можете различить в какую сторону направлен символ - нажмите на кнопку, которая соответствут направлению символа. В случае совпадения направления символа и стрелки на кнопке  - появится символ более мелкого размера. "
        actionBtnLabel.font = .systemFont(ofSize: 7)
        actionBtnLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        actionBtnDiscrLTS.isUserInteractionEnabled = true
        actionBtnDiscrLTS.addGestureRecognizer(tap)
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
        deviceDetectLabel.text = "Окно, в котором отбражается устройство, на котором запущено приложение. В зависимости от ширины экрана устройства происходит расчет размеров символа для определения остроты зрения."
        deviceDetectLabel.font = .systemFont(ofSize: 7)
        deviceDetectLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        deviceDetectDiscrRTS.isUserInteractionEnabled = true
        deviceDetectDiscrRTS.addGestureRecognizer(tap)
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
        distanceDiscrLabel.text = "Окно, в котором отбражается расстояние, установленное для проведения теста. В зависимости от расстояния происходит расчет размеров символа для определения остроты зрения. Изменить расстояние проведения теста можно в настройках приложения."
        distanceDiscrLabel.font = .systemFont(ofSize: 7)
        distanceDiscrLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bigLabelAction(recognizer:)))
        distanceDiscrRBS.isUserInteractionEnabled = true
        distanceDiscrRBS.addGestureRecognizer(tap)
    }
    
    @objc func bigLabelAction(recognizer: UIGestureRecognizer) {
        //var bottomAnch = symbolDiscrLBS.bottomAnchor
        var text = String()
        if recognizer.view == symbolDiscrLBS{
            
            text = symbolDiscrLabel.text ?? ""
            
        }else if recognizer.view == stopBtnDiscrLBS{
            text = stopBtnDiscrLabel.text ?? ""
            
        }else if recognizer.view == actionBtnDiscrLTS{
            text = actionBtnLabel.text ?? ""
            
        }else if recognizer.view == deviceDetectDiscrRTS{
            text = deviceDetectLabel.text ?? ""
            
        }else if recognizer.view == distanceDiscrRBS{
            text = distanceDiscrLabel.text ?? ""
            
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
}
