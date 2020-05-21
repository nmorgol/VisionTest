

import UIKit


class GrafViewController: UIViewController {

    var sortedMiopiaArray: [MiopiaTestResult]?//отсортированные массивы по дате тестов
    var sortedHyperopiaArray: [HyperopiaTestResult]?
    var state = String()
    
    let segmentedContr = UISegmentedControl(items: ["5", "10", "30", "all"])
    var eyeSegmContr = UISegmentedControl()
    
    let mainGrafView = UIView()
    var countResult = CGFloat(40)
    
    var viewResArr = [UIButton]()
    var labelArr = [UILabel]()
    
    let describeLabel = UILabel()
    
    var leftTopView = SpeakLeftTopView()
    var rightTopView = SpeakRightTopView()
    var leftBottomView = SpeakLeftBottomView()
    var rightBottomView = SpeakRightBottomView()
    
    let formatter = DateFormatter()
    let currentDate = Date()
    
    let text = GrafVCText()
    var locale = "en_US"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eyeSegmContr = UISegmentedControl(items: text.eyeSegmContrText[locale])
        eyeSegmContr.selectedSegmentIndex = 2
        eyeSegmContr.addTarget(self, action: #selector(segmContrAction), for: .valueChanged)
        
        //sortedHyperopiaArray?.reverse()
        segmentedContr.selectedSegmentIndex = 0
        segmentedContr.addTarget(self, action: #selector(segmContrAction), for: .valueChanged)
        
        formatter.dateFormat = "dd.MM.yyyy"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(false)
        addSegmContr()
        addMainGraf()
        addLabels()
        addHorisontalLine()
        addResViews(inputMiopArray: sortedMiopiaArray, inputHypArray: sortedHyperopiaArray)
        addEyeSegmContr()
    }
    
    func addSegmContr() {
        self.view.addSubview(segmentedContr)
        segmentedContr.translatesAutoresizingMaskIntoConstraints = false
        segmentedContr.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).isActive = true
        segmentedContr.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentedContr.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    func addEyeSegmContr() {
        self.view.addSubview(eyeSegmContr)
        eyeSegmContr.translatesAutoresizingMaskIntoConstraints = false
        eyeSegmContr.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).isActive = true
        eyeSegmContr.heightAnchor.constraint(equalToConstant: 30).isActive = true
        eyeSegmContr.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func segmContrAction() {
        if segmentedContr.selectedSegmentIndex == 0{
            countResult = 40//на столько частей делится экран
            
        }else if segmentedContr.selectedSegmentIndex == 1{
            countResult = 80
        }else if segmentedContr.selectedSegmentIndex == 2{
            countResult = 240
        }else if segmentedContr.selectedSegmentIndex == 3{
            if state == "Miopia"{
                countResult = 40*(CGFloat(sortedMiopiaArray?.count ?? 5)/10)
            }else if state == "Hyperopia"{
                countResult = 40*(CGFloat(sortedHyperopiaArray?.count ?? 5)/10)
            }
        }
        
        if viewResArr.count>0{
            for i in 0 ... viewResArr.count-1{
                viewResArr[i].removeFromSuperview()
            }
        }
        
        for i in 0 ... labelArr.count-1{
            labelArr[i].removeFromSuperview()
        }
        leftTopView.removeFromSuperview()
        leftBottomView.removeFromSuperview()
        rightTopView.removeFromSuperview()
        rightBottomView.removeFromSuperview()
        
        viewResArr.removeAll()
        labelArr.removeAll()
        mainGrafView.removeFromSuperview()
        addMainGraf()
        addLabels()
        addHorisontalLine()
        addResViews(inputMiopArray: sortedMiopiaArray, inputHypArray: sortedHyperopiaArray)
        //viewAddTarget()
    }
    

    
    func addMainGraf() {
        self.view.addSubview(mainGrafView)
        mainGrafView.translatesAutoresizingMaskIntoConstraints = false
        mainGrafView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 9/10).isActive = true
        mainGrafView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 9/10).isActive = true
        mainGrafView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainGrafView.topAnchor.constraint(equalTo: segmentedContr.bottomAnchor).isActive = true
        
