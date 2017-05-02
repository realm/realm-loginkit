////////////////////////////////////////////////////////////////////////////
//
// Copyright 2017 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import UIKit

extension UIImage {
    public class func closeIcon() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 20, height: 20), false, 0.0)

        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!

        //// Color Declarations
        let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// LeftStroke Drawing
        context.saveGState()
        context.translateBy(x: 2.2, y: -0.6)
        context.rotate(by: 45 * CGFloat.pi/180)

        let leftStrokePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 26, height: 4), cornerRadius: 2)
        fillColor.setFill()
        leftStrokePath.fill()

        context.restoreGState()


        //// RightStroke Drawing
        context.saveGState()
        context.translateBy(x: 2.2, y: -0.6)
        context.rotate(by: -45 * CGFloat.pi/180)

        let rightStrokePath = UIBezierPath(roundedRect: CGRect(x: -15, y: 11, width: 26, height: 4), cornerRadius: 2)
        fillColor.setFill()
        rightStrokePath.fill()
        
        context.restoreGState()

        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image!.withRenderingMode(.alwaysTemplate)
    }

    public class func histroyIcon() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 20, height: 20), false, 0.0)

        //// Color Declarations
        let fillColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// ArrowBody Drawing
        let arrowBodyPath = UIBezierPath()
        arrowBodyPath.move(to: CGPoint(x: 1.75, y: 5.73))
        arrowBodyPath.addCurve(to: CGPoint(x: 4.54, y: 2.65), controlPoint1: CGPoint(x: 2.43, y: 4.51), controlPoint2: CGPoint(x: 3.38, y: 3.45))
        arrowBodyPath.addCurve(to: CGPoint(x: 9.83, y: 1), controlPoint1: CGPoint(x: 6.03, y: 1.61), controlPoint2: CGPoint(x: 7.86, y: 1))
        arrowBodyPath.addCurve(to: CGPoint(x: 19, y: 10), controlPoint1: CGPoint(x: 14.89, y: 1), controlPoint2: CGPoint(x: 19, y: 5.03))
        arrowBodyPath.addCurve(to: CGPoint(x: 9.83, y: 19), controlPoint1: CGPoint(x: 19, y: 14.97), controlPoint2: CGPoint(x: 14.89, y: 19))
        arrowBodyPath.addCurve(to: CGPoint(x: 1, y: 12.44), controlPoint1: CGPoint(x: 5.63, y: 19), controlPoint2: CGPoint(x: 2.08, y: 16.22))
        fillColor.setStroke()
        arrowBodyPath.lineWidth = 2
        arrowBodyPath.lineCapStyle = .round
        arrowBodyPath.stroke()


        //// ArrowCap Drawing
        let arrowCapPath = UIBezierPath()
        arrowCapPath.move(to: CGPoint(x: 5.11, y: 5.82))
        arrowCapPath.addLine(to: CGPoint(x: 1.7, y: 6.43))
        arrowCapPath.addLine(to: CGPoint(x: 1, y: 2.94))
        fillColor.setStroke()
        arrowCapPath.lineWidth = 2
        arrowCapPath.lineCapStyle = .round
        arrowCapPath.lineJoinStyle = .round
        arrowCapPath.stroke()


        //// ClockHands Drawing
        let clockHandsPath = UIBezierPath()
        clockHandsPath.move(to: CGPoint(x: 10, y: 5))
        clockHandsPath.addLine(to: CGPoint(x: 10, y: 10.36))
        clockHandsPath.addLine(to: CGPoint(x: 13.5, y: 13.69))
        fillColor.setStroke()
        clockHandsPath.lineWidth = 2
        clockHandsPath.lineCapStyle = .round
        clockHandsPath.lineJoinStyle = .round
        clockHandsPath.stroke()

        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image!.withRenderingMode(.alwaysTemplate)
    }

    public class func mailIcon() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 20, height: 15), false, 0.0)
        
        //// Color Declarations
        let color = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 1, y: 1, width: 18, height: 13), cornerRadius: 2)
        color.setStroke()
        rectanglePath.lineWidth = 2
        rectanglePath.stroke()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 2, y: 2))
        bezierPath.addLine(to: CGPoint(x: 10, y: 9))
        bezierPath.addLine(to: CGPoint(x: 18, y: 2))
        color.setStroke()
        bezierPath.lineWidth = 2
        bezierPath.stroke()

        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!.withRenderingMode(.alwaysTemplate)
    }
    
    public class func lockIcon() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 20, height: 20), false, 0.0)
        
        //// Color Declarations
        let color = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 3, y: 9, width: 14, height: 10), cornerRadius: 2)
        UIColor.black.setStroke()
        rectanglePath.lineWidth = 2
        rectanglePath.stroke()
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath()
        ovalPath.move(to: CGPoint(x: 5, y: 9))
        ovalPath.addCurve(to: CGPoint(x: 5, y: 5.29), controlPoint1: CGPoint(x: 5, y: 9), controlPoint2: CGPoint(x: 5, y: 7.65))
        ovalPath.addCurve(to: CGPoint(x: 10, y: 1), controlPoint1: CGPoint(x: 5, y: 2.92), controlPoint2: CGPoint(x: 7.24, y: 1))
        ovalPath.addCurve(to: CGPoint(x: 15, y: 5.29), controlPoint1: CGPoint(x: 12.76, y: 1), controlPoint2: CGPoint(x: 15, y: 2.92))
        ovalPath.addCurve(to: CGPoint(x: 15, y: 9), controlPoint1: CGPoint(x: 15, y: 7.65), controlPoint2: CGPoint(x: 15, y: 9))
        color.setStroke()
        ovalPath.lineWidth = 2
        ovalPath.lineJoinStyle = .round
        ovalPath.stroke()

        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!.withRenderingMode(.alwaysTemplate)
    }
    
    public class func tickIcon() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 20, height: 15), false, 0.0)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 2, y: 7.5))
        bezierPath.addLine(to: CGPoint(x: 7.71, y: 13))
        bezierPath.addLine(to: CGPoint(x: 18, y: 2))
        UIColor.black.setStroke()
        bezierPath.lineWidth = 3
        bezierPath.lineCapStyle = .round
        bezierPath.lineJoinStyle = .round
        bezierPath.stroke()

        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!.withRenderingMode(.alwaysTemplate)
    }
    
    public class func earthIcon() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 20, height: 20), false, 0.0)
        
        //// Color Declarations
        let color = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 11.02, y: 1.84))
        bezierPath.addCurve(to: CGPoint(x: 10.27, y: 2.22), controlPoint1: CGPoint(x: 10.79, y: 2.03), controlPoint2: CGPoint(x: 10.48, y: 2.13))
        bezierPath.addCurve(to: CGPoint(x: 11.31, y: 2.09), controlPoint1: CGPoint(x: 10.54, y: 2.22), controlPoint2: CGPoint(x: 11.18, y: 2.47))
        bezierPath.addCurve(to: CGPoint(x: 11.06, y: 2.05), controlPoint1: CGPoint(x: 11.22, y: 2.07), controlPoint2: CGPoint(x: 11.14, y: 2.07))
        bezierPath.addCurve(to: CGPoint(x: 11.37, y: 1.9), controlPoint1: CGPoint(x: 11.16, y: 1.99), controlPoint2: CGPoint(x: 11.27, y: 1.95))
        bezierPath.addCurve(to: CGPoint(x: 11.02, y: 1.84), controlPoint1: CGPoint(x: 11.25, y: 1.88), controlPoint2: CGPoint(x: 11.14, y: 1.86))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 9.58, y: 1.86))
        bezierPath.addCurve(to: CGPoint(x: 8.83, y: 1.99), controlPoint1: CGPoint(x: 9.35, y: 1.92), controlPoint2: CGPoint(x: 9.08, y: 1.94))
        bezierPath.addCurve(to: CGPoint(x: 8.48, y: 2.11), controlPoint1: CGPoint(x: 8.71, y: 2.02), controlPoint2: CGPoint(x: 8.59, y: 2.06))
        bezierPath.addCurve(to: CGPoint(x: 8.05, y: 2.26), controlPoint1: CGPoint(x: 8.34, y: 2.17), controlPoint2: CGPoint(x: 8.19, y: 2.4))
        bezierPath.addCurve(to: CGPoint(x: 8.05, y: 2.01), controlPoint1: CGPoint(x: 7.97, y: 2.2), controlPoint2: CGPoint(x: 7.99, y: 2.11))
        bezierPath.addCurve(to: CGPoint(x: 6.89, y: 2.38), controlPoint1: CGPoint(x: 7.65, y: 2.11), controlPoint2: CGPoint(x: 7.26, y: 2.24))
        bezierPath.addCurve(to: CGPoint(x: 7.32, y: 2.61), controlPoint1: CGPoint(x: 7.01, y: 2.57), controlPoint2: CGPoint(x: 7.11, y: 2.57))
        bezierPath.addCurve(to: CGPoint(x: 6.86, y: 2.84), controlPoint1: CGPoint(x: 7.32, y: 2.66), controlPoint2: CGPoint(x: 6.86, y: 2.84))
        bezierPath.addCurve(to: CGPoint(x: 6.14, y: 2.94), controlPoint1: CGPoint(x: 6.58, y: 2.82), controlPoint2: CGPoint(x: 6.35, y: 2.74))
        bezierPath.addCurve(to: CGPoint(x: 6.51, y: 3), controlPoint1: CGPoint(x: 6.24, y: 3.03), controlPoint2: CGPoint(x: 6.55, y: 3.27))
        bezierPath.addLine(to: CGPoint(x: 7.18, y: 3))
        bezierPath.addCurve(to: CGPoint(x: 7.63, y: 3.07), controlPoint1: CGPoint(x: 7.26, y: 3), controlPoint2: CGPoint(x: 7.55, y: 3.11))
        bezierPath.addCurve(to: CGPoint(x: 7.74, y: 2.84), controlPoint1: CGPoint(x: 7.68, y: 3.05), controlPoint2: CGPoint(x: 7.7, y: 2.88))
        bezierPath.addCurve(to: CGPoint(x: 7.55, y: 2.82), controlPoint1: CGPoint(x: 7.68, y: 2.84), controlPoint2: CGPoint(x: 7.61, y: 2.82))
        bezierPath.addCurve(to: CGPoint(x: 7.99, y: 2.84), controlPoint1: CGPoint(x: 7.58, y: 2.79), controlPoint2: CGPoint(x: 7.99, y: 2.84))
        bezierPath.addCurve(to: CGPoint(x: 8.15, y: 3.05), controlPoint1: CGPoint(x: 7.84, y: 2.98), controlPoint2: CGPoint(x: 7.95, y: 3.27))
        bezierPath.addCurve(to: CGPoint(x: 7.94, y: 2.61), controlPoint1: CGPoint(x: 8.17, y: 3.02), controlPoint2: CGPoint(x: 7.94, y: 2.61))
        bezierPath.addCurve(to: CGPoint(x: 8.42, y: 2.56), controlPoint1: CGPoint(x: 7.93, y: 2.55), controlPoint2: CGPoint(x: 8.42, y: 2.56))
        bezierPath.addCurve(to: CGPoint(x: 8.57, y: 2.46), controlPoint1: CGPoint(x: 8.46, y: 2.5), controlPoint2: CGPoint(x: 8.51, y: 2.47))
        bezierPath.addCurve(to: CGPoint(x: 8.78, y: 2.49), controlPoint1: CGPoint(x: 8.63, y: 2.45), controlPoint2: CGPoint(x: 8.7, y: 2.48))
        bezierPath.addCurve(to: CGPoint(x: 8.57, y: 2.42), controlPoint1: CGPoint(x: 8.71, y: 2.47), controlPoint2: CGPoint(x: 8.63, y: 2.42))
        bezierPath.addCurve(to: CGPoint(x: 8.84, y: 2.03), controlPoint1: CGPoint(x: 8.71, y: 2.17), controlPoint2: CGPoint(x: 8.61, y: 2.11))
        bezierPath.addCurve(to: CGPoint(x: 9.58, y: 1.86), controlPoint1: CGPoint(x: 9.02, y: 1.97), controlPoint2: CGPoint(x: 9.52, y: 2.03))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 9.59, y: 3.3))
        bezierPath.addCurve(to: CGPoint(x: 9.15, y: 3.34), controlPoint1: CGPoint(x: 9.42, y: 3.3), controlPoint2: CGPoint(x: 9.21, y: 3.27))
        bezierPath.addCurve(to: CGPoint(x: 9.05, y: 3.61), controlPoint1: CGPoint(x: 9.11, y: 3.38), controlPoint2: CGPoint(x: 9.11, y: 3.54))
        bezierPath.addCurve(to: CGPoint(x: 8.67, y: 3.81), controlPoint1: CGPoint(x: 8.94, y: 3.71), controlPoint2: CGPoint(x: 8.8, y: 3.73))
        bezierPath.addCurve(to: CGPoint(x: 8.24, y: 4.21), controlPoint1: CGPoint(x: 8.57, y: 3.88), controlPoint2: CGPoint(x: 8.3, y: 4.08))
        bezierPath.addCurve(to: CGPoint(x: 9.11, y: 4.98), controlPoint1: CGPoint(x: 7.97, y: 4.69), controlPoint2: CGPoint(x: 8.8, y: 4.83))
        bezierPath.addCurve(to: CGPoint(x: 9.73, y: 5.23), controlPoint1: CGPoint(x: 9.23, y: 5.04), controlPoint2: CGPoint(x: 9.65, y: 5.12))
        bezierPath.addCurve(to: CGPoint(x: 9.85, y: 5.6), controlPoint1: CGPoint(x: 9.83, y: 5.37), controlPoint2: CGPoint(x: 9.65, y: 5.5))
        bezierPath.addCurve(to: CGPoint(x: 10.12, y: 5.58), controlPoint1: CGPoint(x: 9.92, y: 5.64), controlPoint2: CGPoint(x: 10.06, y: 5.64))
        bezierPath.addCurve(to: CGPoint(x: 10.06, y: 5.33), controlPoint1: CGPoint(x: 10.23, y: 5.47), controlPoint2: CGPoint(x: 10.08, y: 5.45))
        bezierPath.addCurve(to: CGPoint(x: 10.21, y: 5.1), controlPoint1: CGPoint(x: 10.02, y: 5.1), controlPoint2: CGPoint(x: 10.08, y: 5.18))
        bezierPath.addCurve(to: CGPoint(x: 10.31, y: 4.62), controlPoint1: CGPoint(x: 10.46, y: 4.91), controlPoint2: CGPoint(x: 10.39, y: 4.91))
        bezierPath.addCurve(to: CGPoint(x: 10.25, y: 4.02), controlPoint1: CGPoint(x: 10.27, y: 4.5), controlPoint2: CGPoint(x: 10.1, y: 4.13))
        bezierPath.addCurve(to: CGPoint(x: 10.93, y: 4.11), controlPoint1: CGPoint(x: 10.42, y: 3.9), controlPoint2: CGPoint(x: 10.79, y: 4.08))
        bezierPath.addCurve(to: CGPoint(x: 11.27, y: 4.44), controlPoint1: CGPoint(x: 11.08, y: 4.13), controlPoint2: CGPoint(x: 11.18, y: 4.35))
        bezierPath.addCurve(to: CGPoint(x: 11.54, y: 4.6), controlPoint1: CGPoint(x: 11.33, y: 4.5), controlPoint2: CGPoint(x: 11.43, y: 4.62))
        bezierPath.addCurve(to: CGPoint(x: 11.72, y: 4.37), controlPoint1: CGPoint(x: 11.7, y: 4.58), controlPoint2: CGPoint(x: 11.64, y: 4.44))
        bezierPath.addCurve(to: CGPoint(x: 12.14, y: 4.67), controlPoint1: CGPoint(x: 11.97, y: 4.19), controlPoint2: CGPoint(x: 12.03, y: 4.44))
        bezierPath.addCurve(to: CGPoint(x: 12.49, y: 5.1), controlPoint1: CGPoint(x: 12.24, y: 4.87), controlPoint2: CGPoint(x: 12.32, y: 4.96))
        bezierPath.addCurve(to: CGPoint(x: 12.86, y: 5.54), controlPoint1: CGPoint(x: 12.55, y: 5.16), controlPoint2: CGPoint(x: 12.91, y: 5.39))
        bezierPath.addCurve(to: CGPoint(x: 12.38, y: 5.79), controlPoint1: CGPoint(x: 12.84, y: 5.57), controlPoint2: CGPoint(x: 12.38, y: 5.79))
        bezierPath.addCurve(to: CGPoint(x: 11.19, y: 6.17), controlPoint1: CGPoint(x: 12.35, y: 5.81), controlPoint2: CGPoint(x: 11.19, y: 6.17))
        bezierPath.addCurve(to: CGPoint(x: 11.87, y: 5.97), controlPoint1: CGPoint(x: 11.33, y: 6.16), controlPoint2: CGPoint(x: 11.74, y: 5.81))
        bezierPath.addCurve(to: CGPoint(x: 11.85, y: 6.22), controlPoint1: CGPoint(x: 11.93, y: 6.04), controlPoint2: CGPoint(x: 11.83, y: 6.14))
        bezierPath.addCurve(to: CGPoint(x: 12.22, y: 6.34), controlPoint1: CGPoint(x: 12.01, y: 6.39), controlPoint2: CGPoint(x: 12.12, y: 6.36))
        bezierPath.addCurve(to: CGPoint(x: 12.55, y: 6.06), controlPoint1: CGPoint(x: 12.47, y: 6.23), controlPoint2: CGPoint(x: 12.46, y: 6.25))
        bezierPath.addCurve(to: CGPoint(x: 12.7, y: 5.79), controlPoint1: CGPoint(x: 12.59, y: 5.99), controlPoint2: CGPoint(x: 12.66, y: 5.83))
        bezierPath.addCurve(to: CGPoint(x: 13.01, y: 5.87), controlPoint1: CGPoint(x: 12.89, y: 5.64), controlPoint2: CGPoint(x: 12.91, y: 5.74))
        bezierPath.addCurve(to: CGPoint(x: 13.22, y: 6.26), controlPoint1: CGPoint(x: 13.05, y: 5.89), controlPoint2: CGPoint(x: 13.32, y: 6.28))
        bezierPath.addCurve(to: CGPoint(x: 12.35, y: 6.39), controlPoint1: CGPoint(x: 12.91, y: 6.2), controlPoint2: CGPoint(x: 12.59, y: 6.22))
        bezierPath.addCurve(to: CGPoint(x: 11.87, y: 6.68), controlPoint1: CGPoint(x: 12.18, y: 6.47), controlPoint2: CGPoint(x: 12.03, y: 6.62))
        bezierPath.addCurve(to: CGPoint(x: 11.56, y: 6.68), controlPoint1: CGPoint(x: 11.83, y: 6.7), controlPoint2: CGPoint(x: 11.52, y: 6.74))
        bezierPath.addCurve(to: CGPoint(x: 11.87, y: 6.47), controlPoint1: CGPoint(x: 11.6, y: 6.62), controlPoint2: CGPoint(x: 11.79, y: 6.55))
        bezierPath.addCurve(to: CGPoint(x: 11.48, y: 6.57), controlPoint1: CGPoint(x: 11.72, y: 6.41), controlPoint2: CGPoint(x: 11.6, y: 6.49))
        bezierPath.addCurve(to: CGPoint(x: 10.98, y: 7.03), controlPoint1: CGPoint(x: 11.16, y: 6.74), controlPoint2: CGPoint(x: 11.12, y: 6.91))
        bezierPath.addCurve(to: CGPoint(x: 10.73, y: 7.18), controlPoint1: CGPoint(x: 10.91, y: 7.09), controlPoint2: CGPoint(x: 10.79, y: 7.09))
        bezierPath.addCurve(to: CGPoint(x: 10.6, y: 7.45), controlPoint1: CGPoint(x: 10.66, y: 7.26), controlPoint2: CGPoint(x: 10.66, y: 7.38))
        bezierPath.addCurve(to: CGPoint(x: 10.42, y: 7.53), controlPoint1: CGPoint(x: 10.56, y: 7.49), controlPoint2: CGPoint(x: 10.46, y: 7.45))
        bezierPath.addCurve(to: CGPoint(x: 10.44, y: 7.78), controlPoint1: CGPoint(x: 10.35, y: 7.61), controlPoint2: CGPoint(x: 10.46, y: 7.72))
        bezierPath.addCurve(to: CGPoint(x: 10.11, y: 8.07), controlPoint1: CGPoint(x: 10.4, y: 7.89), controlPoint2: CGPoint(x: 10.21, y: 7.99))
        bezierPath.addCurve(to: CGPoint(x: 9.83, y: 8.34), controlPoint1: CGPoint(x: 9.98, y: 8.18), controlPoint2: CGPoint(x: 9.89, y: 8.25))
        bezierPath.addCurve(to: CGPoint(x: 9.94, y: 8.96), controlPoint1: CGPoint(x: 9.85, y: 8.51), controlPoint2: CGPoint(x: 9.96, y: 8.88))
        bezierPath.addCurve(to: CGPoint(x: 9.58, y: 8.69), controlPoint1: CGPoint(x: 9.85, y: 9.25), controlPoint2: CGPoint(x: 9.67, y: 8.8))
        bezierPath.addCurve(to: CGPoint(x: 8.44, y: 8.59), controlPoint1: CGPoint(x: 9.32, y: 8.3), controlPoint2: CGPoint(x: 8.8, y: 8.55))
        bezierPath.addCurve(to: CGPoint(x: 7.82, y: 9.69), controlPoint1: CGPoint(x: 7.99, y: 8.63), controlPoint2: CGPoint(x: 7.55, y: 9.21))
        bezierPath.addCurve(to: CGPoint(x: 8.44, y: 9.96), controlPoint1: CGPoint(x: 7.97, y: 9.92), controlPoint2: CGPoint(x: 8.19, y: 10))
        bezierPath.addCurve(to: CGPoint(x: 8.96, y: 9.58), controlPoint1: CGPoint(x: 8.67, y: 9.92), controlPoint2: CGPoint(x: 8.73, y: 9.58))
        bezierPath.addCurve(to: CGPoint(x: 8.94, y: 10.12), controlPoint1: CGPoint(x: 9.38, y: 9.58), controlPoint2: CGPoint(x: 8.98, y: 9.98))
        bezierPath.addCurve(to: CGPoint(x: 9.13, y: 10.31), controlPoint1: CGPoint(x: 8.9, y: 10.27), controlPoint2: CGPoint(x: 8.98, y: 10.27))
        bezierPath.addCurve(to: CGPoint(x: 9.46, y: 10.33), controlPoint1: CGPoint(x: 9.23, y: 10.33), controlPoint2: CGPoint(x: 9.38, y: 10.27))
        bezierPath.addCurve(to: CGPoint(x: 9.58, y: 10.52), controlPoint1: CGPoint(x: 9.5, y: 10.37), controlPoint2: CGPoint(x: 9.5, y: 10.58))
        bezierPath.addCurve(to: CGPoint(x: 9.63, y: 11.06), controlPoint1: CGPoint(x: 9.44, y: 10.64), controlPoint2: CGPoint(x: 9.46, y: 10.95))
        bezierPath.addCurve(to: CGPoint(x: 10.01, y: 11.11), controlPoint1: CGPoint(x: 9.74, y: 11.14), controlPoint2: CGPoint(x: 9.88, y: 11.12))
        bezierPath.addCurve(to: CGPoint(x: 10.66, y: 10.91), controlPoint1: CGPoint(x: 10.52, y: 11.2), controlPoint2: CGPoint(x: 10.35, y: 11.1))
        bezierPath.addCurve(to: CGPoint(x: 11.04, y: 10.93), controlPoint1: CGPoint(x: 10.87, y: 10.79), controlPoint2: CGPoint(x: 10.89, y: 10.93))
        bezierPath.addCurve(to: CGPoint(x: 11.35, y: 10.83), controlPoint1: CGPoint(x: 11.12, y: 10.93), controlPoint2: CGPoint(x: 11.18, y: 10.79))
        bezierPath.addCurve(to: CGPoint(x: 11.68, y: 10.98), controlPoint1: CGPoint(x: 11.47, y: 10.85), controlPoint2: CGPoint(x: 11.54, y: 10.95))
        bezierPath.addCurve(to: CGPoint(x: 11.87, y: 10.95), controlPoint1: CGPoint(x: 11.74, y: 10.98), controlPoint2: CGPoint(x: 11.81, y: 10.95))
        bezierPath.addCurve(to: CGPoint(x: 12.59, y: 11.33), controlPoint1: CGPoint(x: 12.16, y: 10.98), controlPoint2: CGPoint(x: 12.37, y: 11.16))
        bezierPath.addCurve(to: CGPoint(x: 13.11, y: 11.49), controlPoint1: CGPoint(x: 12.78, y: 11.45), controlPoint2: CGPoint(x: 12.91, y: 11.43))
        bezierPath.addCurve(to: CGPoint(x: 13.55, y: 11.97), controlPoint1: CGPoint(x: 13.28, y: 11.54), controlPoint2: CGPoint(x: 13.57, y: 11.76))
        bezierPath.addCurve(to: CGPoint(x: 13.38, y: 12.26), controlPoint1: CGPoint(x: 13.55, y: 11.99), controlPoint2: CGPoint(x: 13.4, y: 12.18))
        bezierPath.addCurve(to: CGPoint(x: 13.8, y: 12.22), controlPoint1: CGPoint(x: 13.65, y: 12.24), controlPoint2: CGPoint(x: 13.75, y: 12.22))
        bezierPath.addCurve(to: CGPoint(x: 13.58, y: 12.34), controlPoint1: CGPoint(x: 13.76, y: 12.26), controlPoint2: CGPoint(x: 13.61, y: 12.38))
        bezierPath.addCurve(to: CGPoint(x: 13.74, y: 12.47), controlPoint1: CGPoint(x: 13.6, y: 12.39), controlPoint2: CGPoint(x: 13.7, y: 12.45))
        bezierPath.addCurve(to: CGPoint(x: 14.19, y: 12.43), controlPoint1: CGPoint(x: 13.93, y: 12.25), controlPoint2: CGPoint(x: 14.05, y: 12.37))
        bezierPath.addCurve(to: CGPoint(x: 14.75, y: 12.55), controlPoint1: CGPoint(x: 14.36, y: 12.51), controlPoint2: CGPoint(x: 14.57, y: 12.51))
        bezierPath.addCurve(to: CGPoint(x: 15.36, y: 12.82), controlPoint1: CGPoint(x: 14.9, y: 12.59), controlPoint2: CGPoint(x: 15.25, y: 12.7))
        bezierPath.addCurve(to: CGPoint(x: 15.29, y: 13.36), controlPoint1: CGPoint(x: 15.5, y: 12.97), controlPoint2: CGPoint(x: 15.4, y: 13.22))
        bezierPath.addCurve(to: CGPoint(x: 14.88, y: 13.86), controlPoint1: CGPoint(x: 15.15, y: 13.55), controlPoint2: CGPoint(x: 14.96, y: 13.63))
        bezierPath.addCurve(to: CGPoint(x: 14.82, y: 14.42), controlPoint1: CGPoint(x: 14.79, y: 14.03), controlPoint2: CGPoint(x: 14.86, y: 14.21))
        bezierPath.addCurve(to: CGPoint(x: 14.55, y: 14.77), controlPoint1: CGPoint(x: 14.75, y: 14.71), controlPoint2: CGPoint(x: 14.73, y: 14.61))
        bezierPath.addCurve(to: CGPoint(x: 14.34, y: 14.98), controlPoint1: CGPoint(x: 14.4, y: 14.92), controlPoint2: CGPoint(x: 14.55, y: 14.9))
        bezierPath.addCurve(to: CGPoint(x: 13.85, y: 15.23), controlPoint1: CGPoint(x: 14.14, y: 15.08), controlPoint2: CGPoint(x: 13.98, y: 15.05))
        bezierPath.addCurve(to: CGPoint(x: 13.72, y: 15.54), controlPoint1: CGPoint(x: 13.77, y: 15.36), controlPoint2: CGPoint(x: 13.73, y: 15.49))
        bezierPath.addCurve(to: CGPoint(x: 13.45, y: 15.89), controlPoint1: CGPoint(x: 13.65, y: 15.69), controlPoint2: CGPoint(x: 13.55, y: 15.77))
        bezierPath.addCurve(to: CGPoint(x: 12.99, y: 16.43), controlPoint1: CGPoint(x: 13.4, y: 15.94), controlPoint2: CGPoint(x: 13.01, y: 16.48))
        bezierPath.addCurve(to: CGPoint(x: 12.72, y: 16.44), controlPoint1: CGPoint(x: 12.97, y: 16.39), controlPoint2: CGPoint(x: 12.82, y: 16.44))
        bezierPath.addCurve(to: CGPoint(x: 12.72, y: 16.5), controlPoint1: CGPoint(x: 12.66, y: 16.48), controlPoint2: CGPoint(x: 12.64, y: 16.46))
        bezierPath.addCurve(to: CGPoint(x: 12.03, y: 17.02), controlPoint1: CGPoint(x: 12.66, y: 16.95), controlPoint2: CGPoint(x: 12.47, y: 17.02))
        bezierPath.addCurve(to: CGPoint(x: 11.79, y: 17.31), controlPoint1: CGPoint(x: 12.08, y: 17.24), controlPoint2: CGPoint(x: 11.87, y: 17.2))
        bezierPath.addCurve(to: CGPoint(x: 11.66, y: 17.64), controlPoint1: CGPoint(x: 11.72, y: 17.37), controlPoint2: CGPoint(x: 11.7, y: 17.56))
        bezierPath.addCurve(to: CGPoint(x: 11.47, y: 17.95), controlPoint1: CGPoint(x: 11.64, y: 17.68), controlPoint2: CGPoint(x: 11.47, y: 17.91))
        bezierPath.addCurve(to: CGPoint(x: 11.56, y: 18.07), controlPoint1: CGPoint(x: 11.47, y: 17.97), controlPoint2: CGPoint(x: 11.52, y: 18.03))
        bezierPath.addCurve(to: CGPoint(x: 18.07, y: 12.12), controlPoint1: CGPoint(x: 14.67, y: 17.47), controlPoint2: CGPoint(x: 17.16, y: 15.11))
        bezierPath.addCurve(to: CGPoint(x: 17.72, y: 11.89), controlPoint1: CGPoint(x: 17.95, y: 12.08), controlPoint2: CGPoint(x: 17.83, y: 11.99))
        bezierPath.addCurve(to: CGPoint(x: 17.24, y: 11.39), controlPoint1: CGPoint(x: 17.56, y: 11.76), controlPoint2: CGPoint(x: 17.37, y: 11.58))
        bezierPath.addCurve(to: CGPoint(x: 17.2, y: 10.77), controlPoint1: CGPoint(x: 17.12, y: 11.18), controlPoint2: CGPoint(x: 17.2, y: 11))
        bezierPath.addCurve(to: CGPoint(x: 17.2, y: 10.15), controlPoint1: CGPoint(x: 17.22, y: 10.58), controlPoint2: CGPoint(x: 17.12, y: 10.31))
        bezierPath.addCurve(to: CGPoint(x: 17.35, y: 9.98), controlPoint1: CGPoint(x: 17.22, y: 10.06), controlPoint2: CGPoint(x: 17.31, y: 10.04))
        bezierPath.addCurve(to: CGPoint(x: 17.49, y: 9.65), controlPoint1: CGPoint(x: 17.41, y: 9.85), controlPoint2: CGPoint(x: 17.41, y: 9.77))
        bezierPath.addCurve(to: CGPoint(x: 17.83, y: 9.4), controlPoint1: CGPoint(x: 17.6, y: 9.52), controlPoint2: CGPoint(x: 17.72, y: 9.5))
        bezierPath.addCurve(to: CGPoint(x: 18.01, y: 9.09), controlPoint1: CGPoint(x: 17.95, y: 9.29), controlPoint2: CGPoint(x: 17.95, y: 9.21))
        bezierPath.addCurve(to: CGPoint(x: 18.24, y: 8.82), controlPoint1: CGPoint(x: 18.05, y: 9), controlPoint2: CGPoint(x: 18.16, y: 8.9))
        bezierPath.addLine(to: CGPoint(x: 18.18, y: 8.44))
        bezierPath.addCurve(to: CGPoint(x: 18.05, y: 8.46), controlPoint1: CGPoint(x: 18.14, y: 8.46), controlPoint2: CGPoint(x: 18.07, y: 8.46))
        bezierPath.addCurve(to: CGPoint(x: 17.83, y: 8.34), controlPoint1: CGPoint(x: 17.97, y: 8.46), controlPoint2: CGPoint(x: 17.89, y: 8.4))
        bezierPath.addCurve(to: CGPoint(x: 17.62, y: 8.11), controlPoint1: CGPoint(x: 17.74, y: 8.28), controlPoint2: CGPoint(x: 17.66, y: 8.19))
        bezierPath.addCurve(to: CGPoint(x: 17.6, y: 7.84), controlPoint1: CGPoint(x: 17.56, y: 8.03), controlPoint2: CGPoint(x: 17.6, y: 7.95))
        bezierPath.addCurve(to: CGPoint(x: 17.6, y: 7.57), controlPoint1: CGPoint(x: 17.6, y: 7.76), controlPoint2: CGPoint(x: 17.56, y: 7.65))
        bezierPath.addLine(to: CGPoint(x: 17.66, y: 7.51))
        bezierPath.addCurve(to: CGPoint(x: 17.72, y: 7.36), controlPoint1: CGPoint(x: 17.68, y: 7.45), controlPoint2: CGPoint(x: 17.68, y: 7.41))
        bezierPath.addCurve(to: CGPoint(x: 17.83, y: 7.28), controlPoint1: CGPoint(x: 17.74, y: 7.32), controlPoint2: CGPoint(x: 17.78, y: 7.3))
        bezierPath.addCurve(to: CGPoint(x: 15.94, y: 4.29), controlPoint1: CGPoint(x: 17.41, y: 6.14), controlPoint2: CGPoint(x: 16.77, y: 5.12))
        bezierPath.addCurve(to: CGPoint(x: 15.25, y: 4.48), controlPoint1: CGPoint(x: 15.69, y: 4.29), controlPoint2: CGPoint(x: 15.48, y: 4.31))
        bezierPath.addCurve(to: CGPoint(x: 14.94, y: 4.69), controlPoint1: CGPoint(x: 15.15, y: 4.56), controlPoint2: CGPoint(x: 15.06, y: 4.64))
        bezierPath.addCurve(to: CGPoint(x: 14.57, y: 4.73), controlPoint1: CGPoint(x: 14.82, y: 4.71), controlPoint2: CGPoint(x: 14.69, y: 4.69))
        bezierPath.addCurve(to: CGPoint(x: 13.65, y: 5.64), controlPoint1: CGPoint(x: 14.15, y: 4.87), controlPoint2: CGPoint(x: 14.21, y: 5.79))
        bezierPath.addCurve(to: CGPoint(x: 13.07, y: 5.06), controlPoint1: CGPoint(x: 13.38, y: 5.58), controlPoint2: CGPoint(x: 13.2, y: 5.27))
        bezierPath.addCurve(to: CGPoint(x: 12.89, y: 4.5), controlPoint1: CGPoint(x: 12.95, y: 4.87), controlPoint2: CGPoint(x: 12.74, y: 4.73))
        bezierPath.addCurve(to: CGPoint(x: 12.68, y: 4.5), controlPoint1: CGPoint(x: 12.8, y: 4.5), controlPoint2: CGPoint(x: 12.74, y: 4.48))
        bezierPath.addCurve(to: CGPoint(x: 13.11, y: 4.21), controlPoint1: CGPoint(x: 12.93, y: 4.29), controlPoint2: CGPoint(x: 13.09, y: 4.28))
        bezierPath.addCurve(to: CGPoint(x: 12.67, y: 3.91), controlPoint1: CGPoint(x: 13.13, y: 4.17), controlPoint2: CGPoint(x: 12.67, y: 3.91))
        bezierPath.addCurve(to: CGPoint(x: 13.03, y: 3.92), controlPoint1: CGPoint(x: 12.78, y: 3.73), controlPoint2: CGPoint(x: 12.86, y: 3.96))
        bezierPath.addCurve(to: CGPoint(x: 12.86, y: 3.65), controlPoint1: CGPoint(x: 13.2, y: 3.88), controlPoint2: CGPoint(x: 12.95, y: 3.67))
        bezierPath.addCurve(to: CGPoint(x: 12.62, y: 3.52), controlPoint1: CGPoint(x: 12.84, y: 3.65), controlPoint2: CGPoint(x: 12.3, y: 3.79))
        bezierPath.addLine(to: CGPoint(x: 11.47, y: 2.8))
        bezierPath.addCurve(to: CGPoint(x: 12.18, y: 3.32), controlPoint1: CGPoint(x: 11.41, y: 3.07), controlPoint2: CGPoint(x: 11.99, y: 3.21))
        bezierPath.addCurve(to: CGPoint(x: 11.85, y: 3.54), controlPoint1: CGPoint(x: 12.16, y: 3.42), controlPoint2: CGPoint(x: 11.97, y: 3.59))
        bezierPath.addCurve(to: CGPoint(x: 11.58, y: 3.32), controlPoint1: CGPoint(x: 11.72, y: 3.5), controlPoint2: CGPoint(x: 11.76, y: 3.3))
        bezierPath.addCurve(to: CGPoint(x: 11.81, y: 3.62), controlPoint1: CGPoint(x: 11.49, y: 3.54), controlPoint2: CGPoint(x: 11.68, y: 3.56))
        bezierPath.addCurve(to: CGPoint(x: 11.66, y: 3.86), controlPoint1: CGPoint(x: 11.95, y: 3.96), controlPoint2: CGPoint(x: 11.74, y: 3.86))
        bezierPath.addCurve(to: CGPoint(x: 11.49, y: 3.81), controlPoint1: CGPoint(x: 11.64, y: 3.86), controlPoint2: CGPoint(x: 11.49, y: 3.69))
        bezierPath.addCurve(to: CGPoint(x: 11.63, y: 3.94), controlPoint1: CGPoint(x: 11.48, y: 3.9), controlPoint2: CGPoint(x: 11.56, y: 3.91))
        bezierPath.addCurve(to: CGPoint(x: 11.08, y: 3.79), controlPoint1: CGPoint(x: 11.7, y: 4.04), controlPoint2: CGPoint(x: 11.08, y: 3.79))
        bezierPath.addCurve(to: CGPoint(x: 10.38, y: 3.63), controlPoint1: CGPoint(x: 11.05, y: 3.77), controlPoint2: CGPoint(x: 10.38, y: 3.63))
        bezierPath.addCurve(to: CGPoint(x: 10.64, y: 3.48), controlPoint1: CGPoint(x: 10.42, y: 3.59), controlPoint2: CGPoint(x: 10.56, y: 3.54))
        bezierPath.addCurve(to: CGPoint(x: 10.87, y: 3.23), controlPoint1: CGPoint(x: 10.68, y: 3.44), controlPoint2: CGPoint(x: 10.85, y: 3.27))
        bezierPath.addCurve(to: CGPoint(x: 10.71, y: 2.96), controlPoint1: CGPoint(x: 10.91, y: 3.07), controlPoint2: CGPoint(x: 10.87, y: 3.07))
        bezierPath.addCurve(to: CGPoint(x: 10.21, y: 2.65), controlPoint1: CGPoint(x: 10.56, y: 2.86), controlPoint2: CGPoint(x: 10.37, y: 2.69))
        bezierPath.addCurve(to: CGPoint(x: 9.54, y: 3.32), controlPoint1: CGPoint(x: 9.58, y: 2.53), controlPoint2: CGPoint(x: 10.02, y: 3.21))
        bezierPath.addLine(to: CGPoint(x: 9.59, y: 3.3))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 3.61, y: 4.85))
        bezierPath.addCurve(to: CGPoint(x: 1.78, y: 10), controlPoint1: CGPoint(x: 2.47, y: 6.26), controlPoint2: CGPoint(x: 1.78, y: 8.05))
        bezierPath.addCurve(to: CGPoint(x: 9.96, y: 18.32), controlPoint1: CGPoint(x: 1.78, y: 14.53), controlPoint2: CGPoint(x: 5.47, y: 18.22))
        bezierPath.addCurve(to: CGPoint(x: 10.62, y: 18.28), controlPoint1: CGPoint(x: 10.19, y: 18.32), controlPoint2: CGPoint(x: 10.39, y: 18.3))
        bezierPath.addCurve(to: CGPoint(x: 10.48, y: 18.16), controlPoint1: CGPoint(x: 10.64, y: 18.22), controlPoint2: CGPoint(x: 10.64, y: 18.16))
        bezierPath.addCurve(to: CGPoint(x: 10.71, y: 17.8), controlPoint1: CGPoint(x: 10.54, y: 18.01), controlPoint2: CGPoint(x: 10.66, y: 17.93))
        bezierPath.addCurve(to: CGPoint(x: 10.73, y: 17.66), controlPoint1: CGPoint(x: 10.73, y: 17.74), controlPoint2: CGPoint(x: 10.71, y: 17.72))
        bezierPath.addCurve(to: CGPoint(x: 10.73, y: 17.35), controlPoint1: CGPoint(x: 10.79, y: 17.43), controlPoint2: CGPoint(x: 10.77, y: 17.51))
        bezierPath.addCurve(to: CGPoint(x: 10.87, y: 16.5), controlPoint1: CGPoint(x: 10.64, y: 16.97), controlPoint2: CGPoint(x: 10.77, y: 16.85))
        bezierPath.addCurve(to: CGPoint(x: 11.04, y: 15.25), controlPoint1: CGPoint(x: 10.98, y: 16.12), controlPoint2: CGPoint(x: 10.98, y: 15.65))
        bezierPath.addCurve(to: CGPoint(x: 11.06, y: 14.48), controlPoint1: CGPoint(x: 11.08, y: 15.06), controlPoint2: CGPoint(x: 11.12, y: 14.67))
        bezierPath.addCurve(to: CGPoint(x: 10.52, y: 13.99), controlPoint1: CGPoint(x: 11, y: 14.28), controlPoint2: CGPoint(x: 10.66, y: 14.13))
        bezierPath.addCurve(to: CGPoint(x: 10.04, y: 13.34), controlPoint1: CGPoint(x: 10.31, y: 13.8), controlPoint2: CGPoint(x: 10.21, y: 13.59))
        bezierPath.addCurve(to: CGPoint(x: 9.81, y: 12.97), controlPoint1: CGPoint(x: 9.96, y: 13.22), controlPoint2: CGPoint(x: 9.88, y: 13.09))
        bezierPath.addCurve(to: CGPoint(x: 9.83, y: 12.68), controlPoint1: CGPoint(x: 9.67, y: 12.68), controlPoint2: CGPoint(x: 9.81, y: 12.84))
        bezierPath.addCurve(to: CGPoint(x: 9.88, y: 12.2), controlPoint1: CGPoint(x: 9.85, y: 12.51), controlPoint2: CGPoint(x: 9.81, y: 12.37))
        bezierPath.addCurve(to: CGPoint(x: 10.19, y: 11.7), controlPoint1: CGPoint(x: 9.96, y: 12.01), controlPoint2: CGPoint(x: 10.12, y: 11.89))
        bezierPath.addCurve(to: CGPoint(x: 10.02, y: 11.27), controlPoint1: CGPoint(x: 10.23, y: 11.54), controlPoint2: CGPoint(x: 10.19, y: 11.33))
        bezierPath.addCurve(to: CGPoint(x: 9.73, y: 11.29), controlPoint1: CGPoint(x: 9.94, y: 11.22), controlPoint2: CGPoint(x: 9.83, y: 11.31))
        bezierPath.addLine(to: CGPoint(x: 9.34, y: 11.08))
        bezierPath.addCurve(to: CGPoint(x: 8.98, y: 10.68), controlPoint1: CGPoint(x: 9.19, y: 10.98), controlPoint2: CGPoint(x: 9.15, y: 10.79))
        bezierPath.addCurve(to: CGPoint(x: 8.61, y: 10.6), controlPoint1: CGPoint(x: 8.84, y: 10.58), controlPoint2: CGPoint(x: 8.75, y: 10.64))
        bezierPath.addCurve(to: CGPoint(x: 8.26, y: 10.31), controlPoint1: CGPoint(x: 8.46, y: 10.54), controlPoint2: CGPoint(x: 8.38, y: 10.37))
        bezierPath.addCurve(to: CGPoint(x: 7.8, y: 10.33), controlPoint1: CGPoint(x: 8.09, y: 10.23), controlPoint2: CGPoint(x: 7.99, y: 10.35))
        bezierPath.addCurve(to: CGPoint(x: 7.24, y: 10.06), controlPoint1: CGPoint(x: 7.63, y: 10.31), controlPoint2: CGPoint(x: 7.38, y: 10.12))
        bezierPath.addCurve(to: CGPoint(x: 6.64, y: 9.46), controlPoint1: CGPoint(x: 6.95, y: 9.92), controlPoint2: CGPoint(x: 6.76, y: 9.77))
        bezierPath.addCurve(to: CGPoint(x: 6.2, y: 8.86), controlPoint1: CGPoint(x: 6.53, y: 9.21), controlPoint2: CGPoint(x: 6.37, y: 9.09))
        bezierPath.addCurve(to: CGPoint(x: 5.68, y: 8.38), controlPoint1: CGPoint(x: 6.01, y: 8.63), controlPoint2: CGPoint(x: 5.95, y: 8.44))
        bezierPath.addCurve(to: CGPoint(x: 5.77, y: 8.63), controlPoint1: CGPoint(x: 5.66, y: 8.36), controlPoint2: CGPoint(x: 5.77, y: 8.61))
        bezierPath.addCurve(to: CGPoint(x: 6.14, y: 9.15), controlPoint1: CGPoint(x: 5.87, y: 8.82), controlPoint2: CGPoint(x: 6.01, y: 8.98))
        bezierPath.addCurve(to: CGPoint(x: 6.06, y: 9.21), controlPoint1: CGPoint(x: 6.31, y: 9.4), controlPoint2: CGPoint(x: 6.24, y: 9.46))
        bezierPath.addLine(to: CGPoint(x: 5.43, y: 8.36))
        bezierPath.addCurve(to: CGPoint(x: 5.27, y: 8.07), controlPoint1: CGPoint(x: 5.37, y: 8.26), controlPoint2: CGPoint(x: 5.37, y: 8.17))
        bezierPath.addCurve(to: CGPoint(x: 4.91, y: 7.82), controlPoint1: CGPoint(x: 5.16, y: 7.97), controlPoint2: CGPoint(x: 5.02, y: 7.92))
        bezierPath.addCurve(to: CGPoint(x: 4.5, y: 6.51), controlPoint1: CGPoint(x: 4.52, y: 7.47), controlPoint2: CGPoint(x: 4.46, y: 7.01))
        bezierPath.addCurve(to: CGPoint(x: 4.54, y: 6.06), controlPoint1: CGPoint(x: 4.5, y: 6.35), controlPoint2: CGPoint(x: 4.56, y: 6.2))
        bezierPath.addCurve(to: CGPoint(x: 4.35, y: 5.72), controlPoint1: CGPoint(x: 4.52, y: 5.93), controlPoint2: CGPoint(x: 4.46, y: 5.83))
        bezierPath.addCurve(to: CGPoint(x: 4.25, y: 5.54), controlPoint1: CGPoint(x: 4.33, y: 5.66), controlPoint2: CGPoint(x: 4.25, y: 5.54))
        bezierPath.addCurve(to: CGPoint(x: 3.96, y: 5.12), controlPoint1: CGPoint(x: 4.17, y: 5.39), controlPoint2: CGPoint(x: 4.11, y: 5.25))
        bezierPath.addCurve(to: CGPoint(x: 3.61, y: 4.85), controlPoint1: CGPoint(x: 3.9, y: 5.08), controlPoint2: CGPoint(x: 3.75, y: 4.96))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 18.5, y: 10))
        bezierPath.addCurve(to: CGPoint(x: 10, y: 18.5), controlPoint1: CGPoint(x: 18.5, y: 14.69), controlPoint2: CGPoint(x: 14.69, y: 18.5))
        bezierPath.addCurve(to: CGPoint(x: 1.5, y: 10), controlPoint1: CGPoint(x: 5.31, y: 18.5), controlPoint2: CGPoint(x: 1.5, y: 14.69))
        bezierPath.addCurve(to: CGPoint(x: 3.65, y: 4.35), controlPoint1: CGPoint(x: 1.5, y: 7.83), controlPoint2: CGPoint(x: 2.31, y: 5.86))
        bezierPath.addCurve(to: CGPoint(x: 5.07, y: 3.08), controlPoint1: CGPoint(x: 4.07, y: 3.88), controlPoint2: CGPoint(x: 4.55, y: 3.45))
        bezierPath.addCurve(to: CGPoint(x: 10, y: 1.5), controlPoint1: CGPoint(x: 6.46, y: 2.08), controlPoint2: CGPoint(x: 8.16, y: 1.5))
        bezierPath.addCurve(to: CGPoint(x: 18.5, y: 10), controlPoint1: CGPoint(x: 14.69, y: 1.5), controlPoint2: CGPoint(x: 18.5, y: 5.31))
        bezierPath.close()
        color.setFill()
        bezierPath.fill()
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 1, y: 1, width: 18, height: 18))
        color.setStroke()
        ovalPath.lineWidth = 2
        ovalPath.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!.withRenderingMode(.alwaysTemplate)
    }
}
