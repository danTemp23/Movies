import Foundation
import UIKit

extension UIView {
    func applyGradientIfNeeded(colors: [UIColor]) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors.map { $0.cgColor }
        if layer.sublayers?.contains(where: {$0 as? CAGradientLayer != nil}) != true {
            layer.insertSublayer(gradient, at: 0)
        }
    }
}
