//
//  UIFontExtension.swift
//  DesignKit
//
//  Created by zhangpenghui on 2021/5/5.
//

import Foundation

public extension UIFont {
    
    static let designKit = DesignKitTypography()
    
    struct DesignKitTypography {
        
        /// 标题
        public var title: UIFont {
            UIFont.systemFont(ofSize: 16, weight: .semibold)
        }
        /// 子标题
        public var subTitle: UIFont {
            UIFont.systemFont(ofSize: 14, weight: .medium)
        }
        /// 内容
        public var body: UIFont {
            UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }
}
