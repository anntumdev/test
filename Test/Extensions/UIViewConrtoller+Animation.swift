//
//  UIViewConrtoller+Animation.swift
//  Test
//
//  Created by Anna on 06.03.2023.
//

import Foundation
import UIKit

extension UIViewController {
    ///Add animation to root view
    func addLoadingAnimation() {
        let loadview = UIActivityIndicatorView(frame: self.view.frame)
        self.view.addSubview(loadview)
        loadview.tag = 99
        loadview.startAnimating()
    }
    ///Remove animation from root view
    func removeLoadingAnimation() {
        let loadview = self.view.subviews.first{$0.tag == 99}
        loadview?.removeFromSuperview()
    }
}
