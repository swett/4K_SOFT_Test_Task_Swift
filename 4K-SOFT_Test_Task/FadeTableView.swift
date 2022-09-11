//
//  FadeTableView.swift
//  AppHumanDesign
//
//  Created by Vitaliy Griza on 02.03.2021.
//

import UIKit

class FadeTableView: UITableView, CAAnimationDelegate {
    
    let fadePoints: Float = 32.0
    let gradientLayer = CAGradientLayer()
    let transparentColor = UIColor.clear.cgColor
    let opaqueColor = UIColor.white.cgColor
    var isEnabled = true
    
    var topFadingOpacity: CGColor {
    
        let scrollOffset = contentOffset.y
        let alpha:CGFloat = ( scrollOffset <= 0) ? 1 : 0
        let color = UIColor(white: 1.0, alpha: alpha)
        return color.cgColor
    }
    
    var bottomFadingOpacity: CGColor {
        let scrollViewHeight = frame.size.height
        let scrollContentSizeHeight = contentSize.height
        let scrollOffset = contentOffset.y
        
        let alpha:CGFloat = (scrollOffset + scrollViewHeight >= scrollContentSizeHeight) ? 1 : 0
        let color = UIColor(white: 1.0, alpha: alpha)
        return color.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (isEnabled) {
            let maskLayer = CALayer()
            maskLayer.frame = self.bounds
//
            let gradientLocation = fadePoints / Float(frame.height)
            gradientLayer.frame = CGRect(x: self.bounds.origin.x, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
            gradientLayer.colors = [topFadingOpacity, opaqueColor, opaqueColor, bottomFadingOpacity]
//            let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
//
//            animation.fromValue = gradientLayer.colors
//            animation.toValue = [topFadingOpacity, opaqueColor, opaqueColor, bottomFadingOpacity]
//                        gradientLayer.colors = [topFadingOpacity, opaqueColor, opaqueColor, bottomFadingOpacity]
//            animation.duration = 0.48
//            animation.isRemovedOnCompletion = true
//            animation.fillMode = CAMediaTimingFillMode.forwards
//            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
//            animation.delegate = self
//
//            gradientLayer.add(animation, forKey:"animateGradient")
            gradientLayer.locations = [0, NSNumber(value: gradientLocation), NSNumber(value: 1 - gradientLocation), 1]
            maskLayer.addSublayer(gradientLayer)

            self.layer.mask = maskLayer
        }
    }

    /// Update gradient depending on content offset of the scrollview
    /// Call this function in [scrollViewDidScroll] of UIScrollViewDelegate
    public func updateGradient() {
        if (isEnabled) {
            gradientLayer.colors = [topFadingOpacity, opaqueColor, opaqueColor, bottomFadingOpacity]
        }
    }
}

extension UITableView {
    func fixCellBounds() {
        DispatchQueue.main.async { [weak self] in
            for cell in self?.visibleCells ?? [] {
                cell.layer.masksToBounds = false
                cell.contentView.layer.masksToBounds = false
            }
        }
    }
}
