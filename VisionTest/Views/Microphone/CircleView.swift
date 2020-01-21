

import UIKit

class CircleView: UIView {

    override func draw(_ rect: CGRect) {
         let circle = UIBezierPath()
        
        circle.move(to: CGPoint(x: self.frame.width - self.frame.width*0.025, y: self.frame.height*0.5))
        circle.addArc(withCenter: CGPoint(x: self.frame.width*0.5, y: self.frame.width*0.5),
        radius: self.frame.width*0.5 - self.frame.width*0.025,
        startAngle: CGFloat(Float.pi*0),
        endAngle: CGFloat(Float.pi*2),
        clockwise: true)
        circle.lineWidth = self.frame.width*0.05
        UIColor.blue.setStroke()
        circle.stroke()

    }
    

}
