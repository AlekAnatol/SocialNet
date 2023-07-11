//
//  CustomPresentAnimator.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 11.07.2023.
//

import UIKit

class CustomPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let startFrame: CGRect

    init(startFrame: CGRect) {
        self.startFrame = startFrame
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let vcTo = transitionContext.viewController(forKey: .to),
              let snapshot = vcTo.view.snapshotView(afterScreenUpdates: true)
        else { return }

        let vcContainer = transitionContext.containerView

        vcTo.view.isHidden = true
        vcContainer.addSubview(vcTo.view)

        snapshot.frame = self.startFrame
        vcContainer.addSubview(snapshot)

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            snapshot.frame = (transitionContext.finalFrame(for: vcTo))
        }, completion: { success in
            vcTo.view.isHidden = false
            snapshot.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
}

