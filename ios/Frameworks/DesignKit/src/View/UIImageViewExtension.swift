//
//  UIImageViewExtension.swift
//  DesignKit
//
//  Created by zhangpenghui on 2021/4/8.
//

import Foundation

public extension UIImageView {
    
    /// 头像圆角
    /// - Parameter cornerRadius: 圆角
    func asAvatar(cornerRadius: CGFloat = 4) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
}
