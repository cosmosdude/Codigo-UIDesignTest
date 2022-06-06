//
//  ImageCollectionViewCell.swift
//  UIDesignTest
//
//  Created by Thwin Htoo Aung on 2022-05-21.
//

import UIKit

fileprivate func deg2rad(_ degree: CGFloat) -> CGFloat {
    (degree * .pi) / 180
}

class ImageCollectionViewCell: NibCollectionViewCell {

    @IBOutlet private(set) var imageView: UIImageView!
    
    func startAnimating() {
        stopAnimating()
        
        let smallRandomDelay = TimeInterval.random(in: 0...0.5)
        
        UIView.animate(
            withDuration: 5, delay: smallRandomDelay,
            options: [.repeat, .curveLinear]
        ) {
            self.runKeyframeAnimation()
        } completion: { _ in }

//        UIView.animate(
//            withDuration: 5, delay: smallRandomDelay,
//            usingSpringWithDamping: 30, initialSpringVelocity: 30,
//            options: [.repeat]
//        ) {
//
//        } completion: { _ in }

    }
    
    private func runKeyframeAnimation() {
        let angle: CGFloat = 1
        let imageView = self.imageView
        
        let tx: CGFloat = 3
        let container = imageView?.superview
        
        UIView.animateKeyframes(
            withDuration: 5, delay: 0, options: [.allowUserInteraction, .repeat]
        ) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                imageView?.transform = CGAffineTransform(
                    rotationAngle: deg2rad(angle)
                )
                container?.transform = .init(translationX: -tx, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                imageView?.transform = .identity
                container?.transform = .identity
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                imageView?.transform = CGAffineTransform(
                    rotationAngle: deg2rad(-angle)
                )
                container?.transform = .init(translationX: tx, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                imageView?.transform = .identity
                container?.transform = .identity
            }
        } completion: { result in }
    }
    
    func stopAnimating() {
        imageView.layer.removeAllAnimations()
    }
    
}
