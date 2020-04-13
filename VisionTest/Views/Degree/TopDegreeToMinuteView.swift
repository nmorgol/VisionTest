

import UIKit

class TopDegreeToMinuteView: UIView {
    
    let oneDegree = UIBezierPath()
    
    override func draw(_ rect: CGRect) {
        //        let oneDegree = UIBezierPath()
        
        oneDegree.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height))
        oneDegree.addLine(to: CGPoint(x: self.frame.width*CGFloat(1/2 - tan(Float.pi/360)),
                                      y: 0))
        oneDegree.addLine(to: CGPoint(x: self.frame.width*CGFloat(1/2 + tan(Float.pi/360)),
                                      y: 0))
        oneDegree.close()
        
        for i in 0 ... 30{
            oneDegree.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height))
            oneDegree.addLine(to: CGPoint(x: self.frame.width*CGFloat(1/2 - tan(Float.pi*Float(i)/10800)),
                                          y: 0))
            oneDegree.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height))
            oneDegree.addLine(to: CGPoint(x: self.frame.width*CGFloat(1/2 + tan(Float.pi*Float(i)/10800)),
                                          y: 0))
        }
        
        
        
        oneDegree.apply(CGAffineTransform.init(scaleX: 32, y: 32))
        oneDegree.apply(CGAffineTransform.init(translationX: -self.frame.width*31/2, y: 0))
        //oneDegree.apply(CGAffineTransform.init(translationX: 0, y: -self.frame.height*15))
        
        
        
        
        #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).setFill()
        oneDegree.fill()
        
        oneDegree.lineWidth = 0.3
        UIColor.black.setStroke()
        oneDegree.stroke()
        
//        let layer = CAShapeLayer()
//        layer.path = oneDegree.cgPath
//        //layer.strokeEnd = 0
//        layer.lineWidth = 1
//
//        layer.fillColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
//        layer.strokeColor = UIColor.black.cgColor
//
//
//
//
//        let animation = CABasicAnimation(keyPath: "position")
//        animation.fromValue = [0, 0]
//        animation.toValue = [0, self.frame.height*15]
//
//        animation.duration = 5
//        animation.repeatCount = 1
//        animation.autoreverses = true
//
//
//        layer.add(animation, forKey: "position")
//
//        self.layer.addSublayer(layer)
        
    }
    
}
