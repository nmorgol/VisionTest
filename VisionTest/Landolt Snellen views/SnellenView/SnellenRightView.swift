

import UIKit

class SnellenRightView: UIView {

    override func draw(_ rect: CGRect) {
        
        let blackRect = UIBezierPath()
        let rightTopRect = UIBezierPath()
        let rightBottomRect = UIBezierPath()
        
        blackRect.move(to: CGPoint(x: 0, y: 0))
        blackRect.addLine(to: CGPoint(x: 0, y: self.frame.height))
        blackRect.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        blackRect.addLine(to: CGPoint(x: self.frame.width, y: 0))
        blackRect.close()
        UIColor.black.setFill()
        blackRect.fill()
        
        rightTopRect.move(to: CGPoint(x: self.frame.width, y: self.frame.height*0.2))
        rightTopRect.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height*0.4))
        rightTopRect.addLine(to: CGPoint(x: self.frame.width*0.2, y: self.frame.height*0.4))
        rightTopRect.addLine(to: CGPoint(x: self.frame.width*0.2, y: self.frame.height*0.2))
        rightTopRect.close()
        UIColor.white.setFill()
        rightTopRect.fill()
        
        rightBottomRect.move(to: CGPoint(x: self.frame.width, y: self.frame.height*0.6))
        rightBottomRect.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height*0.8))
        rightBottomRect.addLine(to: CGPoint(x: self.frame.width*0.2, y: self.frame.height*0.8))
        rightBottomRect.addLine(to: CGPoint(x: self.frame.width*0.2, y: self.frame.height*0.6))
        rightBottomRect.close()
        UIColor.white.setFill()
        rightBottomRect.fill()
        
    }

}
