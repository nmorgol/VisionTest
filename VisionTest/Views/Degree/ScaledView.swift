

import UIKit

class ScaledView: UIView {

    
    
    override func draw(_ rect: CGRect) {
        let line = UIBezierPath()
        let degreeLine = UIBezierPath()
        
        line.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height))
        line.addLine(to: CGPoint(x: 0, y: self.frame.height/2))
        line.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height),
                    radius: self.frame.width/cos(CGFloat.pi/4)/2,
                    startAngle: CGFloat.pi*5/4,
                    endAngle: CGFloat.pi*7/4,
                    clockwise: true)
        line.close()
        
        line.lineWidth = 0.5
        UIColor.black.setStroke()
        line.stroke()
         #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).setFill()
        line.fill()
        
        for i in 0...90{
            degreeLine.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height))
            let angle = CGFloat.pi/4 + CGFloat.pi/180*CGFloat(i)
            let radius = self.frame.width/cos(CGFloat.pi/4)/2
            degreeLine.addLine(to: CGPoint(x: self.frame.width/2 - radius*cos(angle) ,
                                           y: frame.height - radius*(sin(angle))))
        }
        degreeLine.lineWidth = 0.3
        UIColor.black.setStroke()
        degreeLine.stroke()
    }
    

}

