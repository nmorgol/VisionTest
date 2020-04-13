

import UIKit

class LastSphereView: UIView {

    override func draw(_ rect: CGRect) {
        
        let sphereYZ = UIBezierPath()//круг YZ
        

        //круг xy
        let sphereFrontXY = UIBezierPath()
        let sphereBackXY = UIBezierPath()
        //круг XZ
        let sphereFrontXZ = UIBezierPath()
        let sphereBackXZ = UIBezierPath()
        
        let line360degr = UIBezierPath()
        
        let lineZ = UIBezierPath()
        let lineY = UIBezierPath()
        let lineX = UIBezierPath()
        
        
        sphereYZ.move(to: CGPoint(x: self.frame.width*9/10, y: self.frame.height/2))
        sphereYZ.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2),
                        radius: self.frame.width*4/10,
                        startAngle: 0,
                        endAngle: CGFloat.pi*2,
                        clockwise: true)
        
        sphereYZ.lineWidth = 0.5
        UIColor.blue.setStroke()
        sphereYZ.stroke()
        UIColor.red.setFill()
        sphereYZ.fill()
     
        
        
        sphereFrontXY.move(to: CGPoint(x: self.frame.width*9/10, y: self.frame.height/2))
        sphereFrontXY.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2),
                        radius: self.frame.width*4/10,
                        startAngle: 0,
                        endAngle: CGFloat.pi,
                        clockwise: true)
        
        sphereFrontXY.apply(CGAffineTransform.init(scaleX: 1, y: 1/3))
        sphereFrontXY.apply(CGAffineTransform.init(translationX: 0, y: self.frame.height*4/12))
        
        sphereFrontXY.lineWidth = 1
        UIColor.blue.setStroke()
        sphereFrontXY.stroke()
        
        
        sphereBackXY.move(to: CGPoint(x: self.frame.width*1/10, y: self.frame.height/2))
        sphereBackXY.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2),
                        radius: self.frame.width*4/10,
                        startAngle: CGFloat.pi,
                        endAngle: CGFloat.pi*2,
                        clockwise: true)
        
        sphereBackXY.apply(CGAffineTransform.init(scaleX: 1, y: 1/3))
        sphereBackXY.apply(CGAffineTransform.init(translationX: 0, y: self.frame.height*4/12))
        
        sphereBackXY.lineWidth = 0.5
        let dashPattern: [CGFloat] = [10.0, 10.0]
        sphereBackXY.setLineDash(dashPattern, count: dashPattern.count, phase: 0)
        UIColor.blue.setStroke()
        sphereBackXY.stroke()
        
        
        sphereFrontXZ.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height*9/10))
        sphereFrontXZ.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2),
                        radius: self.frame.width*4/10,
                        startAngle: CGFloat.pi/2,
                        endAngle: CGFloat.pi*3/2,
                        clockwise: true)
        
        sphereFrontXZ.apply(CGAffineTransform.init(scaleX: 1/3, y: 1))
        sphereFrontXZ.apply(CGAffineTransform.init(translationX: self.frame.width*4/12, y: 0))
        
        sphereFrontXZ.lineWidth = 1
        UIColor.blue.setStroke()
        sphereFrontXZ.stroke()
        
        sphereBackXZ.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height*1/10))
        sphereBackXZ.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2),
                        radius: self.frame.width*4/10,
                        startAngle: CGFloat.pi*3/2,
                        endAngle: CGFloat.pi*1/2,
                        clockwise: true)
        
        sphereBackXZ.apply(CGAffineTransform.init(scaleX: 1/3, y: 1))
        sphereBackXZ.apply(CGAffineTransform.init(translationX: self.frame.width*4/12, y: 0))
        
        sphereBackXZ.lineWidth = 0.5
        sphereBackXZ.setLineDash(dashPattern, count: dashPattern.count, phase: 0)
        UIColor.blue.setStroke()
        sphereBackXZ.stroke()
        
        line360degr.move(to: CGPoint(x: self.frame.width/2 + sin(CGFloat.pi/20)*self.frame.width*45/100,
                                     y: self.frame.height*1/2 - cos(CGFloat.pi/20)*self.frame.width*45/100))
        line360degr.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2),
                           radius: self.frame.width*45/100,
                           startAngle: CGFloat.pi*3/2 + CGFloat.pi/20,
                           endAngle: CGFloat.pi*3/2 - CGFloat.pi/20,
                           clockwise: true)
        line360degr.addLine(to: CGPoint(x: self.frame.width/2 - sin(CGFloat.pi/20)*self.frame.width*45/100 - 8,
        y: self.frame.height*1/2 - cos(CGFloat.pi/20)*self.frame.width*45/100 + 4))
        line360degr.move(to: CGPoint(x: self.frame.width/2 - sin(CGFloat.pi/20)*self.frame.width*45/100,
        y: self.frame.height*1/2 - cos(CGFloat.pi/20)*self.frame.width*45/100))
        line360degr.addLine(to: CGPoint(x: self.frame.width/2 - sin(CGFloat.pi/20)*self.frame.width*45/100 - 9,
        y: self.frame.height*1/2 - cos(CGFloat.pi/20)*self.frame.width*45/100 - 1))
        
        UIColor.black.setStroke()
        line360degr.stroke()
        
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
        
        
        lineX.move(to: CGPoint(x: self.frame.width/2, y: self.frame.height/2))
        lineX.addLine(to: CGPoint(x: self.frame.width*3/10, y: self.frame.height*7/10))
        lineX.addLine(to: CGPoint(x: self.frame.width*3/10 + self.frame.width/80,
                                  y: self.frame.height*7/10 - self.frame.height/40))
        lineX.move(to: CGPoint(x: self.frame.width*3/10, y: self.frame.height*7/10))
        lineX.addLine(to: CGPoint(x: self.frame.width*3/10 + self.frame.width/40,
                                  y: self.frame.height*7/10 - self.frame.height/80))
        
        lineX.lineWidth = 1
        UIColor.black.setStroke()
        lineX.stroke()
        
    }
    

}

