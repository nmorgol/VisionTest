

import UIKit

class _0DegrView: UIView {

    
    override func draw(_ rect: CGRect) {
        let lightBlueYZ = UIBezierPath() // выделеная область Y0Z
        
        let lineZ = UIBezierPath()
        let lineY = UIBezierPath()
        
        lightBlueYZ.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/10))
        lightBlueYZ.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2),
                       radius: self.frame.width*4/10,
                       startAngle: CGFloat.pi*3/2,
                       endAngle: CGFloat.pi*2,
                       clockwise: true)
        lightBlueYZ.addLine(to: CGPoint(x: self.frame.width/2, y: self.frame.height/2))
        lightBlueYZ.close()
        
        #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).setFill()
        lightBlueYZ.fill()
        lightBlueYZ.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/10))
        lightBlueYZ.addLine(to: CGPoint(x: self.frame.width/2 + self.frame.width/30,
                                        y: self.frame.height/10 - self.frame.height/70))
        lightBlueYZ.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/10))
        lightBlueYZ.addLine(to: CGPoint(x: self.frame.width/2 + self.frame.width/30,
                                        y: self.frame.height/10 + self.frame.height/80))
        lightBlueYZ.move(to: CGPoint(x: self.frame.width*9/10, y: self.frame.height/2))
        lightBlueYZ.addLine(to: CGPoint(x: self.frame.width*9/10 + self.frame.width/70,
                                        y: self.frame.height/2 - self.frame.height/30))
        lightBlueYZ.move(to: CGPoint(x: self.frame.width*9/10, y: self.frame.height/2))
        lightBlueYZ.addLine(to: CGPoint(x: self.frame.width*9/10 - self.frame.width/80,
                                        y: self.frame.height/2 - self.frame.height/30))
        
        
        lightBlueYZ.lineWidth = 2
        UIColor.black.setStroke()
        lightBlueYZ.stroke()
        
        
        
        
        lineZ.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/2))
        lineZ.addLine(to: CGPoint(x: self.frame.width/2, y: self.frame.height*5/100))
        lineZ.addLine(to: CGPoint(x: self.frame.width/2 - self.frame.width/80,
                                  y: self.frame.height*5/100 + self.frame.height/40))
        lineZ.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height*5/100))
        lineZ.addLine(to: CGPoint(x: self.frame.width/2 + self.frame.width/80,
        y: self.frame.height*5/100 + self.frame.height/40))
        
        lineZ.lineWidth = 1
        UIColor.black.setStroke()
        lineZ.stroke()
        
        
        lineY.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/2))
        lineY.addLine(to: CGPoint(x: self.frame.width*95/100, y: self.frame.height/2))
        lineY.addLine(to: CGPoint(x: self.frame.width*95/100 - self.frame.width/40,
                                  y: self.frame.height/2 - self.frame.height/80))
        lineY.move(to: CGPoint(x: self.frame.width*95/100, y: self.frame.height/2))
        lineY.addLine(to: CGPoint(x: self.frame.width*95/100 - self.frame.width/40,
        y: self.frame.height/2 + self.frame.height/80))
        
        lineY.lineWidth = 1
        UIColor.black.setStroke()
        lineY.stroke()
    }
    

}

