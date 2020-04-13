

import UIKit

class Rotate90DegrView: UIView {

    override func draw(_ rect: CGRect) {
        let lightBlueYZ = UIBezierPath() // выделеная область Y0Z
        
        
        lightBlueYZ.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/2))
        lightBlueYZ.addLine(to: CGPoint(x: self.frame.width/2 - self.frame.width*4/10*sin(CGFloat.pi/4),
                                        y: self.frame.height/2 - self.frame.height*4/10*sin(CGFloat.pi/4)))
        lightBlueYZ.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2),
                           radius: frame.height*4/10,
                           startAngle: CGFloat.pi*5/4,
                           endAngle: CGFloat.pi*7/4,
                           clockwise: true)
        lightBlueYZ.close()
        
        #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).setFill()
        lightBlueYZ.fill()
        
        lightBlueYZ.move(to: CGPoint(x: self.frame.width/2 - self.frame.width*4/10*sin(CGFloat.pi/4),
        y: self.frame.height/2 - self.frame.height*4/10*sin(CGFloat.pi/4)))
        lightBlueYZ.addLine(to: CGPoint(x: self.frame.width/2 - self.frame.width*4/10*sin(CGFloat.pi/4) + self.frame.width/30,
                                        y: self.frame.height/2 - self.frame.height*4/10*sin(CGFloat.pi/4) - self.frame.height/70))
        lightBlueYZ.move(to: CGPoint(x: self.frame.width/2 - self.frame.width*4/10*sin(CGFloat.pi/4),
        y: self.frame.height/2 - self.frame.height*4/10*sin(CGFloat.pi/4)))
        lightBlueYZ.addLine(to: CGPoint(x: self.frame.width/2 - self.frame.width*4/10*sin(CGFloat.pi/4) + self.frame.width/80,
                                        y: self.frame.height/2 - self.frame.height*4/10*sin(CGFloat.pi/4) - self.frame.height/30))

        
        lightBlueYZ.move(to: CGPoint(x: self.frame.width/2 + self.frame.width*4/10*sin(CGFloat.pi/4),
        y: self.frame.height/2 - self.frame.height*4/10*sin(CGFloat.pi/4)))
        lightBlueYZ.addLine(to: CGPoint(x: self.frame.width/2 + self.frame.width*4/10*sin(CGFloat.pi/4) - self.frame.width/30,
                                        y: self.frame.height/2 - self.frame.height*4/10*sin(CGFloat.pi/4) - self.frame.height/70))
        lightBlueYZ.move(to: CGPoint(x: self.frame.width/2 + self.frame.width*4/10*sin(CGFloat.pi/4),
        y: self.frame.height/2 - self.frame.height*4/10*sin(CGFloat.pi/4)))
        lightBlueYZ.addLine(to: CGPoint(x: self.frame.width/2 + self.frame.width*4/10*sin(CGFloat.pi/4) - self.frame.width/80,
                                        y: self.frame.height/2 - self.frame.height*4/10*sin(CGFloat.pi/4) - self.frame.height/30))

        
        
        
        lightBlueYZ.lineWidth = 2
        UIColor.black.setStroke()
        lightBlueYZ.stroke()
        
        
    }
    
}

