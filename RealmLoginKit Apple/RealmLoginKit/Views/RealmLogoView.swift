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

import Foundation
import UIKit

public enum RealmLogoStyle {
    case colored    // The standard, colored version of the Realm logo, good for light themed interfaces
    case monochrome // A monochrome, hollow version of the Realm logo, good for dark theme interfaces
}

@IBDesignable
public class RealmLogoView: UIView
{
    /** Set the visual style of the Realm logo */
    @IBInspectable public var style: RealmLogoStyle = .colored {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /** Controls whether the 'realm' text is present in the logo or not */
    @IBInspectable public var isWordMarkHidden: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /** In the monochrome style, the stroke thickness of the Realm Logo */
    @IBInspectable public var logoStrokeWidth: Double = 8.0

    
    public init(frame: CGRect, style: RealmLogoStyle = .colored, wordMarkHidden: Bool = false) {
        self.style = style
        self.isWordMarkHidden = wordMarkHidden
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.contentMode = .redraw
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentMode = .redraw
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if style == .monochrome {
            if isWordMarkHidden {
                drawMonochromeLogo(frame: bounds, tintColor: tintColor, strokeWidth: CGFloat(logoStrokeWidth))
            }
            else {
                drawMonochromeLogoAndWordmark(frame: bounds, tintColor: tintColor, strokeWidth: CGFloat(logoStrokeWidth))
            }
        }
        else {
            if isWordMarkHidden {
                drawColoredLogo(frame: bounds)
            }
            else {
                drawColoredLogoAndWordmark(frame: bounds, textTintColor: tintColor)
            }
        }
    }
    
    override public func sizeToFit() {
        var resizedFrame = frame
        
        // size to a square if the word mark is hidden
        if isWordMarkHidden {
            resizedFrame.size.height = resizedFrame.size.width
        }
        else {
            let scale = style == .monochrome ? 0.3341 : 0.3184
            resizedFrame.size.height = resizedFrame.size.width * CGFloat(scale)
        }
        
        frame = resizedFrame
        
        setNeedsDisplay()
    }
    
    private func drawColoredLogo(frame: CGRect) {
        
        
        //// Color Declarations
        let fillColor = UIColor(red: 0.988, green: 0.765, blue: 0.592, alpha: 1.000)
        let fillColor2 = UIColor(red: 0.988, green: 0.624, blue: 0.584, alpha: 1.000)
        let fillColor3 = UIColor(red: 0.969, green: 0.486, blue: 0.533, alpha: 1.000)
        let fillColor4 = UIColor(red: 0.949, green: 0.318, blue: 0.573, alpha: 1.000)
        let fillColor5 = UIColor(red: 0.827, green: 0.298, blue: 0.639, alpha: 1.000)
        let fillColor6 = UIColor(red: 0.604, green: 0.314, blue: 0.647, alpha: 1.000)
        let fillColor7 = UIColor(red: 0.349, green: 0.337, blue: 0.620, alpha: 1.000)
        let fillColor8 = UIColor(red: 0.224, green: 0.278, blue: 0.498, alpha: 1.000)
        
        
        //// Subframes
        let group2: CGRect = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
        
        
        //// Group 2
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: group2.minX + 0.71438 * group2.width, y: group2.minY + 0.04816 * group2.height))
        bezierPath.addCurve(to: CGPoint(x: group2.minX + 0.50000 * group2.width, y: group2.minY + 0.00000 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.64941 * group2.width, y: group2.minY + 0.01728 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.57672 * group2.width, y: group2.minY + 0.00000 * group2.height))
        bezierPath.addCurve(to: CGPoint(x: group2.minX + 0.15485 * group2.width, y: group2.minY + 0.13823 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.36616 * group2.width, y: group2.minY + 0.00000 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.24459 * group2.width, y: group2.minY + 0.05259 * group2.height))
        bezierPath.addCurve(to: CGPoint(x: group2.minX + 0.71438 * group2.width, y: group2.minY + 0.04816 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.05944 * group2.width, y: group2.minY + 0.22929 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.88326 * group2.width, y: group2.minY + 0.12843 * group2.height))
        bezierPath.close()
        bezierPath.usesEvenOddFillRule = true
        fillColor.setFill()
        bezierPath.fill()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: group2.minX + 0.89062 * group2.width, y: group2.minY + 0.18785 * group2.height))
        bezier2Path.addCurve(to: CGPoint(x: group2.minX + 0.72555 * group2.width, y: group2.minY + 0.25952 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.89119 * group2.width, y: group2.minY + 0.18856 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.84984 * group2.width, y: group2.minY + 0.24383 * group2.height))
        bezier2Path.addCurve(to: CGPoint(x: group2.minX + 0.04467 * group2.width, y: group2.minY + 0.29312 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.47470 * group2.width, y: group2.minY + 0.29119 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.04403 * group2.width, y: group2.minY + 0.29454 * group2.height))
        bezier2Path.addCurve(to: CGPoint(x: group2.minX + 0.15485 * group2.width, y: group2.minY + 0.13823 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.07132 * group2.width, y: group2.minY + 0.23457 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.10892 * group2.width, y: group2.minY + 0.18207 * group2.height))
        bezier2Path.addCurve(to: CGPoint(x: group2.minX + 0.32362 * group2.width, y: group2.minY + 0.14907 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.20898 * group2.width, y: group2.minY + 0.15513 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.26789 * group2.width, y: group2.minY + 0.15934 * group2.height))
        bezier2Path.addCurve(to: CGPoint(x: group2.minX + 0.58851 * group2.width, y: group2.minY + 0.05741 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.41563 * group2.width, y: group2.minY + 0.13224 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.49750 * group2.width, y: group2.minY + 0.07907 * group2.height))
        bezier2Path.addCurve(to: CGPoint(x: group2.minX + 0.71438 * group2.width, y: group2.minY + 0.04816 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.62891 * group2.width, y: group2.minY + 0.04770 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.67292 * group2.width, y: group2.minY + 0.04487 * group2.height))
        bezier2Path.addCurve(to: CGPoint(x: group2.minX + 0.89062 * group2.width, y: group2.minY + 0.18785 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.78326 * group2.width, y: group2.minY + 0.08090 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.84346 * group2.width, y: group2.minY + 0.12892 * group2.height))
        bezier2Path.close()
        bezier2Path.usesEvenOddFillRule = true
        fillColor2.setFill()
        bezier2Path.fill()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: group2.minX + 0.99390 * group2.width, y: group2.minY + 0.42168 * group2.height))
        bezier3Path.addCurve(to: CGPoint(x: group2.minX + 0.15246 * group2.width, y: group2.minY + 0.46139 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.99422 * group2.width, y: group2.minY + 0.42369 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.42823 * group2.width, y: group2.minY + 0.47689 * group2.height))
        bezier3Path.addCurve(to: CGPoint(x: group2.minX + 0.01020 * group2.width, y: group2.minY + 0.39905 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.06261 * group2.width, y: group2.minY + 0.45633 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.00959 * group2.width, y: group2.minY + 0.40201 * group2.height))
        bezier3Path.addCurve(to: CGPoint(x: group2.minX + 0.04468 * group2.width, y: group2.minY + 0.29311 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.01777 * group2.width, y: group2.minY + 0.36208 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.02943 * group2.width, y: group2.minY + 0.32661 * group2.height))
        bezier3Path.addCurve(to: CGPoint(x: group2.minX + 0.30896 * group2.width, y: group2.minY + 0.22533 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.12435 * group2.width, y: group2.minY + 0.24951 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.21808 * group2.width, y: group2.minY + 0.22434 * group2.height))
        bezier3Path.addCurve(to: CGPoint(x: group2.minX + 0.64873 * group2.width, y: group2.minY + 0.26167 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.42294 * group2.width, y: group2.minY + 0.22650 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.53475 * group2.width, y: group2.minY + 0.26450 * group2.height))
        bezier3Path.addCurve(to: CGPoint(x: group2.minX + 0.89062 * group2.width, y: group2.minY + 0.18785 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.73338 * group2.width, y: group2.minY + 0.25951 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.81869 * group2.width, y: group2.minY + 0.23250 * group2.height))
        bezier3Path.addCurve(to: CGPoint(x: group2.minX + 0.99390 * group2.width, y: group2.minY + 0.42168 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.94362 * group2.width, y: group2.minY + 0.25409 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.98013 * group2.width, y: group2.minY + 0.33411 * group2.height))
        bezier3Path.close()
        bezier3Path.usesEvenOddFillRule = true
        fillColor3.setFill()
        bezier3Path.fill()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: group2.minX + 1.00000 * group2.width, y: group2.minY + 0.50000 * group2.height))
        bezier4Path.addCurve(to: CGPoint(x: group2.minX + 0.99993 * group2.width, y: group2.minY + 0.50830 * group2.height), controlPoint1: CGPoint(x: group2.minX + 1.00000 * group2.width, y: group2.minY + 0.50277 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.99993 * group2.width, y: group2.minY + 0.50830 * group2.height))
        bezier4Path.addCurve(to: CGPoint(x: group2.minX + 0.64027 * group2.width, y: group2.minY + 0.54558 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.99993 * group2.width, y: group2.minY + 0.50830 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.84273 * group2.width, y: group2.minY + 0.54795 * group2.height))
        bezier4Path.addCurve(to: CGPoint(x: group2.minX + 0.00002 * group2.width, y: group2.minY + 0.49569 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.35669 * group2.width, y: group2.minY + 0.54227 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.00001 * group2.width, y: group2.minY + 0.49653 * group2.height))
        bezier4Path.addCurve(to: CGPoint(x: group2.minX + 0.01025 * group2.width, y: group2.minY + 0.39877 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.00030 * group2.width, y: group2.minY + 0.46251 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.00381 * group2.width, y: group2.minY + 0.43011 * group2.height))
        bezier4Path.addCurve(to: CGPoint(x: group2.minX + 0.23989 * group2.width, y: group2.minY + 0.45258 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.07819 * group2.width, y: group2.minY + 0.44069 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.16059 * group2.width, y: group2.minY + 0.46123 * group2.height))
        bezier4Path.addCurve(to: CGPoint(x: group2.minX + 0.42126 * group2.width, y: group2.minY + 0.39758 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.30295 * group2.width, y: group2.minY + 0.44575 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.36285 * group2.width, y: group2.minY + 0.42242 * group2.height))
        bezier4Path.addCurve(to: CGPoint(x: group2.minX + 0.59946 * group2.width, y: group2.minY + 0.33175 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.47966 * group2.width, y: group2.minY + 0.37275 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.53773 * group2.width, y: group2.minY + 0.34608 * group2.height))
        bezier4Path.addCurve(to: CGPoint(x: group2.minX + 0.87383 * group2.width, y: group2.minY + 0.35225 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.69014 * group2.width, y: group2.minY + 0.31075 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.78715 * group2.width, y: group2.minY + 0.31808 * group2.height))
        bezier4Path.addCurve(to: CGPoint(x: group2.minX + 0.99389 * group2.width, y: group2.minY + 0.42162 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.91601 * group2.width, y: group2.minY + 0.36888 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.95785 * group2.width, y: group2.minY + 0.39279 * group2.height))
        bezier4Path.addCurve(to: CGPoint(x: group2.minX + 1.00000 * group2.width, y: group2.minY + 0.50000 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.99791 * group2.width, y: group2.minY + 0.44716 * group2.height), controlPoint2: CGPoint(x: group2.minX + 1.00000 * group2.width, y: group2.minY + 0.47334 * group2.height))
        bezier4Path.close()
        bezier4Path.usesEvenOddFillRule = true
        fillColor4.setFill()
        bezier4Path.fill()
        
        
        //// Bezier 5 Drawing
        let bezier5Path = UIBezierPath()
        bezier5Path.move(to: CGPoint(x: group2.minX + 0.43295 * group2.width, y: group2.minY + 0.66235 * group2.height))
        bezier5Path.addCurve(to: CGPoint(x: group2.minX + 0.02486 * group2.width, y: group2.minY + 0.65612 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.28294 * group2.width, y: group2.minY + 0.69005 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.02550 * group2.width, y: group2.minY + 0.65810 * group2.height))
        bezier5Path.addCurve(to: CGPoint(x: group2.minX + 0.00000 * group2.width, y: group2.minY + 0.50000 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.00873 * group2.width, y: group2.minY + 0.60700 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.00000 * group2.width, y: group2.minY + 0.55452 * group2.height))
        bezier5Path.addCurve(to: CGPoint(x: group2.minX + 0.00002 * group2.width, y: group2.minY + 0.49568 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.00000 * group2.width, y: group2.minY + 0.49856 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.00001 * group2.width, y: group2.minY + 0.49712 * group2.height))
        bezier5Path.addCurve(to: CGPoint(x: group2.minX + 0.07536 * group2.width, y: group2.minY + 0.44901 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.02279 * group2.width, y: group2.minY + 0.47763 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.04939 * group2.width, y: group2.minY + 0.46153 * group2.height))
        bezier5Path.addCurve(to: CGPoint(x: group2.minX + 0.28351 * group2.width, y: group2.minY + 0.41185 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.13959 * group2.width, y: group2.minY + 0.41785 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.21246 * group2.width, y: group2.minY + 0.40485 * group2.height))
        bezier5Path.addCurve(to: CGPoint(x: group2.minX + 0.48568 * group2.width, y: group2.minY + 0.47285 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.35373 * group2.width, y: group2.minY + 0.41885 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.42078 * group2.width, y: group2.minY + 0.44485 * group2.height))
        bezier5Path.addCurve(to: CGPoint(x: group2.minX + 0.65141 * group2.width, y: group2.minY + 0.53953 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.54035 * group2.width, y: group2.minY + 0.49644 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.59466 * group2.width, y: group2.minY + 0.52192 * group2.height))
        bezier5Path.addCurve(to: CGPoint(x: group2.minX + 0.43295 * group2.width, y: group2.minY + 0.66235 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.65697 * group2.width, y: group2.minY + 0.54125 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.59808 * group2.width, y: group2.minY + 0.63185 * group2.height))
        bezier5Path.close()
        bezier5Path.usesEvenOddFillRule = true
        fillColor5.setFill()
        bezier5Path.fill()
        
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.move(to: CGPoint(x: group2.minX + 0.98196 * group2.width, y: group2.minY + 0.63356 * group2.height))
        bezier6Path.addCurve(to: CGPoint(x: group2.minX + 0.73682 * group2.width, y: group2.minY + 0.72106 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.97149 * group2.width, y: group2.minY + 0.65126 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.87186 * group2.width, y: group2.minY + 0.71085 * group2.height))
        bezier6Path.addCurve(to: CGPoint(x: group2.minX + 0.41685 * group2.width, y: group2.minY + 0.65301 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.55801 * group2.width, y: group2.minY + 0.73457 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.34678 * group2.width, y: group2.minY + 0.68052 * group2.height))
        bezier6Path.addCurve(to: CGPoint(x: group2.minX + 0.73682 * group2.width, y: group2.minY + 0.49935 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.52717 * group2.width, y: group2.minY + 0.60968 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.62284 * group2.width, y: group2.minY + 0.53185 * group2.height))
        bezier6Path.addCurve(to: CGPoint(x: group2.minX + 0.99993 * group2.width, y: group2.minY + 0.50829 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.82196 * group2.width, y: group2.minY + 0.47496 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.91635 * group2.width, y: group2.minY + 0.47881 * group2.height))
        bezier6Path.addCurve(to: CGPoint(x: group2.minX + 0.98196 * group2.width, y: group2.minY + 0.63356 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.99923 * group2.width, y: group2.minY + 0.55161 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.99302 * group2.width, y: group2.minY + 0.59359 * group2.height))
        bezier6Path.close()
        bezier6Path.usesEvenOddFillRule = true
        fillColor6.setFill()
        bezier6Path.fill()
        
        
        //// Bezier 7 Drawing
        let bezier7Path = UIBezierPath()
        bezier7Path.move(to: CGPoint(x: group2.minX + 0.93357 * group2.width, y: group2.minY + 0.74920 * group2.height))
        bezier7Path.addCurve(to: CGPoint(x: group2.minX + 0.12958 * group2.width, y: group2.minY + 0.83585 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.84724 * group2.width, y: group2.minY + 0.89909 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.22106 * group2.width, y: group2.minY + 0.93668 * group2.height))
        bezier7Path.addCurve(to: CGPoint(x: group2.minX + 0.02486 * group2.width, y: group2.minY + 0.65612 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.08302 * group2.width, y: group2.minY + 0.78452 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.04697 * group2.width, y: group2.minY + 0.72348 * group2.height))
        bezier7Path.addCurve(to: CGPoint(x: group2.minX + 0.27829 * group2.width, y: group2.minY + 0.60533 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.10175 * group2.width, y: group2.minY + 0.61217 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.19177 * group2.width, y: group2.minY + 0.59350 * group2.height))
        bezier7Path.addCurve(to: CGPoint(x: group2.minX + 0.60109 * group2.width, y: group2.minY + 0.70750 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.39027 * group2.width, y: group2.minY + 0.62067 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.49060 * group2.width, y: group2.minY + 0.68317 * group2.height))
        bezier7Path.addCurve(to: CGPoint(x: group2.minX + 0.87064 * group2.width, y: group2.minY + 0.69000 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.69027 * group2.width, y: group2.minY + 0.72717 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.78478 * group2.width, y: group2.minY + 0.72100 * group2.height))
        bezier7Path.addCurve(to: CGPoint(x: group2.minX + 0.98196 * group2.width, y: group2.minY + 0.63356 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.90945 * group2.width, y: group2.minY + 0.67588 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.94793 * group2.width, y: group2.minY + 0.65695 * group2.height))
        bezier7Path.addCurve(to: CGPoint(x: group2.minX + 0.93357 * group2.width, y: group2.minY + 0.74920 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.97066 * group2.width, y: group2.minY + 0.67444 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.95429 * group2.width, y: group2.minY + 0.71323 * group2.height))
        bezier7Path.close()
        bezier7Path.usesEvenOddFillRule = true
        fillColor7.setFill()
        bezier7Path.fill()
        
        
        //// Bezier 8 Drawing
        let bezier8Path = UIBezierPath()
        bezier8Path.move(to: CGPoint(x: group2.minX + 0.93429 * group2.width, y: group2.minY + 0.74794 * group2.height))
        bezier8Path.addCurve(to: CGPoint(x: group2.minX + 0.50000 * group2.width, y: group2.minY + 1.00000 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.84814 * group2.width, y: group2.minY + 0.89853 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.68592 * group2.width, y: group2.minY + 1.00000 * group2.height))
        bezier8Path.addCurve(to: CGPoint(x: group2.minX + 0.12953 * group2.width, y: group2.minY + 0.83580 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.35311 * group2.width, y: group2.minY + 1.00000 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.22101 * group2.width, y: group2.minY + 0.93666 * group2.height))
        bezier8Path.addCurve(to: CGPoint(x: group2.minX + 0.17725 * group2.width, y: group2.minY + 0.85100 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.14471 * group2.width, y: group2.minY + 0.84160 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.16169 * group2.width, y: group2.minY + 0.84662 * group2.height))
        bezier8Path.addCurve(to: CGPoint(x: group2.minX + 0.44448 * group2.width, y: group2.minY + 0.84883 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.26428 * group2.width, y: group2.minY + 0.87500 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.35795 * group2.width, y: group2.minY + 0.87433 * group2.height))
        bezier8Path.addCurve(to: CGPoint(x: group2.minX + 0.60637 * group2.width, y: group2.minY + 0.78683 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.49988 * group2.width, y: group2.minY + 0.83250 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.55196 * group2.width, y: group2.minY + 0.80650 * group2.height))
        bezier8Path.addCurve(to: CGPoint(x: group2.minX + 0.93429 * group2.width, y: group2.minY + 0.74794 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.71020 * group2.width, y: group2.minY + 0.74939 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.82447 * group2.width, y: group2.minY + 0.73621 * group2.height))
        bezier8Path.addLine(to: CGPoint(x: group2.minX + 0.93429 * group2.width, y: group2.minY + 0.74794 * group2.height))
        bezier8Path.close()
        bezier8Path.usesEvenOddFillRule = true
        fillColor8.setFill()
        bezier8Path.fill()
    }
    
    private func drawColoredLogoAndWordmark(frame: CGRect, textTintColor: UIColor?) {

        //// Color Declarations
        let fillColor = UIColor(red: 0.988, green: 0.765, blue: 0.592, alpha: 1.000)
        let fillColor2 = UIColor(red: 0.988, green: 0.624, blue: 0.584, alpha: 1.000)
        let fillColor3 = UIColor(red: 0.969, green: 0.486, blue: 0.533, alpha: 1.000)
        let fillColor4 = UIColor(red: 0.949, green: 0.318, blue: 0.573, alpha: 1.000)
        let fillColor5 = UIColor(red: 0.827, green: 0.298, blue: 0.639, alpha: 1.000)
        let fillColor6 = UIColor(red: 0.604, green: 0.314, blue: 0.647, alpha: 1.000)
        let fillColor7 = UIColor(red: 0.349, green: 0.337, blue: 0.620, alpha: 1.000)
        let fillColor8 = UIColor(red: 0.224, green: 0.278, blue: 0.498, alpha: 1.000)
        let fillColor9 = UIColor(red: 0.110, green: 0.137, blue: 0.247, alpha: 1.000)
        
        
        //// Subframes
        let realmLogo: CGRect = CGRect(x: frame.minX - 0.23, y: frame.minY, width: frame.width - 0.2, height: frame.height)
        
        
        //// realmLogo
        //// orbyFirstSlice Drawing
        let orbyFirstSlicePath = UIBezierPath()
        orbyFirstSlicePath.move(to: CGPoint(x: realmLogo.minX + 0.22756 * realmLogo.width, y: realmLogo.minY + 0.04816 * realmLogo.height))
        orbyFirstSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.15927 * realmLogo.width, y: realmLogo.minY + 0.00000 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.20686 * realmLogo.width, y: realmLogo.minY + 0.01728 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.18371 * realmLogo.width, y: realmLogo.minY + 0.00000 * realmLogo.height))
        orbyFirstSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.04933 * realmLogo.width, y: realmLogo.minY + 0.13823 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.11664 * realmLogo.width, y: realmLogo.minY + 0.00000 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.07791 * realmLogo.width, y: realmLogo.minY + 0.05259 * realmLogo.height))
        orbyFirstSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.22756 * realmLogo.width, y: realmLogo.minY + 0.04816 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.01894 * realmLogo.width, y: realmLogo.minY + 0.22929 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.28135 * realmLogo.width, y: realmLogo.minY + 0.12843 * realmLogo.height))
        orbyFirstSlicePath.close()
        orbyFirstSlicePath.usesEvenOddFillRule = true
        fillColor.setFill()
        orbyFirstSlicePath.fill()
        
        
        //// orbySecondSlice Drawing
        let orbySecondSlicePath = UIBezierPath()
        orbySecondSlicePath.move(to: CGPoint(x: realmLogo.minX + 0.28370 * realmLogo.width, y: realmLogo.minY + 0.18785 * realmLogo.height))
        orbySecondSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.23112 * realmLogo.width, y: realmLogo.minY + 0.25952 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.28388 * realmLogo.width, y: realmLogo.minY + 0.18856 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.27071 * realmLogo.width, y: realmLogo.minY + 0.24383 * realmLogo.height))
        orbySecondSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.01423 * realmLogo.width, y: realmLogo.minY + 0.29312 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.15121 * realmLogo.width, y: realmLogo.minY + 0.29119 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.01402 * realmLogo.width, y: realmLogo.minY + 0.29454 * realmLogo.height))
        orbySecondSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.04933 * realmLogo.width, y: realmLogo.minY + 0.13823 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.02272 * realmLogo.width, y: realmLogo.minY + 0.23457 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.03469 * realmLogo.width, y: realmLogo.minY + 0.18207 * realmLogo.height))
        orbySecondSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.10309 * realmLogo.width, y: realmLogo.minY + 0.14907 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.06657 * realmLogo.width, y: realmLogo.minY + 0.15513 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.08534 * realmLogo.width, y: realmLogo.minY + 0.15934 * realmLogo.height))
        orbySecondSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.18746 * realmLogo.width, y: realmLogo.minY + 0.05741 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.13240 * realmLogo.width, y: realmLogo.minY + 0.13224 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.15847 * realmLogo.width, y: realmLogo.minY + 0.07907 * realmLogo.height))
        orbySecondSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.22756 * realmLogo.width, y: realmLogo.minY + 0.04816 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.20033 * realmLogo.width, y: realmLogo.minY + 0.04770 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.21435 * realmLogo.width, y: realmLogo.minY + 0.04487 * realmLogo.height))
        orbySecondSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.28370 * realmLogo.width, y: realmLogo.minY + 0.18785 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.24950 * realmLogo.width, y: realmLogo.minY + 0.08090 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.26868 * realmLogo.width, y: realmLogo.minY + 0.12892 * realmLogo.height))
        orbySecondSlicePath.close()
        orbySecondSlicePath.usesEvenOddFillRule = true
        fillColor2.setFill()
        orbySecondSlicePath.fill()
        
        
        //// orbyThirdSlice Drawing
        let orbyThirdSlicePath = UIBezierPath()
        orbyThirdSlicePath.move(to: CGPoint(x: realmLogo.minX + 0.31660 * realmLogo.width, y: realmLogo.minY + 0.42168 * realmLogo.height))
        orbyThirdSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.04856 * realmLogo.width, y: realmLogo.minY + 0.46139 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.31670 * realmLogo.width, y: realmLogo.minY + 0.42369 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.13641 * realmLogo.width, y: realmLogo.minY + 0.47689 * realmLogo.height))
        orbyThirdSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.00325 * realmLogo.width, y: realmLogo.minY + 0.39905 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.01994 * realmLogo.width, y: realmLogo.minY + 0.45633 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.00305 * realmLogo.width, y: realmLogo.minY + 0.40201 * realmLogo.height))
        orbyThirdSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.01423 * realmLogo.width, y: realmLogo.minY + 0.29311 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.00566 * realmLogo.width, y: realmLogo.minY + 0.36208 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.00938 * realmLogo.width, y: realmLogo.minY + 0.32661 * realmLogo.height))
        orbyThirdSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.09842 * realmLogo.width, y: realmLogo.minY + 0.22533 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.03961 * realmLogo.width, y: realmLogo.minY + 0.24951 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.06947 * realmLogo.width, y: realmLogo.minY + 0.22434 * realmLogo.height))
        orbyThirdSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.20665 * realmLogo.width, y: realmLogo.minY + 0.26167 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.13472 * realmLogo.width, y: realmLogo.minY + 0.22650 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.17034 * realmLogo.width, y: realmLogo.minY + 0.26450 * realmLogo.height))
        orbyThirdSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.28370 * realmLogo.width, y: realmLogo.minY + 0.18785 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.23361 * realmLogo.width, y: realmLogo.minY + 0.25951 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.26079 * realmLogo.width, y: realmLogo.minY + 0.23250 * realmLogo.height))
        orbyThirdSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.31660 * realmLogo.width, y: realmLogo.minY + 0.42168 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.30058 * realmLogo.width, y: realmLogo.minY + 0.25409 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.31221 * realmLogo.width, y: realmLogo.minY + 0.33411 * realmLogo.height))
        orbyThirdSlicePath.close()
        orbyThirdSlicePath.usesEvenOddFillRule = true
        fillColor3.setFill()
        orbyThirdSlicePath.fill()
        
        
        //// orbyFourthSlice Drawing
        let orbyFourthSlicePath = UIBezierPath()
        orbyFourthSlicePath.move(to: CGPoint(x: realmLogo.minX + 0.31854 * realmLogo.width, y: realmLogo.minY + 0.50000 * realmLogo.height))
        orbyFourthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.31852 * realmLogo.width, y: realmLogo.minY + 0.50830 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.31854 * realmLogo.width, y: realmLogo.minY + 0.50277 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.31852 * realmLogo.width, y: realmLogo.minY + 0.50830 * realmLogo.height))
        orbyFourthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.20395 * realmLogo.width, y: realmLogo.minY + 0.54558 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.31852 * realmLogo.width, y: realmLogo.minY + 0.50830 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.26844 * realmLogo.width, y: realmLogo.minY + 0.54795 * realmLogo.height))
        orbyFourthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.00001 * realmLogo.width, y: realmLogo.minY + 0.49569 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.11362 * realmLogo.width, y: realmLogo.minY + 0.54227 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.00000 * realmLogo.width, y: realmLogo.minY + 0.49653 * realmLogo.height))
        orbyFourthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.00327 * realmLogo.width, y: realmLogo.minY + 0.39877 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.00010 * realmLogo.width, y: realmLogo.minY + 0.46251 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.00121 * realmLogo.width, y: realmLogo.minY + 0.43011 * realmLogo.height))
        orbyFourthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.07642 * realmLogo.width, y: realmLogo.minY + 0.45258 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.02491 * realmLogo.width, y: realmLogo.minY + 0.44069 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.05115 * realmLogo.width, y: realmLogo.minY + 0.46123 * realmLogo.height))
        orbyFourthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.13419 * realmLogo.width, y: realmLogo.minY + 0.39758 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.09650 * realmLogo.width, y: realmLogo.minY + 0.44575 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.11558 * realmLogo.width, y: realmLogo.minY + 0.42242 * realmLogo.height))
        orbyFourthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.19095 * realmLogo.width, y: realmLogo.minY + 0.33175 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.15279 * realmLogo.width, y: realmLogo.minY + 0.37275 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.17129 * realmLogo.width, y: realmLogo.minY + 0.34608 * realmLogo.height))
        orbyFourthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.27835 * realmLogo.width, y: realmLogo.minY + 0.35225 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.21984 * realmLogo.width, y: realmLogo.minY + 0.31075 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.25074 * realmLogo.width, y: realmLogo.minY + 0.31808 * realmLogo.height))
        orbyFourthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.31660 * realmLogo.width, y: realmLogo.minY + 0.42162 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.29179 * realmLogo.width, y: realmLogo.minY + 0.36888 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.30511 * realmLogo.width, y: realmLogo.minY + 0.39279 * realmLogo.height))
        orbyFourthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.31854 * realmLogo.width, y: realmLogo.minY + 0.50000 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.31788 * realmLogo.width, y: realmLogo.minY + 0.44716 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.31854 * realmLogo.width, y: realmLogo.minY + 0.47334 * realmLogo.height))
        orbyFourthSlicePath.close()
        orbyFourthSlicePath.usesEvenOddFillRule = true
        fillColor4.setFill()
        orbyFourthSlicePath.fill()
        
        
        //// orbyFifthSlice Drawing
        let orbyFifthSlicePath = UIBezierPath()
        orbyFifthSlicePath.move(to: CGPoint(x: realmLogo.minX + 0.13791 * realmLogo.width, y: realmLogo.minY + 0.66235 * realmLogo.height))
        orbyFifthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.00792 * realmLogo.width, y: realmLogo.minY + 0.65612 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.09013 * realmLogo.width, y: realmLogo.minY + 0.69005 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.00812 * realmLogo.width, y: realmLogo.minY + 0.65810 * realmLogo.height))
        orbyFifthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + -0.00000 * realmLogo.width, y: realmLogo.minY + 0.50000 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.00278 * realmLogo.width, y: realmLogo.minY + 0.60700 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + -0.00000 * realmLogo.width, y: realmLogo.minY + 0.55452 * realmLogo.height))
        orbyFifthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.00001 * realmLogo.width, y: realmLogo.minY + 0.49568 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + -0.00000 * realmLogo.width, y: realmLogo.minY + 0.49856 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.00000 * realmLogo.width, y: realmLogo.minY + 0.49712 * realmLogo.height))
        orbyFifthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.02400 * realmLogo.width, y: realmLogo.minY + 0.44901 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.00726 * realmLogo.width, y: realmLogo.minY + 0.47763 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.01573 * realmLogo.width, y: realmLogo.minY + 0.46153 * realmLogo.height))
        orbyFifthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.09031 * realmLogo.width, y: realmLogo.minY + 0.41185 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.04446 * realmLogo.width, y: realmLogo.minY + 0.41785 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.06768 * realmLogo.width, y: realmLogo.minY + 0.40485 * realmLogo.height))
        orbyFifthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.15471 * realmLogo.width, y: realmLogo.minY + 0.47285 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.11268 * realmLogo.width, y: realmLogo.minY + 0.41885 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.13404 * realmLogo.width, y: realmLogo.minY + 0.44485 * realmLogo.height))
        orbyFifthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.20750 * realmLogo.width, y: realmLogo.minY + 0.53953 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.17212 * realmLogo.width, y: realmLogo.minY + 0.49644 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.18942 * realmLogo.width, y: realmLogo.minY + 0.52192 * realmLogo.height))
        orbyFifthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.13791 * realmLogo.width, y: realmLogo.minY + 0.66235 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.20927 * realmLogo.width, y: realmLogo.minY + 0.54125 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.19051 * realmLogo.width, y: realmLogo.minY + 0.63185 * realmLogo.height))
        orbyFifthSlicePath.close()
        orbyFifthSlicePath.usesEvenOddFillRule = true
        fillColor5.setFill()
        orbyFifthSlicePath.fill()
        
        
        //// orbySixthSlice Drawing
        let orbySixthSlicePath = UIBezierPath()
        orbySixthSlicePath.move(to: CGPoint(x: realmLogo.minX + 0.31279 * realmLogo.width, y: realmLogo.minY + 0.63356 * realmLogo.height))
        orbySixthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.23471 * realmLogo.width, y: realmLogo.minY + 0.72106 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.30946 * realmLogo.width, y: realmLogo.minY + 0.65126 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.27772 * realmLogo.width, y: realmLogo.minY + 0.71085 * realmLogo.height))
        orbySixthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.13278 * realmLogo.width, y: realmLogo.minY + 0.65301 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.17775 * realmLogo.width, y: realmLogo.minY + 0.73457 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.11046 * realmLogo.width, y: realmLogo.minY + 0.68052 * realmLogo.height))
        orbySixthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.23471 * realmLogo.width, y: realmLogo.minY + 0.49935 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.16792 * realmLogo.width, y: realmLogo.minY + 0.60968 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.19840 * realmLogo.width, y: realmLogo.minY + 0.53185 * realmLogo.height))
        orbySixthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.31852 * realmLogo.width, y: realmLogo.minY + 0.50829 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.26183 * realmLogo.width, y: realmLogo.minY + 0.47496 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.29189 * realmLogo.width, y: realmLogo.minY + 0.47881 * realmLogo.height))
        orbySixthSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.31279 * realmLogo.width, y: realmLogo.minY + 0.63356 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.31829 * realmLogo.width, y: realmLogo.minY + 0.55161 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.31632 * realmLogo.width, y: realmLogo.minY + 0.59359 * realmLogo.height))
        orbySixthSlicePath.close()
        orbySixthSlicePath.usesEvenOddFillRule = true
        fillColor6.setFill()
        orbySixthSlicePath.fill()
        
        
        //// orbySeventhSlice Drawing
        let orbySeventhSlicePath = UIBezierPath()
        orbySeventhSlicePath.move(to: CGPoint(x: realmLogo.minX + 0.29738 * realmLogo.width, y: realmLogo.minY + 0.74920 * realmLogo.height))
        orbySeventhSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.04128 * realmLogo.width, y: realmLogo.minY + 0.83585 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.26988 * realmLogo.width, y: realmLogo.minY + 0.89909 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.07042 * realmLogo.width, y: realmLogo.minY + 0.93668 * realmLogo.height))
        orbySeventhSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.00792 * realmLogo.width, y: realmLogo.minY + 0.65612 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.02644 * realmLogo.width, y: realmLogo.minY + 0.78452 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.01496 * realmLogo.width, y: realmLogo.minY + 0.72348 * realmLogo.height))
        orbySeventhSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.08865 * realmLogo.width, y: realmLogo.minY + 0.60533 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.03241 * realmLogo.width, y: realmLogo.minY + 0.61217 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.06109 * realmLogo.width, y: realmLogo.minY + 0.59350 * realmLogo.height))
        orbySeventhSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.19147 * realmLogo.width, y: realmLogo.minY + 0.70750 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.12432 * realmLogo.width, y: realmLogo.minY + 0.62067 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.15628 * realmLogo.width, y: realmLogo.minY + 0.68317 * realmLogo.height))
        orbySeventhSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.27733 * realmLogo.width, y: realmLogo.minY + 0.69000 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.21988 * realmLogo.width, y: realmLogo.minY + 0.72717 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.24998 * realmLogo.width, y: realmLogo.minY + 0.72100 * realmLogo.height))
        orbySeventhSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.31280 * realmLogo.width, y: realmLogo.minY + 0.63356 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.28970 * realmLogo.width, y: realmLogo.minY + 0.67588 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.30196 * realmLogo.width, y: realmLogo.minY + 0.65695 * realmLogo.height))
        orbySeventhSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.29738 * realmLogo.width, y: realmLogo.minY + 0.74920 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.30919 * realmLogo.width, y: realmLogo.minY + 0.67444 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.30398 * realmLogo.width, y: realmLogo.minY + 0.71323 * realmLogo.height))
        orbySeventhSlicePath.close()
        orbySeventhSlicePath.usesEvenOddFillRule = true
        fillColor7.setFill()
        orbySeventhSlicePath.fill()
        
        
        //// orbyEitherSlice Drawing
        let orbyEitherSlicePath = UIBezierPath()
        orbyEitherSlicePath.move(to: CGPoint(x: realmLogo.minX + 0.29761 * realmLogo.width, y: realmLogo.minY + 0.74794 * realmLogo.height))
        orbyEitherSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.15927 * realmLogo.width, y: realmLogo.minY + 1.00000 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.27017 * realmLogo.width, y: realmLogo.minY + 0.89853 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.21849 * realmLogo.width, y: realmLogo.minY + 1.00000 * realmLogo.height))
        orbyEitherSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.04126 * realmLogo.width, y: realmLogo.minY + 0.83580 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.11248 * realmLogo.width, y: realmLogo.minY + 1.00000 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.07040 * realmLogo.width, y: realmLogo.minY + 0.93666 * realmLogo.height))
        orbyEitherSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.05646 * realmLogo.width, y: realmLogo.minY + 0.85100 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.04610 * realmLogo.width, y: realmLogo.minY + 0.84160 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.05151 * realmLogo.width, y: realmLogo.minY + 0.84662 * realmLogo.height))
        orbyEitherSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.14158 * realmLogo.width, y: realmLogo.minY + 0.84883 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.08418 * realmLogo.width, y: realmLogo.minY + 0.87500 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.11402 * realmLogo.width, y: realmLogo.minY + 0.87433 * realmLogo.height))
        orbyEitherSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.19315 * realmLogo.width, y: realmLogo.minY + 0.78683 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.15923 * realmLogo.width, y: realmLogo.minY + 0.83250 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.17582 * realmLogo.width, y: realmLogo.minY + 0.80650 * realmLogo.height))
        orbyEitherSlicePath.addCurve(to: CGPoint(x: realmLogo.minX + 0.29761 * realmLogo.width, y: realmLogo.minY + 0.74794 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.22623 * realmLogo.width, y: realmLogo.minY + 0.74939 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.26263 * realmLogo.width, y: realmLogo.minY + 0.73621 * realmLogo.height))
        orbyEitherSlicePath.addLine(to: CGPoint(x: realmLogo.minX + 0.29761 * realmLogo.width, y: realmLogo.minY + 0.74794 * realmLogo.height))
        orbyEitherSlicePath.close()
        orbyEitherSlicePath.usesEvenOddFillRule = true
        fillColor8.setFill()
        orbyEitherSlicePath.fill()
        
        
        //// realmText Drawing
        let realmTextPath = UIBezierPath()
        realmTextPath.move(to: CGPoint(x: realmLogo.minX + 0.75063 * realmLogo.width, y: realmLogo.minY + 0.15680 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.79042 * realmLogo.width, y: realmLogo.minY + 0.15680 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.79042 * realmLogo.width, y: realmLogo.minY + 0.74429 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.75063 * realmLogo.width, y: realmLogo.minY + 0.74429 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.75063 * realmLogo.width, y: realmLogo.minY + 0.15680 * realmLogo.height))
        realmTextPath.close()
        realmTextPath.move(to: CGPoint(x: realmLogo.minX + 0.39287 * realmLogo.width, y: realmLogo.minY + 0.74398 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.43213 * realmLogo.width, y: realmLogo.minY + 0.74398 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.43213 * realmLogo.width, y: realmLogo.minY + 0.50167 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.44823 * realmLogo.width, y: realmLogo.minY + 0.41202 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.43213 * realmLogo.width, y: realmLogo.minY + 0.46165 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.43527 * realmLogo.width, y: realmLogo.minY + 0.41202 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.46410 * realmLogo.width, y: realmLogo.minY + 0.42965 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.45418 * realmLogo.width, y: realmLogo.minY + 0.41202 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.45933 * realmLogo.width, y: realmLogo.minY + 0.41698 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.47825 * realmLogo.width, y: realmLogo.minY + 0.32686 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.46426 * realmLogo.width, y: realmLogo.minY + 0.43013 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.47841 * realmLogo.width, y: realmLogo.minY + 0.32637 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.45358 * realmLogo.width, y: realmLogo.minY + 0.29546 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.46945 * realmLogo.width, y: realmLogo.minY + 0.30149 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.46028 * realmLogo.width, y: realmLogo.minY + 0.29546 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.42206 * realmLogo.width, y: realmLogo.minY + 0.36478 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.43905 * realmLogo.width, y: realmLogo.minY + 0.29546 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.42692 * realmLogo.width, y: realmLogo.minY + 0.32324 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.41435 * realmLogo.width, y: realmLogo.minY + 0.30778 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.39287 * realmLogo.width, y: realmLogo.minY + 0.30778 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.39287 * realmLogo.width, y: realmLogo.minY + 0.74398 * realmLogo.height))
        realmTextPath.close()
        realmTextPath.move(to: CGPoint(x: realmLogo.minX + 0.81271 * realmLogo.width, y: realmLogo.minY + 0.74398 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.85195 * realmLogo.width, y: realmLogo.minY + 0.74398 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.85195 * realmLogo.width, y: realmLogo.minY + 0.50167 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.87243 * realmLogo.width, y: realmLogo.minY + 0.41417 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.85195 * realmLogo.width, y: realmLogo.minY + 0.46165 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.85947 * realmLogo.width, y: realmLogo.minY + 0.41417 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.88653 * realmLogo.width, y: realmLogo.minY + 0.49792 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.88543 * realmLogo.width, y: realmLogo.minY + 0.41417 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.88653 * realmLogo.width, y: realmLogo.minY + 0.47087 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.88657 * realmLogo.width, y: realmLogo.minY + 0.74397 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.88660 * realmLogo.width, y: realmLogo.minY + 0.49870 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.88657 * realmLogo.width, y: realmLogo.minY + 0.74397 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.92584 * realmLogo.width, y: realmLogo.minY + 0.74397 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.92584 * realmLogo.width, y: realmLogo.minY + 0.50349 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.94604 * realmLogo.width, y: realmLogo.minY + 0.41468 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.92584 * realmLogo.width, y: realmLogo.minY + 0.44875 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.93552 * realmLogo.width, y: realmLogo.minY + 0.41468 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.96081 * realmLogo.width, y: realmLogo.minY + 0.50167 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.95885 * realmLogo.width, y: realmLogo.minY + 0.41468 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.96081 * realmLogo.width, y: realmLogo.minY + 0.45946 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.96089 * realmLogo.width, y: realmLogo.minY + 0.74397 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 1.00000 * realmLogo.width, y: realmLogo.minY + 0.74397 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 1.00000 * realmLogo.width, y: realmLogo.minY + 0.46302 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.95524 * realmLogo.width, y: realmLogo.minY + 0.29445 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 1.00000 * realmLogo.width, y: realmLogo.minY + 0.40688 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.99388 * realmLogo.width, y: realmLogo.minY + 0.29445 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.91760 * realmLogo.width, y: realmLogo.minY + 0.36205 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.93688 * realmLogo.width, y: realmLogo.minY + 0.29445 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.92623 * realmLogo.width, y: realmLogo.minY + 0.31360 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.88027 * realmLogo.width, y: realmLogo.minY + 0.29426 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.90954 * realmLogo.width, y: realmLogo.minY + 0.31646 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.89481 * realmLogo.width, y: realmLogo.minY + 0.29426 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.84189 * realmLogo.width, y: realmLogo.minY + 0.36829 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.86574 * realmLogo.width, y: realmLogo.minY + 0.29426 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.85000 * realmLogo.width, y: realmLogo.minY + 0.31842 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.83418 * realmLogo.width, y: realmLogo.minY + 0.30781 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.81271 * realmLogo.width, y: realmLogo.minY + 0.30781 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.81271 * realmLogo.width, y: realmLogo.minY + 0.74398 * realmLogo.height))
        realmTextPath.close()
        realmTextPath.move(to: CGPoint(x: realmLogo.minX + 0.51877 * realmLogo.width, y: realmLogo.minY + 0.47119 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.56496 * realmLogo.width, y: realmLogo.minY + 0.47119 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.54214 * realmLogo.width, y: realmLogo.minY + 0.39188 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.56386 * realmLogo.width, y: realmLogo.minY + 0.41262 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.55286 * realmLogo.width, y: realmLogo.minY + 0.39188 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.51877 * realmLogo.width, y: realmLogo.minY + 0.47119 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.53144 * realmLogo.width, y: realmLogo.minY + 0.39188 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.52008 * realmLogo.width, y: realmLogo.minY + 0.41926 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.51877 * realmLogo.width, y: realmLogo.minY + 0.47119 * realmLogo.height))
        realmTextPath.close()
        realmTextPath.move(to: CGPoint(x: realmLogo.minX + 0.55501 * realmLogo.width, y: realmLogo.minY + 0.64723 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.58540 * realmLogo.width, y: realmLogo.minY + 0.62187 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.57217 * realmLogo.width, y: realmLogo.minY + 0.64723 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.58540 * realmLogo.width, y: realmLogo.minY + 0.62187 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.59650 * realmLogo.width, y: realmLogo.minY + 0.71907 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.55052 * realmLogo.width, y: realmLogo.minY + 0.75303 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.59092 * realmLogo.width, y: realmLogo.minY + 0.72865 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.57246 * realmLogo.width, y: realmLogo.minY + 0.75303 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.47974 * realmLogo.width, y: realmLogo.minY + 0.52127 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.50002 * realmLogo.width, y: realmLogo.minY + 0.75303 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.47974 * realmLogo.width, y: realmLogo.minY + 0.64750 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.54292 * realmLogo.width, y: realmLogo.minY + 0.29362 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.47974 * realmLogo.width, y: realmLogo.minY + 0.40204 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.50246 * realmLogo.width, y: realmLogo.minY + 0.29362 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.60267 * realmLogo.width, y: realmLogo.minY + 0.56490 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.58268 * realmLogo.width, y: realmLogo.minY + 0.29362 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.60977 * realmLogo.width, y: realmLogo.minY + 0.39778 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.51824 * realmLogo.width, y: realmLogo.minY + 0.56490 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.55501 * realmLogo.width, y: realmLogo.minY + 0.64723 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.52008 * realmLogo.width, y: realmLogo.minY + 0.62442 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.53645 * realmLogo.width, y: realmLogo.minY + 0.64723 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.55501 * realmLogo.width, y: realmLogo.minY + 0.64723 * realmLogo.height))
        realmTextPath.close()
        realmTextPath.move(to: CGPoint(x: realmLogo.minX + 0.64961 * realmLogo.width, y: realmLogo.minY + 0.61293 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.67746 * realmLogo.width, y: realmLogo.minY + 0.64940 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.64961 * realmLogo.width, y: realmLogo.minY + 0.64252 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.66477 * realmLogo.width, y: realmLogo.minY + 0.67080 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.68880 * realmLogo.width, y: realmLogo.minY + 0.54969 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.68983 * realmLogo.width, y: realmLogo.minY + 0.62853 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.68880 * realmLogo.width, y: realmLogo.minY + 0.59586 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.64961 * realmLogo.width, y: realmLogo.minY + 0.61293 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.66538 * realmLogo.width, y: realmLogo.minY + 0.54969 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.64961 * realmLogo.width, y: realmLogo.minY + 0.57639 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.64961 * realmLogo.width, y: realmLogo.minY + 0.61293 * realmLogo.height))
        realmTextPath.close()
        realmTextPath.move(to: CGPoint(x: realmLogo.minX + 0.70615 * realmLogo.width, y: realmLogo.minY + 0.74419 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.69784 * realmLogo.width, y: realmLogo.minY + 0.69325 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.65710 * realmLogo.width, y: realmLogo.minY + 0.75680 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.69386 * realmLogo.width, y: realmLogo.minY + 0.71167 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.68092 * realmLogo.width, y: realmLogo.minY + 0.75680 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.61076 * realmLogo.width, y: realmLogo.minY + 0.62881 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.63073 * realmLogo.width, y: realmLogo.minY + 0.75680 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.61076 * realmLogo.width, y: realmLogo.minY + 0.69780 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.68889 * realmLogo.width, y: realmLogo.minY + 0.46621 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.61076 * realmLogo.width, y: realmLogo.minY + 0.55874 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.62621 * realmLogo.width, y: realmLogo.minY + 0.46621 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.66264 * realmLogo.width, y: realmLogo.minY + 0.40241 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.68889 * realmLogo.width, y: realmLogo.minY + 0.41971 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.67612 * realmLogo.width, y: realmLogo.minY + 0.40241 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.62510 * realmLogo.width, y: realmLogo.minY + 0.45348 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.65231 * realmLogo.width, y: realmLogo.minY + 0.40241 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.63763 * realmLogo.width, y: realmLogo.minY + 0.41615 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.61317 * realmLogo.width, y: realmLogo.minY + 0.34750 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.66871 * realmLogo.width, y: realmLogo.minY + 0.29000 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.62141 * realmLogo.width, y: realmLogo.minY + 0.33135 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.64041 * realmLogo.width, y: realmLogo.minY + 0.29000 * realmLogo.height))
        realmTextPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.72811 * realmLogo.width, y: realmLogo.minY + 0.49990 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.71088 * realmLogo.width, y: realmLogo.minY + 0.29000 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.72811 * realmLogo.width, y: realmLogo.minY + 0.37038 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.72811 * realmLogo.width, y: realmLogo.minY + 0.74422 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.70615 * realmLogo.width, y: realmLogo.minY + 0.74422 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.70615 * realmLogo.width, y: realmLogo.minY + 0.74419 * realmLogo.height))
        realmTextPath.addLine(to: CGPoint(x: realmLogo.minX + 0.70615 * realmLogo.width, y: realmLogo.minY + 0.74419 * realmLogo.height))
        realmTextPath.close()
        realmTextPath.usesEvenOddFillRule = true
        if textTintColor != nil {
            textTintColor!.setFill()
        }
        else {
            fillColor9.setFill()
        }
        realmTextPath.fill()
    }
    
    private func drawMonochromeLogo(frame: CGRect, tintColor: UIColor? = .white, strokeWidth: CGFloat = 8.0) {
        //// Color Declarations
        let strokeColor: UIColor = (tintColor != nil) ? tintColor! : .white
        
        //// Subframes
        let group2: CGRect = CGRect(x: frame.minX + 8, y: frame.minY + 8, width: frame.width - 16, height: frame.height - 16)
        
        
        //// Group 2
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: group2.minX + 0.50000 * group2.width, y: group2.minY + 0.00000 * group2.height))
        bezierPath.addCurve(to: CGPoint(x: group2.minX + 0.14650 * group2.width, y: group2.minY + 0.14650 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.36917 * group2.width, y: group2.minY + 0.00000 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.23900 * group2.width, y: group2.minY + 0.05383 * group2.height))
        bezierPath.addCurve(to: CGPoint(x: group2.minX + 0.00000 * group2.width, y: group2.minY + 0.50000 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.05400 * group2.width, y: group2.minY + 0.23917 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.00000 * group2.width, y: group2.minY + 0.36917 * group2.height))
        bezierPath.addCurve(to: CGPoint(x: group2.minX + 0.14650 * group2.width, y: group2.minY + 0.85350 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.00000 * group2.width, y: group2.minY + 0.63083 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.05383 * group2.width, y: group2.minY + 0.76100 * group2.height))
        bezierPath.addCurve(to: CGPoint(x: group2.minX + 0.50000 * group2.width, y: group2.minY + 1.00000 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.23917 * group2.width, y: group2.minY + 0.94600 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.36917 * group2.width, y: group2.minY + 1.00000 * group2.height))
        bezierPath.addCurve(to: CGPoint(x: group2.minX + 0.85350 * group2.width, y: group2.minY + 0.85350 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.63083 * group2.width, y: group2.minY + 1.00000 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.76100 * group2.width, y: group2.minY + 0.94617 * group2.height))
        bezierPath.addCurve(to: CGPoint(x: group2.minX + 1.00000 * group2.width, y: group2.minY + 0.50000 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.94617 * group2.width, y: group2.minY + 0.76100 * group2.height), controlPoint2: CGPoint(x: group2.minX + 1.00000 * group2.width, y: group2.minY + 0.63083 * group2.height))
        bezierPath.addCurve(to: CGPoint(x: group2.minX + 0.85350 * group2.width, y: group2.minY + 0.14650 * group2.height), controlPoint1: CGPoint(x: group2.minX + 1.00000 * group2.width, y: group2.minY + 0.36917 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.94617 * group2.width, y: group2.minY + 0.23900 * group2.height))
        bezierPath.addCurve(to: CGPoint(x: group2.minX + 0.50000 * group2.width, y: group2.minY + 0.00000 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.76100 * group2.width, y: group2.minY + 0.05383 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.63083 * group2.width, y: group2.minY + 0.00000 * group2.height))
        bezierPath.addLine(to: CGPoint(x: group2.minX + 0.50000 * group2.width, y: group2.minY + 0.00000 * group2.height))
        bezierPath.close()
        strokeColor.setStroke()
        bezierPath.lineWidth = strokeWidth
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: group2.minX + 0.71417 * group2.width, y: group2.minY + 0.04883 * group2.height))
        bezier2Path.addCurve(to: CGPoint(x: group2.minX + 0.58883 * group2.width, y: group2.minY + 0.05817 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.67217 * group2.width, y: group2.minY + 0.04533 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.62983 * group2.width, y: group2.minY + 0.04833 * group2.height))
        bezier2Path.addCurve(to: CGPoint(x: group2.minX + 0.32350 * group2.width, y: group2.minY + 0.14983 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.49767 * group2.width, y: group2.minY + 0.07983 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.41567 * group2.width, y: group2.minY + 0.13300 * group2.height))
        bezier2Path.addCurve(to: CGPoint(x: group2.minX + 0.15417 * group2.width, y: group2.minY + 0.13900 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.26733 * group2.width, y: group2.minY + 0.16017 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.20867 * group2.width, y: group2.minY + 0.15617 * group2.height))
        strokeColor.setStroke()
        bezier2Path.lineWidth = strokeWidth
        bezier2Path.stroke()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: group2.minX + 0.89100 * group2.width, y: group2.minY + 0.18850 * group2.height))
        bezier3Path.addCurve(to: CGPoint(x: group2.minX + 0.64900 * group2.width, y: group2.minY + 0.26183 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.81867 * group2.width, y: group2.minY + 0.23367 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.73433 * group2.width, y: group2.minY + 0.25967 * group2.height))
        bezier3Path.addCurve(to: CGPoint(x: group2.minX + 0.30867 * group2.width, y: group2.minY + 0.22550 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.53483 * group2.width, y: group2.minY + 0.26467 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.42283 * group2.width, y: group2.minY + 0.22667 * group2.height))
        bezier3Path.addCurve(to: CGPoint(x: group2.minX + 0.04550 * group2.width, y: group2.minY + 0.29283 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.21700 * group2.width, y: group2.minY + 0.22450 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.12567 * group2.width, y: group2.minY + 0.24867 * group2.height))
        strokeColor.setStroke()
        bezier3Path.lineWidth = strokeWidth
        bezier3Path.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: group2.minX + 0.09912 * group2.width, y: group2.minY + 0.43820 * group2.height))
        bezier4Path.addCurve(to: CGPoint(x: group2.minX + 0.01067 * group2.width, y: group2.minY + 0.39833 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.06808 * group2.width, y: group2.minY + 0.42882 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.03824 * group2.width, y: group2.minY + 0.41539 * group2.height))
        strokeColor.setStroke()
        bezier4Path.lineWidth = strokeWidth
        bezier4Path.stroke()
        
        
        //// Bezier 5 Drawing
        let bezier5Path = UIBezierPath()
        bezier5Path.move(to: CGPoint(x: group2.minX + 0.99317 * group2.width, y: group2.minY + 0.41950 * group2.height))
        bezier5Path.addCurve(to: CGPoint(x: group2.minX + 0.87550 * group2.width, y: group2.minY + 0.35150 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.95750 * group2.width, y: group2.minY + 0.39133 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.91783 * group2.width, y: group2.minY + 0.36817 * group2.height))
        bezier5Path.addCurve(to: CGPoint(x: group2.minX + 0.60067 * group2.width, y: group2.minY + 0.33100 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.78867 * group2.width, y: group2.minY + 0.31733 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.69150 * group2.width, y: group2.minY + 0.31000 * group2.height))
        bezier5Path.addCurve(to: CGPoint(x: group2.minX + 0.42217 * group2.width, y: group2.minY + 0.39683 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.53883 * group2.width, y: group2.minY + 0.34533 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.48067 * group2.width, y: group2.minY + 0.37200 * group2.height))
        bezier5Path.addCurve(to: CGPoint(x: group2.minX + 0.35147 * group2.width, y: group2.minY + 0.42484 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.39887 * group2.width, y: group2.minY + 0.40672 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.37534 * group2.width, y: group2.minY + 0.41637 * group2.height))
        strokeColor.setStroke()
        bezier5Path.lineWidth = strokeWidth
        bezier5Path.stroke()
        
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.move(to: CGPoint(x: group2.minX + 0.64251 * group2.width, y: group2.minY + 0.53720 * group2.height))
        bezier6Path.addCurve(to: CGPoint(x: group2.minX + 0.48483 * group2.width, y: group2.minY + 0.47317 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.58867 * group2.width, y: group2.minY + 0.51975 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.53691 * group2.width, y: group2.minY + 0.49560 * group2.height))
        bezier6Path.addCurve(to: CGPoint(x: group2.minX + 0.28233 * group2.width, y: group2.minY + 0.41217 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.41983 * group2.width, y: group2.minY + 0.44517 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.35267 * group2.width, y: group2.minY + 0.41917 * group2.height))
        bezier6Path.addCurve(to: CGPoint(x: group2.minX + 0.07383 * group2.width, y: group2.minY + 0.44933 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.21117 * group2.width, y: group2.minY + 0.40517 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.13817 * group2.width, y: group2.minY + 0.41817 * group2.height))
        bezier6Path.addCurve(to: CGPoint(x: group2.minX + 0.00000 * group2.width, y: group2.minY + 0.49617 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.04750 * group2.width, y: group2.minY + 0.46200 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.02283 * group2.width, y: group2.minY + 0.47783 * group2.height))
        strokeColor.setStroke()
        bezier6Path.lineWidth = strokeWidth
        bezier6Path.stroke()
        
        
        //// Bezier 7 Drawing
        let bezier7Path = UIBezierPath()
        bezier7Path.move(to: CGPoint(x: group2.minX + 0.99983 * group2.width, y: group2.minY + 0.50933 * group2.height))
        bezier7Path.addCurve(to: CGPoint(x: group2.minX + 0.73683 * group2.width, y: group2.minY + 0.50000 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.91583 * group2.width, y: group2.minY + 0.47950 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.82250 * group2.width, y: group2.minY + 0.47550 * group2.height))
        bezier7Path.addCurve(to: CGPoint(x: group2.minX + 0.42870 * group2.width, y: group2.minY + 0.64865 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.62695 * group2.width, y: group2.minY + 0.53128 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.53404 * group2.width, y: group2.minY + 0.60456 * group2.height))
        strokeColor.setStroke()
        bezier7Path.lineWidth = strokeWidth
        bezier7Path.stroke()
        
        
        //// Bezier 8 Drawing
        let bezier8Path = UIBezierPath()
        bezier8Path.move(to: CGPoint(x: group2.minX + 0.98133 * group2.width, y: group2.minY + 0.63333 * group2.height))
        bezier8Path.addCurve(to: CGPoint(x: group2.minX + 0.87117 * group2.width, y: group2.minY + 0.69000 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.94717 * group2.width, y: group2.minY + 0.65683 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.91017 * group2.width, y: group2.minY + 0.67583 * group2.height))
        bezier8Path.addCurve(to: CGPoint(x: group2.minX + 0.60117 * group2.width, y: group2.minY + 0.70750 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.78517 * group2.width, y: group2.minY + 0.72100 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.69050 * group2.width, y: group2.minY + 0.72717 * group2.height))
        bezier8Path.addCurve(to: CGPoint(x: group2.minX + 0.27783 * group2.width, y: group2.minY + 0.60533 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.49050 * group2.width, y: group2.minY + 0.68317 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.39000 * group2.width, y: group2.minY + 0.62067 * group2.height))
        bezier8Path.addCurve(to: CGPoint(x: group2.minX + 0.02517 * group2.width, y: group2.minY + 0.65550 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.19117 * group2.width, y: group2.minY + 0.59350 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.10100 * group2.width, y: group2.minY + 0.61217 * group2.height))
        strokeColor.setStroke()
        bezier8Path.lineWidth = strokeWidth
        bezier8Path.stroke()
        
        
        //// Bezier 9 Drawing
        let bezier9Path = UIBezierPath()
        bezier9Path.move(to: CGPoint(x: group2.minX + 0.93367 * group2.width, y: group2.minY + 0.74800 * group2.height))
        bezier9Path.addCurve(to: CGPoint(x: group2.minX + 0.60633 * group2.width, y: group2.minY + 0.78683 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.82350 * group2.width, y: group2.minY + 0.73617 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.71050 * group2.width, y: group2.minY + 0.74933 * group2.height))
        bezier9Path.addCurve(to: CGPoint(x: group2.minX + 0.44417 * group2.width, y: group2.minY + 0.84883 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.55183 * group2.width, y: group2.minY + 0.80650 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.49967 * group2.width, y: group2.minY + 0.83250 * group2.height))
        bezier9Path.addCurve(to: CGPoint(x: group2.minX + 0.17650 * group2.width, y: group2.minY + 0.85100 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.35750 * group2.width, y: group2.minY + 0.87433 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.26367 * group2.width, y: group2.minY + 0.87500 * group2.height))
        bezier9Path.addCurve(to: CGPoint(x: group2.minX + 0.12917 * group2.width, y: group2.minY + 0.83533 * group2.height), controlPoint1: CGPoint(x: group2.minX + 0.16050 * group2.width, y: group2.minY + 0.84650 * group2.height), controlPoint2: CGPoint(x: group2.minX + 0.14467 * group2.width, y: group2.minY + 0.84133 * group2.height))
        strokeColor.setStroke()
        bezier9Path.lineWidth = strokeWidth
        bezier9Path.stroke()
    }
    
    private func drawMonochromeLogoAndWordmark(frame: CGRect, tintColor: UIColor = .white, strokeWidth: CGFloat = 8.0) {
        
        //// Subframes
        let realmLogo: CGRect = CGRect(x: frame.minX + 7.77, y: frame.minY + 8, width: frame.width - 13.2, height: frame.height - 17)
        
        
        //// realmLogo
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: realmLogo.minX + 0.15927 * realmLogo.width, y: realmLogo.minY + 0.00000 * realmLogo.height))
        bezierPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.04667 * realmLogo.width, y: realmLogo.minY + 0.14650 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.11759 * realmLogo.width, y: realmLogo.minY + 0.00000 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.07613 * realmLogo.width, y: realmLogo.minY + 0.05383 * realmLogo.height))
        bezierPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.00000 * realmLogo.width, y: realmLogo.minY + 0.50000 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.01720 * realmLogo.width, y: realmLogo.minY + 0.23917 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.00000 * realmLogo.width, y: realmLogo.minY + 0.36917 * realmLogo.height))
        bezierPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.04667 * realmLogo.width, y: realmLogo.minY + 0.85350 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.00000 * realmLogo.width, y: realmLogo.minY + 0.63083 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.01715 * realmLogo.width, y: realmLogo.minY + 0.76100 * realmLogo.height))
        bezierPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.15927 * realmLogo.width, y: realmLogo.minY + 1.00000 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.07618 * realmLogo.width, y: realmLogo.minY + 0.94600 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.11759 * realmLogo.width, y: realmLogo.minY + 1.00000 * realmLogo.height))
        bezierPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.27187 * realmLogo.width, y: realmLogo.minY + 0.85350 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.20095 * realmLogo.width, y: realmLogo.minY + 1.00000 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.24241 * realmLogo.width, y: realmLogo.minY + 0.94617 * realmLogo.height))
        bezierPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.31854 * realmLogo.width, y: realmLogo.minY + 0.50000 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.30139 * realmLogo.width, y: realmLogo.minY + 0.76100 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.31854 * realmLogo.width, y: realmLogo.minY + 0.63083 * realmLogo.height))
        bezierPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.27187 * realmLogo.width, y: realmLogo.minY + 0.14650 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.31854 * realmLogo.width, y: realmLogo.minY + 0.36917 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.30139 * realmLogo.width, y: realmLogo.minY + 0.23900 * realmLogo.height))
        bezierPath.addCurve(to: CGPoint(x: realmLogo.minX + 0.15927 * realmLogo.width, y: realmLogo.minY + 0.00000 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.24241 * realmLogo.width, y: realmLogo.minY + 0.05383 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.20095 * realmLogo.width, y: realmLogo.minY + 0.00000 * realmLogo.height))
        bezierPath.addLine(to: CGPoint(x: realmLogo.minX + 0.15927 * realmLogo.width, y: realmLogo.minY + 0.00000 * realmLogo.height))
        bezierPath.close()
        tintColor.setStroke()
        bezierPath.lineWidth = strokeWidth
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: realmLogo.minX + 0.22749 * realmLogo.width, y: realmLogo.minY + 0.04883 * realmLogo.height))
        bezier2Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.18757 * realmLogo.width, y: realmLogo.minY + 0.05817 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.21411 * realmLogo.width, y: realmLogo.minY + 0.04533 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.20063 * realmLogo.width, y: realmLogo.minY + 0.04833 * realmLogo.height))
        bezier2Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.10305 * realmLogo.width, y: realmLogo.minY + 0.14983 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.15853 * realmLogo.width, y: realmLogo.minY + 0.07983 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.13241 * realmLogo.width, y: realmLogo.minY + 0.13300 * realmLogo.height))
        bezier2Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.04911 * realmLogo.width, y: realmLogo.minY + 0.13900 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.08516 * realmLogo.width, y: realmLogo.minY + 0.16017 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.06647 * realmLogo.width, y: realmLogo.minY + 0.15617 * realmLogo.height))
        tintColor.setStroke()
        bezier2Path.lineWidth = strokeWidth
        bezier2Path.stroke()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: realmLogo.minX + 0.28382 * realmLogo.width, y: realmLogo.minY + 0.18850 * realmLogo.height))
        bezier3Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.20673 * realmLogo.width, y: realmLogo.minY + 0.26183 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.26078 * realmLogo.width, y: realmLogo.minY + 0.23367 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.23391 * realmLogo.width, y: realmLogo.minY + 0.25967 * realmLogo.height))
        bezier3Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.09832 * realmLogo.width, y: realmLogo.minY + 0.22550 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.17037 * realmLogo.width, y: realmLogo.minY + 0.26467 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.13469 * realmLogo.width, y: realmLogo.minY + 0.22667 * realmLogo.height))
        bezier3Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.01449 * realmLogo.width, y: realmLogo.minY + 0.29283 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.06912 * realmLogo.width, y: realmLogo.minY + 0.22450 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.04003 * realmLogo.width, y: realmLogo.minY + 0.24867 * realmLogo.height))
        tintColor.setStroke()
        bezier3Path.lineWidth = strokeWidth
        bezier3Path.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: realmLogo.minX + 0.03157 * realmLogo.width, y: realmLogo.minY + 0.43820 * realmLogo.height))
        bezier4Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.00340 * realmLogo.width, y: realmLogo.minY + 0.39833 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.02169 * realmLogo.width, y: realmLogo.minY + 0.42882 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.01218 * realmLogo.width, y: realmLogo.minY + 0.41539 * realmLogo.height))
        tintColor.setStroke()
        bezier4Path.lineWidth = strokeWidth
        bezier4Path.stroke()
        
        
        //// Bezier 5 Drawing
        let bezier5Path = UIBezierPath()
        bezier5Path.move(to: CGPoint(x: realmLogo.minX + 0.31636 * realmLogo.width, y: realmLogo.minY + 0.41950 * realmLogo.height))
        bezier5Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.27888 * realmLogo.width, y: realmLogo.minY + 0.35150 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.30500 * realmLogo.width, y: realmLogo.minY + 0.39133 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.29237 * realmLogo.width, y: realmLogo.minY + 0.36817 * realmLogo.height))
        bezier5Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.19134 * realmLogo.width, y: realmLogo.minY + 0.33100 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.25122 * realmLogo.width, y: realmLogo.minY + 0.31733 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.22027 * realmLogo.width, y: realmLogo.minY + 0.31000 * realmLogo.height))
        bezier5Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.13448 * realmLogo.width, y: realmLogo.minY + 0.39683 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.17164 * realmLogo.width, y: realmLogo.minY + 0.34533 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.15311 * realmLogo.width, y: realmLogo.minY + 0.37200 * realmLogo.height))
        bezier5Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.11196 * realmLogo.width, y: realmLogo.minY + 0.42484 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.12706 * realmLogo.width, y: realmLogo.minY + 0.40672 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.11956 * realmLogo.width, y: realmLogo.minY + 0.41637 * realmLogo.height))
        tintColor.setStroke()
        bezier5Path.lineWidth = strokeWidth
        bezier5Path.stroke()
        
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.move(to: CGPoint(x: realmLogo.minX + 0.20466 * realmLogo.width, y: realmLogo.minY + 0.53720 * realmLogo.height))
        bezier6Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.15444 * realmLogo.width, y: realmLogo.minY + 0.47317 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.18752 * realmLogo.width, y: realmLogo.minY + 0.51975 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.17103 * realmLogo.width, y: realmLogo.minY + 0.49560 * realmLogo.height))
        bezier6Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.08993 * realmLogo.width, y: realmLogo.minY + 0.41217 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.13373 * realmLogo.width, y: realmLogo.minY + 0.44517 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.11234 * realmLogo.width, y: realmLogo.minY + 0.41917 * realmLogo.height))
        bezier6Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.02352 * realmLogo.width, y: realmLogo.minY + 0.44933 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.06727 * realmLogo.width, y: realmLogo.minY + 0.40517 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.04401 * realmLogo.width, y: realmLogo.minY + 0.41817 * realmLogo.height))
        bezier6Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.00000 * realmLogo.width, y: realmLogo.minY + 0.49617 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.01513 * realmLogo.width, y: realmLogo.minY + 0.46200 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.00727 * realmLogo.width, y: realmLogo.minY + 0.47783 * realmLogo.height))
        tintColor.setStroke()
        bezier6Path.lineWidth = strokeWidth
        bezier6Path.stroke()
        
        
        //// Bezier 7 Drawing
        let bezier7Path = UIBezierPath()
        bezier7Path.move(to: CGPoint(x: realmLogo.minX + 0.31849 * realmLogo.width, y: realmLogo.minY + 0.50933 * realmLogo.height))
        bezier7Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.23471 * realmLogo.width, y: realmLogo.minY + 0.50000 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.29173 * realmLogo.width, y: realmLogo.minY + 0.47950 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.26200 * realmLogo.width, y: realmLogo.minY + 0.47550 * realmLogo.height))
        bezier7Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.13656 * realmLogo.width, y: realmLogo.minY + 0.64865 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.19971 * realmLogo.width, y: realmLogo.minY + 0.53128 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.17011 * realmLogo.width, y: realmLogo.minY + 0.60456 * realmLogo.height))
        tintColor.setStroke()
        bezier7Path.lineWidth = strokeWidth
        bezier7Path.stroke()
        
        
        //// Bezier 8 Drawing
        let bezier8Path = UIBezierPath()
        bezier8Path.move(to: CGPoint(x: realmLogo.minX + 0.31259 * realmLogo.width, y: realmLogo.minY + 0.63333 * realmLogo.height))
        bezier8Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.27750 * realmLogo.width, y: realmLogo.minY + 0.69000 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.30171 * realmLogo.width, y: realmLogo.minY + 0.65683 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.28993 * realmLogo.width, y: realmLogo.minY + 0.67583 * realmLogo.height))
        bezier8Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.19150 * realmLogo.width, y: realmLogo.minY + 0.70750 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.25011 * realmLogo.width, y: realmLogo.minY + 0.72100 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.21995 * realmLogo.width, y: realmLogo.minY + 0.72717 * realmLogo.height))
        bezier8Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.08850 * realmLogo.width, y: realmLogo.minY + 0.60533 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.15624 * realmLogo.width, y: realmLogo.minY + 0.68317 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.12423 * realmLogo.width, y: realmLogo.minY + 0.62067 * realmLogo.height))
        bezier8Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.00802 * realmLogo.width, y: realmLogo.minY + 0.65550 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.06089 * realmLogo.width, y: realmLogo.minY + 0.59350 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.03217 * realmLogo.width, y: realmLogo.minY + 0.61217 * realmLogo.height))
        tintColor.setStroke()
        bezier8Path.lineWidth = strokeWidth
        bezier8Path.stroke()
        
        
        //// Bezier 9 Drawing
        let bezier9Path = UIBezierPath()
        bezier9Path.move(to: CGPoint(x: realmLogo.minX + 0.29741 * realmLogo.width, y: realmLogo.minY + 0.74800 * realmLogo.height))
        bezier9Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.19314 * realmLogo.width, y: realmLogo.minY + 0.78683 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.26232 * realmLogo.width, y: realmLogo.minY + 0.73617 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.22632 * realmLogo.width, y: realmLogo.minY + 0.74933 * realmLogo.height))
        bezier9Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.14149 * realmLogo.width, y: realmLogo.minY + 0.84883 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.17578 * realmLogo.width, y: realmLogo.minY + 0.80650 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.15916 * realmLogo.width, y: realmLogo.minY + 0.83250 * realmLogo.height))
        bezier9Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.05622 * realmLogo.width, y: realmLogo.minY + 0.85100 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.11388 * realmLogo.width, y: realmLogo.minY + 0.87433 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.08399 * realmLogo.width, y: realmLogo.minY + 0.87500 * realmLogo.height))
        bezier9Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.04114 * realmLogo.width, y: realmLogo.minY + 0.83533 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.05113 * realmLogo.width, y: realmLogo.minY + 0.84650 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.04608 * realmLogo.width, y: realmLogo.minY + 0.84133 * realmLogo.height))
        tintColor.setStroke()
        bezier9Path.lineWidth = strokeWidth
        bezier9Path.stroke()
        
        
        //// Bezier 10 Drawing
        let bezier10Path = UIBezierPath()
        bezier10Path.move(to: CGPoint(x: realmLogo.minX + 0.75063 * realmLogo.width, y: realmLogo.minY + 0.15680 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.79042 * realmLogo.width, y: realmLogo.minY + 0.15680 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.79042 * realmLogo.width, y: realmLogo.minY + 0.74429 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.75063 * realmLogo.width, y: realmLogo.minY + 0.74429 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.75063 * realmLogo.width, y: realmLogo.minY + 0.15680 * realmLogo.height))
        bezier10Path.close()
        bezier10Path.move(to: CGPoint(x: realmLogo.minX + 0.39287 * realmLogo.width, y: realmLogo.minY + 0.74398 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.43213 * realmLogo.width, y: realmLogo.minY + 0.74398 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.43213 * realmLogo.width, y: realmLogo.minY + 0.50167 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.44823 * realmLogo.width, y: realmLogo.minY + 0.41202 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.43213 * realmLogo.width, y: realmLogo.minY + 0.46165 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.43527 * realmLogo.width, y: realmLogo.minY + 0.41202 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.46410 * realmLogo.width, y: realmLogo.minY + 0.42965 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.45418 * realmLogo.width, y: realmLogo.minY + 0.41202 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.45933 * realmLogo.width, y: realmLogo.minY + 0.41698 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.47825 * realmLogo.width, y: realmLogo.minY + 0.32686 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.46426 * realmLogo.width, y: realmLogo.minY + 0.43013 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.47841 * realmLogo.width, y: realmLogo.minY + 0.32637 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.45358 * realmLogo.width, y: realmLogo.minY + 0.29546 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.46945 * realmLogo.width, y: realmLogo.minY + 0.30149 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.46028 * realmLogo.width, y: realmLogo.minY + 0.29546 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.42206 * realmLogo.width, y: realmLogo.minY + 0.36478 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.43905 * realmLogo.width, y: realmLogo.minY + 0.29546 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.42692 * realmLogo.width, y: realmLogo.minY + 0.32324 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.41435 * realmLogo.width, y: realmLogo.minY + 0.30778 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.39287 * realmLogo.width, y: realmLogo.minY + 0.30778 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.39287 * realmLogo.width, y: realmLogo.minY + 0.74398 * realmLogo.height))
        bezier10Path.close()
        bezier10Path.move(to: CGPoint(x: realmLogo.minX + 0.81271 * realmLogo.width, y: realmLogo.minY + 0.74398 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.85195 * realmLogo.width, y: realmLogo.minY + 0.74398 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.85195 * realmLogo.width, y: realmLogo.minY + 0.50167 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.87243 * realmLogo.width, y: realmLogo.minY + 0.41417 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.85195 * realmLogo.width, y: realmLogo.minY + 0.46165 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.85947 * realmLogo.width, y: realmLogo.minY + 0.41417 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.88653 * realmLogo.width, y: realmLogo.minY + 0.49792 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.88543 * realmLogo.width, y: realmLogo.minY + 0.41417 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.88653 * realmLogo.width, y: realmLogo.minY + 0.47087 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.88657 * realmLogo.width, y: realmLogo.minY + 0.74397 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.88660 * realmLogo.width, y: realmLogo.minY + 0.49870 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.88657 * realmLogo.width, y: realmLogo.minY + 0.74397 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.92584 * realmLogo.width, y: realmLogo.minY + 0.74397 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.92584 * realmLogo.width, y: realmLogo.minY + 0.50349 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.94604 * realmLogo.width, y: realmLogo.minY + 0.41468 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.92584 * realmLogo.width, y: realmLogo.minY + 0.44875 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.93552 * realmLogo.width, y: realmLogo.minY + 0.41468 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.96081 * realmLogo.width, y: realmLogo.minY + 0.50167 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.95885 * realmLogo.width, y: realmLogo.minY + 0.41468 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.96081 * realmLogo.width, y: realmLogo.minY + 0.45946 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.96089 * realmLogo.width, y: realmLogo.minY + 0.74397 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 1.00000 * realmLogo.width, y: realmLogo.minY + 0.74397 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 1.00000 * realmLogo.width, y: realmLogo.minY + 0.46302 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.95524 * realmLogo.width, y: realmLogo.minY + 0.29445 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 1.00000 * realmLogo.width, y: realmLogo.minY + 0.40688 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.99388 * realmLogo.width, y: realmLogo.minY + 0.29445 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.91760 * realmLogo.width, y: realmLogo.minY + 0.36205 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.93688 * realmLogo.width, y: realmLogo.minY + 0.29445 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.92623 * realmLogo.width, y: realmLogo.minY + 0.31360 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.88027 * realmLogo.width, y: realmLogo.minY + 0.29426 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.90954 * realmLogo.width, y: realmLogo.minY + 0.31646 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.89481 * realmLogo.width, y: realmLogo.minY + 0.29426 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.84189 * realmLogo.width, y: realmLogo.minY + 0.36829 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.86574 * realmLogo.width, y: realmLogo.minY + 0.29426 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.85000 * realmLogo.width, y: realmLogo.minY + 0.31842 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.83418 * realmLogo.width, y: realmLogo.minY + 0.30781 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.81271 * realmLogo.width, y: realmLogo.minY + 0.30781 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.81271 * realmLogo.width, y: realmLogo.minY + 0.74398 * realmLogo.height))
        bezier10Path.close()
        bezier10Path.move(to: CGPoint(x: realmLogo.minX + 0.51877 * realmLogo.width, y: realmLogo.minY + 0.47119 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.56496 * realmLogo.width, y: realmLogo.minY + 0.47119 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.54214 * realmLogo.width, y: realmLogo.minY + 0.39188 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.56386 * realmLogo.width, y: realmLogo.minY + 0.41262 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.55286 * realmLogo.width, y: realmLogo.minY + 0.39188 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.51877 * realmLogo.width, y: realmLogo.minY + 0.47119 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.53144 * realmLogo.width, y: realmLogo.minY + 0.39188 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.52008 * realmLogo.width, y: realmLogo.minY + 0.41926 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.51877 * realmLogo.width, y: realmLogo.minY + 0.47119 * realmLogo.height))
        bezier10Path.close()
        bezier10Path.move(to: CGPoint(x: realmLogo.minX + 0.55501 * realmLogo.width, y: realmLogo.minY + 0.64723 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.58540 * realmLogo.width, y: realmLogo.minY + 0.62187 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.57217 * realmLogo.width, y: realmLogo.minY + 0.64723 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.58540 * realmLogo.width, y: realmLogo.minY + 0.62187 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.59650 * realmLogo.width, y: realmLogo.minY + 0.71907 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.55052 * realmLogo.width, y: realmLogo.minY + 0.75303 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.59092 * realmLogo.width, y: realmLogo.minY + 0.72865 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.57246 * realmLogo.width, y: realmLogo.minY + 0.75303 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.47974 * realmLogo.width, y: realmLogo.minY + 0.52127 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.50002 * realmLogo.width, y: realmLogo.minY + 0.75303 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.47974 * realmLogo.width, y: realmLogo.minY + 0.64750 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.54292 * realmLogo.width, y: realmLogo.minY + 0.29362 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.47974 * realmLogo.width, y: realmLogo.minY + 0.40204 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.50246 * realmLogo.width, y: realmLogo.minY + 0.29362 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.60267 * realmLogo.width, y: realmLogo.minY + 0.56490 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.58268 * realmLogo.width, y: realmLogo.minY + 0.29362 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.60977 * realmLogo.width, y: realmLogo.minY + 0.39778 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.51824 * realmLogo.width, y: realmLogo.minY + 0.56490 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.55501 * realmLogo.width, y: realmLogo.minY + 0.64723 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.52008 * realmLogo.width, y: realmLogo.minY + 0.62442 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.53645 * realmLogo.width, y: realmLogo.minY + 0.64723 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.55501 * realmLogo.width, y: realmLogo.minY + 0.64723 * realmLogo.height))
        bezier10Path.close()
        bezier10Path.move(to: CGPoint(x: realmLogo.minX + 0.64961 * realmLogo.width, y: realmLogo.minY + 0.61293 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.67746 * realmLogo.width, y: realmLogo.minY + 0.64940 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.64961 * realmLogo.width, y: realmLogo.minY + 0.64252 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.66477 * realmLogo.width, y: realmLogo.minY + 0.67080 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.68880 * realmLogo.width, y: realmLogo.minY + 0.54969 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.68983 * realmLogo.width, y: realmLogo.minY + 0.62853 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.68880 * realmLogo.width, y: realmLogo.minY + 0.59586 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.64961 * realmLogo.width, y: realmLogo.minY + 0.61293 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.66538 * realmLogo.width, y: realmLogo.minY + 0.54969 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.64961 * realmLogo.width, y: realmLogo.minY + 0.57639 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.64961 * realmLogo.width, y: realmLogo.minY + 0.61293 * realmLogo.height))
        bezier10Path.close()
        bezier10Path.move(to: CGPoint(x: realmLogo.minX + 0.70615 * realmLogo.width, y: realmLogo.minY + 0.74419 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.69784 * realmLogo.width, y: realmLogo.minY + 0.69325 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.65710 * realmLogo.width, y: realmLogo.minY + 0.75680 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.69386 * realmLogo.width, y: realmLogo.minY + 0.71167 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.68092 * realmLogo.width, y: realmLogo.minY + 0.75680 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.61076 * realmLogo.width, y: realmLogo.minY + 0.62881 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.63073 * realmLogo.width, y: realmLogo.minY + 0.75680 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.61076 * realmLogo.width, y: realmLogo.minY + 0.69780 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.68889 * realmLogo.width, y: realmLogo.minY + 0.46621 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.61076 * realmLogo.width, y: realmLogo.minY + 0.55874 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.62621 * realmLogo.width, y: realmLogo.minY + 0.46621 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.66264 * realmLogo.width, y: realmLogo.minY + 0.40241 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.68889 * realmLogo.width, y: realmLogo.minY + 0.41971 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.67612 * realmLogo.width, y: realmLogo.minY + 0.40241 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.62510 * realmLogo.width, y: realmLogo.minY + 0.45348 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.65231 * realmLogo.width, y: realmLogo.minY + 0.40241 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.63763 * realmLogo.width, y: realmLogo.minY + 0.41615 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.61317 * realmLogo.width, y: realmLogo.minY + 0.34750 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.66871 * realmLogo.width, y: realmLogo.minY + 0.29000 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.62141 * realmLogo.width, y: realmLogo.minY + 0.33136 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.64041 * realmLogo.width, y: realmLogo.minY + 0.29000 * realmLogo.height))
        bezier10Path.addCurve(to: CGPoint(x: realmLogo.minX + 0.72811 * realmLogo.width, y: realmLogo.minY + 0.49990 * realmLogo.height), controlPoint1: CGPoint(x: realmLogo.minX + 0.71088 * realmLogo.width, y: realmLogo.minY + 0.29000 * realmLogo.height), controlPoint2: CGPoint(x: realmLogo.minX + 0.72811 * realmLogo.width, y: realmLogo.minY + 0.37038 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.72811 * realmLogo.width, y: realmLogo.minY + 0.74422 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.70615 * realmLogo.width, y: realmLogo.minY + 0.74422 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.70615 * realmLogo.width, y: realmLogo.minY + 0.74419 * realmLogo.height))
        bezier10Path.addLine(to: CGPoint(x: realmLogo.minX + 0.70615 * realmLogo.width, y: realmLogo.minY + 0.74419 * realmLogo.height))
        bezier10Path.close()
        bezier10Path.usesEvenOddFillRule = true
        tintColor.setFill()
        bezier10Path.fill()
    }
}
