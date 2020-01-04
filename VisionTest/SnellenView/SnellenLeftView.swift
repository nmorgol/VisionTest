

import UIKit

class SnellenLeftView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        let blackRect = UIBezierPath()
        let leftTopRect = UIBezierPath()
        let leftBottomRect = UIBezierPath()
        
        blackRect.move(to: CGPoint(x: 0, y: 0))
        blackRect.addLine(to: CGPoint(x: 0, y: self.frame.height))
        blackRect.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        blackRect.addLine(to: CGPoint(x: self.frame.width, y: 0))
        blackRect.close()
        UIColor.black.setFill()
        blackRect.fill()
        
        leftTopRect.move(to: CGPoint(x: 0, y: self.frame.height*0.2))
        leftTopRect.addLine(to: CGPoint(x: 0, y: self.frame.height*0.4))
        leftTopRect.addLine(to: CGPoint(x: self.frame.width*0.8, y: self.frame.height*0.4))
        leftTopRect.addLine(to: CGPoint(x: self.frame.width*0.8, y: self.frame.height*0.2))
        leftTopRect.close()
        UIColor.white.setFill()
        leftTopRect.fill()
        
        leftBottomRect.move(to: CGPoint(x: 0, y: self.frame.height*0.6))
        leftBottomRect.addLine(to: CGPoint(x: 0, y: self.frame.height*0.8))
        leftBottomRect.addLine(to: CGPoint(x: self.frame.width*0.8, y: self.frame.height*0.8))
        leftBottomRect.addLine(to: CGPoint(x: self.frame.width*0.8, y: self.frame.height*0.6))
        leftBottomRect.close()
        UIColor.white.setFill()
        leftBottomRect.fill()
        
    }

}
