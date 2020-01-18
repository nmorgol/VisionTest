

import UIKit

class LandoltBottomUIView: UIView {

    
    override func draw(_ rect: CGRect) {
        
        
        
         let whiteRect = UIBezierPath()
         let bigCircle =  UIBezierPath()
         let smallCircle = UIBezierPath()
         let bottomRect = UIBezierPath()
         
         whiteRect.move(to: CGPoint(x: 0, y: 0))
         whiteRect.addLine(to: CGPoint(x: 0, y: self.frame.height))
         whiteRect.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
         whiteRect.addLine(to: CGPoint(x: self.frame.width, y: 0))
         whiteRect.close()
         UIColor.white.setFill()
         whiteRect.fill()

         
         bigCircle.move(to: CGPoint(x: self.frame.width, y: self.frame.height/2))
         bigCircle.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2), radius: self.frame.width/2, startAngle: 0, endAngle: CGFloat(2*Float.pi), clockwise: true)
         bigCircle.close()
         UIColor.black.setFill()
         bigCircle.fill()
         
         smallCircle.move(to: CGPoint(x: (self.frame.width - self.frame.width/5), y: self.frame.height/2))
         smallCircle.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2), radius: self.frame.width*0.3, startAngle: 0, endAngle: CGFloat(2*Float.pi), clockwise: true)
         smallCircle.close()
         UIColor.white.setFill()
         smallCircle.fill()
         
         
        bottomRect.move(to: CGPoint(x: self.frame.width*0.4, y: self.frame.height))
        bottomRect.addLine(to: CGPoint(x: self.frame.width*0.6, y: self.frame.height))
         bottomRect.addLine(to: CGPoint(x: self.frame.width*0.6, y: self.frame.height/2))
         bottomRect.addLine(to: CGPoint(x: self.frame.width*0.4, y: self.frame.height/2))
         bottomRect.close()
         UIColor.white.setFill()
         bottomRect.fill()
    }
    

}
