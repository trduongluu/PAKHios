//
//  Helper.swift
//  PAKHApp
//
//  Created by Tung Vu on 1/29/18.
//  Copyright © 2018 Tung Vu. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UILabel {
    func setupLabel(){
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.1
        font = UIFont(name: "Ubuntu-Regular", size: 11)
        textColor = UIColor.rgb(red: 34, green: 67, blue: 162)
    }
}

extension UIViewController {
    
    func showMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Đồng ý", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

fileprivate let minimumHitArea = CGSize(width: 50, height: 50)

extension UIButton {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // if the button is hidden/disabled/transparent it can't be hit
        if self.isHidden || !self.isUserInteractionEnabled || self.alpha < 0.01 { return nil }
        
        // increase the hit frame to be at least as big as `minimumHitArea`
        let buttonSize = self.bounds.size
        let widthToAdd = max(minimumHitArea.width - buttonSize.width, 0)
        let heightToAdd = max(minimumHitArea.height - buttonSize.height, 0)
        let largerFrame = self.bounds.insetBy(dx: -widthToAdd / 2, dy: -heightToAdd / 2)
        
        // perform hit test on larger frame
        return (largerFrame.contains(point)) ? self : nil
    }
}

