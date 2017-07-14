//
//  StatusBarUnderlayView.swift
//  Pods-RealmLoginKit
//
//  Created by Tim Oliver on 7/14/17.
//

import UIKit

enum StatusBarUnderlayStyle {
    case light
    case dark
}

class StatusBarUnderlayView: UIVisualEffectView {

    public var style: StatusBarUnderlayStyle = .light {
        didSet { configure(for: self.style) }
    }

    let separatorView = UIView()

    init(style: StatusBarUnderlayStyle) {
        super.init(effect: UIBlurEffect(style: .light))
        self.style = style
        setUpSubviews()
    }

    init() {
        super.init(effect: UIBlurEffect(style: .light))
        self.style = .light
        setUpSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpSubviews() {
        contentView.addSubview(separatorView)
        configure(for: style)
    }

    private func configure(for style: StatusBarUnderlayStyle) {
        let darkMode = (style == .dark)

        // Configure the style of the translucency view
        let blurEffect = darkMode ? UIBlurEffectStyle.dark : UIBlurEffectStyle.light
        self.effect = UIBlurEffect(style: blurEffect)

        // Configure the shade of white of the separator line
        let whiteShade = darkMode ? 1.0 : 0.0
        let whiteAlpha = darkMode ? 0.3 : 0.2
        separatorView.backgroundColor = UIColor(white: CGFloat(whiteShade), alpha: CGFloat(whiteAlpha))
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        let lineHeight = 1.0 / UIScreen.main.scale

        var frame = bounds
        frame.origin.y = frame.size.height - lineHeight
        frame.size.height = lineHeight
        separatorView.frame = frame
    }
}
