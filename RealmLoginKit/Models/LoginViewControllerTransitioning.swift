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

class LoginViewControllerTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    public var isDismissing = false
    
    public var contentView: UIView? = nil
    public var effectsView: UIVisualEffectView? = nil
    public var backgroundView: UIView? = nil
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = self.transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        
        let keyName = isDismissing ? UITransitionContextViewControllerKey.from : UITransitionContextViewControllerKey.to
        let viewController = transitionContext.viewController(forKey: keyName)
        
        // Hold onto a reference to the effect
        let effect = effectsView?.effect
        
        // Size the controller to full screen
        viewController?.view.frame = containerView.bounds
        
        // set up the initial animation state
        contentView?.frame.origin.y = !isDismissing ? containerView.frame.maxY : containerView.bounds.minY
        backgroundView?.alpha = !isDismissing ? 0.0 : 1.0
        effectsView?.effect = !isDismissing ? nil : effect
        
        if !isDismissing {
            containerView.addSubview(viewController!.view)
        }
        
        // perform the animation
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: [], animations: {
            self.contentView?.frame.origin.y = !self.isDismissing ? containerView.bounds.minY : containerView.bounds.maxY
            self.backgroundView?.alpha = !self.isDismissing ? 1.0 : 0.0
            self.effectsView?.effect = !self.isDismissing ? effect : nil
        }) { complete in
            if self.isDismissing {
                viewController?.view.removeFromSuperview()
            }
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
