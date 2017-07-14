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
