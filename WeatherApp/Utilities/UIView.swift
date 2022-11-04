//
//  File.swift
//  WeatherApp
//
//  Created by norelhoda on 04/11/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func roundCorners2(corners: UIRectCorner, radius: CGFloat) {
            if #available(iOS 11, *) {
                self.clipsToBounds = true
                self.layer.cornerRadius = radius
                var masked = CACornerMask()
                if corners.contains(.topLeft) { masked.insert(.layerMinXMinYCorner) }
                if corners.contains(.topRight) { masked.insert(.layerMaxXMinYCorner) }
                if corners.contains(.bottomLeft) { masked.insert(.layerMinXMaxYCorner) }
                if corners.contains(.bottomRight) { masked.insert(.layerMaxXMaxYCorner) }
                self.layer.maskedCorners = masked
            }
            else {
                let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
                let mask = CAShapeLayer()
                mask.path = path.cgPath
                layer.mask = mask
            }
        }
}