        mainGrafView.backgroundColor = .white
    }
    
    //создали массивlabel
    func createLabelArray(count: Int) -> [UILabel] {
        var labArr = [UILabel]()
        for i in 0 ... count{
            let label = UILabel()
            label.font = .systemFont(ofSize: 7)
            label.numberOfLines = 0
            label.text = "\((Float(i)/10))\n\n"
            labArr.append(label)
        }
        return labArr
    }
    
    //разместили массив label на экране
    func addLabels() {
        labelArr = createLabelArray(count: 10)
        
        for i in 0...labelArr.count-1{
            self.view.addSubview(labelArr[i])
            labelArr[i].translatesAutoresizingMaskIntoConstraints = false
            labelArr[i].widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/10).isActive = true
            labelArr[i].heightAnchor.constraint(equalTo: mainGrafView.heightAnchor, multiplier: 1/10).isActive = true
            labelArr[i].leftAnchor.constraint(equalTo: mainGrafView.rightAnchor).isActive = true
            if i == 0{
                labelArr[i].topAnchor.constraint(equalTo: mainGrafView.bottomAnchor).isActive = true
            }else{
                labelArr[i].bottomAnchor.constraint(equalTo: labelArr[i-1].topAnchor).isActive = true
            }
        }
    }
    
    //добавили горизонтальную разметку на экран
    func addHorisontalLine() {
//        var lineArr = [UIView]()
        for i in 0 ... 10 {
            let line = UIView()
            let emptyView = UIView()
            emptyView.backgroundColor = .clear
            line.backgroundColor = .lightGray
//            lineArr.append(line)
            mainGrafView.addSubview(line)
            mainGrafView.addSubview(emptyView)
            
            emptyView.translatesAutoresizingMaskIntoConstraints = false
            emptyView.widthAnchor.constraint(equalTo: mainGrafView.widthAnchor).isActive = true
            emptyView.leftAnchor.constraint(equalTo: mainGrafView.leftAnchor).isActive = true
            if i == 0 {
                emptyView.heightAnchor.constraint(equalToConstant: 0).isActive = true
            }else{
                emptyView.heightAnchor.constraint(equalTo: mainGrafView.heightAnchor, multiplier: CGFloat(Float(i)/10), constant: -0.5).isActive = true
            }
            emptyView.bottomAnchor.constraint(equalTo: mainGrafView.bottomAnchor).isActive = true
            
            line.translatesAutoresizingMaskIntoConstraints = false
            line.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
            line.leftAnchor.constraint(equalTo: mainGrafView.leftAnchor).isActive = true
            line.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
            line.bottomAnchor.constraint(equalTo: emptyView.topAnchor).isActive = true
            
        }
    }
    
    func addResViews(inputMiopArray: [MiopiaTestResult]?, inputHypArray:[HyperopiaTestResult]?) {
        
        if state == "Miopia"{
            if inputMiopArray?.count ?? 0>0{
                for i in 0...inputMiopArray!.count-1{
                    var height = inputMiopArray![i].result
                    
                    if height>1{
                        height=1
                    }else if height == 0{
                        height = 0.01
                    }
                    let view1 = UIButton()
                    view1.tag = i
                    
                    let emptyView = UIButton()
                    viewResArr.append(emptyView)
                    viewResArr.append(view1)
                    mainGrafView.addSubview(view1)
                    view1.translatesAutoresizingMaskIntoConstraints = false
                    view1.heightAnchor.constraint(equalTo: mainGrafView.heightAnchor, multiplier: CGFloat(height)).isActive = true
                    view1.widthAnchor.constraint(equalTo: mainGrafView.widthAnchor, multiplier: 3/countResult).isActive = true
                    view1.bottomAnchor.constraint(equalTo: mainGrafView.bottomAnchor).isActive = true
                    
                    if inputMiopArray![i].testingEye == "Правый глаз"{
                        if eyeSegmContr.selectedSegmentIndex == 1 || eyeSegmContr.selectedSegmentIndex == 2{
                            view1.backgroundColor = .green
                            view1.addTarget(self, action: #selector(viewAction(sender:)), for: .touchUpInside)
                        }else if eyeSegmContr.selectedSegmentIndex == 0{
                            view1.backgroundColor = .clear
                            
                        }
                        
                    }else{
                        if eyeSegmContr.selectedSegmentIndex == 0 || eyeSegmContr.selectedSegmentIndex == 2{
                            view1.backgroundColor = .blue
                            view1.addTarget(self, action: #selector(viewAction(sender:)), for: .touchUpInside)
                        }else if eyeSegmContr.selectedSegmentIndex == 2{
                            view1.backgroundColor = .clear
                        }
                    }
                    mainGrafView.addSubview(emptyView)
                    emptyView.translatesAutoresizingMaskIntoConstraints = false
                    emptyView.heightAnchor.constraint(equalTo: mainGrafView.heightAnchor, multiplier:0.001).isActive = true
                    emptyView.widthAnchor.constraint(equalTo: mainGrafView.widthAnchor, multiplier: CGFloat(i)*4/countResult).isActive = true
                    emptyView.backgroundColor = .clear
                    
                    if i == 0{
                        emptyView.leftAnchor.constraint(equalTo: mainGrafView.rightAnchor).isActive = true
                    }else{
                        emptyView.rightAnchor.constraint(equalTo: mainGrafView.rightAnchor).isActive = true
                    }
                    view1.rightAnchor.constraint(equalTo: emptyView.leftAnchor).isActive = true
                }
            }else{
                return
            }
            
        }else if state == "Hyperopia"{
            if inputHypArray?.count ?? 0>0{
                for i in 0...inputHypArray!.count-1{
                    var height = inputHypArray![i].result
                    if height>1{
                        height=1
                    }else if height == 0{
                        height = 0.01
                    }
                    let view1 = UIButton()
                    view1.tag = i
//                    view1.addTarget(self, action: #selector(viewAction(sender:)), for: .touchUpInside)
                    let emptyView = UIButton()
                    
                    
                    viewResArr.append(emptyView)
                    viewResArr.append(view1)
                    
                    
                    mainGrafView.addSubview(view1)
                    view1.translatesAutoresizingMaskIntoConstraints = false
                    view1.heightAnchor.constraint(equalTo: mainGrafView.heightAnchor, multiplier: CGFloat(height)).isActive = true
                    view1.widthAnchor.constraint(equalTo: mainGrafView.widthAnchor, multiplier: 3/countResult).isActive = true
                    view1.bottomAnchor.constraint(equalTo: mainGrafView.bottomAnchor).isActive = true
                    
                    
                    if inputHypArray![i].testingEye == "Правый глаз"{
                        if eyeSegmContr.selectedSegmentIndex == 1 || eyeSegmContr.selectedSegmentIndex == 2{
                            view1.backgroundColor = .green
                            view1.addTarget(self, action: #selector(viewAction(sender:)), for: .touchUpInside)
                        }else if eyeSegmContr.selectedSegmentIndex == 0{
                            view1.backgroundColor = .clear
                        }
                        
                    }else{
                        if eyeSegmContr.selectedSegmentIndex == 0 || eyeSegmContr.selectedSegmentIndex == 2{
                            view1.backgroundColor = .blue
                            view1.addTarget(self, action: #selector(viewAction(sender:)), for: .touchUpInside)
                        }else if eyeSegmContr.selectedSegmentIndex == 2{
                            view1.backgroundColor = .clear
                        }
                    }
                    mainGrafView.addSubview(emptyView)
                    emptyView.translatesAutoresizingMaskIntoConstraints = false
                    emptyView.heightAnchor.constraint(equalTo: mainGrafView.heightAnchor, multiplier:0.001).isActive = true
                    emptyView.widthAnchor.constraint(equalTo: mainGrafView.widthAnchor, multiplier: CGFloat(i)*4/countResult).isActive = true
                    emptyView.backgroundColor = .clear
                    
                    if i == 0{
                        emptyView.leftAnchor.constraint(equalTo: mainGrafView.rightAnchor).isActive = true
                    }else{
                        emptyView.rightAnchor.constraint(equalTo: mainGrafView.rightAnchor).isActive = true
                    }
                    view1.rightAnchor.constraint(equalTo: emptyView.leftAnchor).isActive = true
                    
                }
                
            }else{
                return
            }
        }
        
    }

    
    
    @objc func viewAction(sender: UIButton){
        
        leftTopView.removeFromSuperview()
        leftBottomView.removeFromSuperview()
        rightTopView.removeFromSuperview()
        rightBottomView.removeFromSuperview()
        
        describeLabel.numberOfLines = 0
        describeLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(describeLabelAction))
        describeLabel.addGestureRecognizer(tap)
        
        if state == "Hyperopia"{
            
            //let eye = sortedHyperopiaArray![sender.tag].testingEye ?? "Правый глаз"
            var eye:String = "Правый глаз"
            if sortedHyperopiaArray![sender.tag].testingEye == "Правый глаз"{
                eye  = text.eyeRight[locale] ?? "Правый глаз"
            }else{
                eye = text.eyeLeft[locale] ?? "Правый глаз"
            }
            
            
            let res = sortedHyperopiaArray![sender.tag].result
            let date = sortedHyperopiaArray![sender.tag].dateTest
            
            
            let resultDate = formatter.string(from: date ?? currentDate)
            
            let dateText:String = text.describeLabelЕext1[locale] ?? "\nДата:"
            let resultText:String = text.describeLabelЕext2[locale] ?? "\nРезультат:"
            
            describeLabel.text = "\(eye)" + dateText + "\(resultDate)" + resultText + "\(res)"
            
            //describeLabel.text = "\(eye)\nДата: \(resultDate) \nРезультат: \(res)"
            describeLabel.font = .systemFont(ofSize: 15)
        }
        
        if state == "Miopia"{
            
            var eye:String = "Правый глаз"
            if sortedMiopiaArray![sender.tag].testingEye == "Правый глаз"{
                eye  = text.eyeRight[locale] ?? "Правый глаз"
            }else{
                eye = text.eyeLeft[locale] ?? "Правый глаз"
            }
            
            let date = sortedMiopiaArray![sender.tag].dateTest
            //eye = sortedMiopiaArray![sender.tag].testingEye ?? "Правый глаз"
            let res = sortedMiopiaArray![sender.tag].result
            let dist = sortedMiopiaArray![sender.tag].distance
            
            let resultDate = formatter.string(from: date ?? currentDate)
            
            let dateText:String = text.describeLabelЕext1[locale] ?? "\nДата:"
            let resultText:String = text.describeLabelЕext2[locale] ?? "\nРезультат:"
            let distanceText:String = text.describeLabelЕext3[locale] ?? "\nРасстояние:"
            
            describeLabel.text = "\(eye)" + dateText + "\(resultDate)" + resultText + "\(res)" + distanceText + "\(dist)"
            
            //describeLabel.text = "\(eye)\nДата: \(resultDate) \nРезультат: \(res) \nРасстояние: \(dist)"
            describeLabel.font = .systemFont(ofSize: 15)
        }
        
        
        if sender.frame.origin.x <= mainGrafView.frame.width/2 && sender.frame.origin.y <= mainGrafView.frame.height/2{
            mainGrafView.addSubview(leftTopView)
            leftTopView.translatesAutoresizingMaskIntoConstraints = false
            leftTopView.leftAnchor.constraint(equalTo: sender.rightAnchor, constant: 0).isActive = true
            leftTopView.widthAnchor.constraint(equalTo: mainGrafView.widthAnchor, multiplier: 1/2).isActive = true
            leftTopView.heightAnchor.constraint(equalTo: mainGrafView.heightAnchor, multiplier: 1/3).isActive = true
            leftTopView.topAnchor.constraint(equalTo: sender.topAnchor).isActive = true
            
            leftTopView.backgroundColor = .clear
            leftTopView.ratio = 1/10
            leftTopView.fat = 10
            
            leftTopView.addSubview(describeLabel)
            describeLabel.translatesAutoresizingMaskIntoConstraints = false
            describeLabel.widthAnchor.constraint(equalTo: leftTopView.widthAnchor, multiplier: 9/10, constant: -2*leftTopView.radius).isActive = true
            describeLabel.heightAnchor.constraint(equalTo: leftTopView.heightAnchor, constant: -2*leftTopView.radius).isActive = true
            describeLabel.rightAnchor.constraint(equalTo: leftTopView.rightAnchor, constant: -leftTopView.radius).isActive = true
            describeLabel.topAnchor.constraint(equalTo: leftTopView.topAnchor, constant: leftTopView.radius).isActive = true
            
        }else if sender.frame.origin.x > mainGrafView.frame.width/2 && sender.frame.origin.y <= mainGrafView.frame.height/2{
            mainGrafView.addSubview(rightTopView)
            rightTopView.translatesAutoresizingMaskIntoConstraints = false
            rightTopView.rightAnchor.constraint(equalTo: sender.leftAnchor, constant: 0).isActive = true
            rightTopView.widthAnchor.constraint(equalTo: mainGrafView.widthAnchor, multiplier: 1/2).isActive = true
            rightTopView.heightAnchor.constraint(equalTo: mainGrafView.heightAnchor, multiplier: 1/3).isActive = true
            rightTopView.topAnchor.constraint(equalTo: sender.topAnchor).isActive = true
            
            rightTopView.backgroundColor = .clear
            rightTopView.ratio = 1/10
            rightTopView.fat = 10
            
            rightTopView.addSubview(describeLabel)
            describeLabel.translatesAutoresizingMaskIntoConstraints = false
            describeLabel.widthAnchor.constraint(equalTo: rightTopView.widthAnchor, multiplier: 9/10, constant: -2*rightTopView.radius).isActive = true
            describeLabel.heightAnchor.constraint(equalTo: rightTopView.heightAnchor, constant: -2*rightTopView.radius).isActive = true
            describeLabel.leftAnchor.constraint(equalTo: rightTopView.leftAnchor, constant: rightTopView.radius).isActive = true
            describeLabel.topAnchor.constraint(equalTo: rightTopView.topAnchor, constant: rightTopView.radius).isActive = true
            
            
        }else if sender.frame.origin.x > mainGrafView.frame.width/2 && sender.frame.origin.y > mainGrafView.frame.height/2{
            mainGrafView.addSubview(rightBottomView)
            rightBottomView.translatesAutoresizingMaskIntoConstraints = false
            rightBottomView.rightAnchor.constraint(equalTo: sender.leftAnchor, constant: 0).isActive = true
            rightBottomView.widthAnchor.constraint(equalTo: mainGrafView.widthAnchor, multiplier: 1/2).isActive = true
            rightBottomView.heightAnchor.constraint(equalTo: mainGrafView.heightAnchor, multiplier: 1/3).isActive = true
            rightBottomView.bottomAnchor.constraint(equalTo: sender.topAnchor).isActive = true
            
            rightBottomView.backgroundColor = .clear
            rightBottomView.ratio = 1/10
            rightBottomView.fat = 10
            
            rightBottomView.addSubview(describeLabel)
            describeLabel.translatesAutoresizingMaskIntoConstraints = false
            describeLabel.widthAnchor.constraint(equalTo: rightBottomView.widthAnchor, multiplier: 9/10, constant: -2*rightBottomView.radius).isActive = true
            describeLabel.heightAnchor.constraint(equalTo: rightBottomView.heightAnchor, constant: -2*rightBottomView.radius).isActive = true
            describeLabel.leftAnchor.constraint(equalTo: rightBottomView.leftAnchor, constant: rightBottomView.radius).isActive = true
            describeLabel.topAnchor.constraint(equalTo: rightBottomView.topAnchor, constant: rightBottomView.radius).isActive = true
            
            
        }else if sender.frame.origin.x <= mainGrafView.frame.width/2 && sender.frame.origin.y > mainGrafView.frame.height/2{
            mainGrafView.addSubview(leftBottomView)
            leftBottomView.translatesAutoresizingMaskIntoConstraints = false
            leftBottomView.leftAnchor.constraint(equalTo: sender.rightAnchor, constant: 0).isActive = true
            leftBottomView.widthAnchor.constraint(equalTo: mainGrafView.widthAnchor, multiplier: 1/2).isActive = true
            leftBottomView.heightAnchor.constraint(equalTo: mainGrafView.heightAnchor, multiplier: 1/3).isActive = true
            leftBottomView.bottomAnchor.constraint(equalTo: sender.topAnchor).isActive = true
            
            leftBottomView.backgroundColor = .clear
            leftBottomView.ratio = 1/10
            leftBottomView.fat = 10
            
            leftBottomView.addSubview(describeLabel)
            describeLabel.translatesAutoresizingMaskIntoConstraints = false
            describeLabel.widthAnchor.constraint(equalTo: leftBottomView.widthAnchor, multiplier: 9/10, constant: -2*leftBottomView.radius).isActive = true
            describeLabel.heightAnchor.constraint(equalTo: leftBottomView.heightAnchor, constant: -2*leftBottomView.radius).isActive = true
            describeLabel.rightAnchor.constraint(equalTo: leftBottomView.rightAnchor, constant: -leftBottomView.radius).isActive = true
            describeLabel.topAnchor.constraint(equalTo: leftBottomView.topAnchor, constant: leftBottomView.radius).isActive = true
        }

    }
    
    @objc func describeLabelAction(){
        leftTopView.removeFromSuperview()
        leftBottomView.removeFromSuperview()
        rightTopView.removeFromSuperview()
        rightBottomView.removeFromSuperview()
    }
    
}
