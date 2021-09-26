//
//  UIView+Extension.swift
//  AppStoreCloning
//
//  Created by 선민승 on 2021/09/18.
//

import UIKit

extension UIView {
    func setRounded(radius : CGFloat?) {
        // UIView 의 모서리 둥글 때
        if let cornerRadius_ = radius {
            self.layer.cornerRadius = cornerRadius_
        }  else {
            // cornerRadius 가 nil 일 경우의 default
            self.layer.cornerRadius = self.layer.frame.height / 2
        }
        
        self.layer.masksToBounds = true
    }
}
