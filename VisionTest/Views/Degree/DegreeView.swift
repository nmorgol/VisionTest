

import UIKit

class DegreeView: UIView {

    override func draw(_ rect: CGRect) {
        let oneDegree = UIBezierPath()
        
        oneDegree.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height))
        oneDegree.addLine(to: CGPoint(x: self.frame.width*CGFloat(1/2 - tan(Float.pi/360)),
                                      y: 0))
        oneDegree.addLine(to: CGPoint(x: self.frame.width*CGFloat(1/2 + tan(Float.pi/360)),
        y: 0))
        oneDegree.close()
        
        oneDegree.lineWidth = 0.3
        UIColor.black.setStroke()
        oneDegree.stroke()
        #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).setFill()
        oneDegree.fill()
    }
    

}

