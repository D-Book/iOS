//
//  UIActivityIndicatorView.swift
//  D-Book
//
//  Created by 강민석 on 2020/08/19.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    public static func customIndicator(at center: CGPoint) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
        indicator.layer.cornerRadius = 15
        indicator.center = center
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.medium
//        indicator.backgroundColor = UIColor(red: 0.72, green: 0.11, blue: 0.11, alpha: 1.00)
        return indicator
    }
}
