//
//  UIViewExtension.swift
//  DesignKit
//
//  Created by zhangpenghui on 2021/4/4.
//

import Foundation

public extension UIView {
    
    /// 头像圆角
    /// - Parameter cornerRadius: 圆角
    func asAvatar(cornerRadius: CGFloat = 4) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
