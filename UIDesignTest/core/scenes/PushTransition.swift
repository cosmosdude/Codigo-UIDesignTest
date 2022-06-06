//
//  PushTransition.swift
//  UIDesignTest
//
//  Created by Thwin Htoo Aung on 2022-06-06.
//

import UIKit

class PushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = TimeInterval(0.4)
    
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval { duration }
    
    func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning
    ) {
        let ctx = transitionContext
        
        guard let toVC = ctx.viewController(forKey: .to),
            let toView = ctx.view(forKey: .to)
        else { return }
        
        let endFrame = ctx.finalFrame(for: toVC)
        
        let container = ctx.containerView
        
        let redView = { (v: UIView) -> UIView in
            v.backgroundColor = R.Colors.accentColor
            return v
        }(UIView())
        
        let greenView = { (v: UIView) -> UIView in
            v.backgroundColor = R.Colors.selectionColor
            return v
        }(UIView())
        
        let blueView = { (v: UIView) -> UIView in
            v.backgroundColor = R.Colors.yellowColor
            return v
        }(UIView())
        
        container.addSubview(redView)
        redView.frame = endFrame
        redView.transform = .init(translationX: endFrame.size.width, y: 0)
        
        container.addSubview(blueView)
        blueView.frame = endFrame
        blueView.transform = .init(translationX: endFrame.size.width, y: 0)
        
        container.addSubview(greenView)
        greenView.frame = endFrame
        greenView.transform = .init(translationX: endFrame.size.width, y: 0)
        
        
        
        container.addSubview(toView)
        toVC.view.alpha = 0
        toVC.view.transform = .init(translationX: 0, y: 50)
        
        
        
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseIn]) {
            
            UIView.animateKeyframes(withDuration: 0, delay: 0, options: []) {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0, relativeDuration: 0.3
                ) {
                    redView.transform = .identity
                }
                UIView.addKeyframe(
                    withRelativeStartTime: 0.1, relativeDuration: 0.3
                ) {
                    blueView.transform = .identity
                }
                UIView.addKeyframe(
                    withRelativeStartTime: 0.2, relativeDuration: 0.3
                ) {
                    greenView.transform = .identity
                }
                UIView.addKeyframe(
                    withRelativeStartTime: 0.4, relativeDuration: 0.5
                ) {
                    toVC.view.alpha = 1
                    toVC.view.transform = .identity
                }
            } completion: { flag in
                redView.removeFromSuperview()
                greenView.removeFromSuperview()
                blueView.removeFromSuperview()
                ctx.completeTransition(flag)
            }

        } completion: {
            flag in
        }

    }
    

}
