//
//  ColorExtension.swift
//  DesignKit
//
//  Created by zhangpenghui on 2021/4/8.
//

import Foundation

public extension UIColor {

    /// 随机颜色
    class var random: UIColor {
        let r = CGFloat(arc4random() % 256) / 255.0
        let g = CGFloat(arc4random() % 256) / 255.0
        let b = CGFloat(arc4random() % 256) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    static let designKit = DesignKitPalette.self
    
    enum DesignKitPalette {
        ///  动态颜色
        /// - Parameters:
        ///   - light: 浅色
        ///   - dark: 深色
        /// - Returns： 颜色
        static private func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
            return UIColor {
                $0.userInterfaceStyle == .dark ? dark : light
            }
        }
        
        public static let primary: UIColor = dynamicColor(light: UIColor(hex: 0xFF21C38F), dark: UIColor(hex: 0xFF000000))
        public static let main_app: UIColor = dynamicColor(light: UIColor(hex: 0xFFF5F5F5), dark: UIColor(hex: 0xFF000000))
        public static let main_text: UIColor = dynamicColor(light: UIColor.black, dark: UIColor.white)
        public static let red: UIColor = UIColor.init(hex: 0xFFFF4351)
        public static let orange: UIColor = UIColor.init(hex: 0xFFFEAE1B)
        public static let grey: UIColor = UIColor.init(hex: 0xFFEEEEEE)
        public static let blue: UIColor = UIColor.init(hex: 0xFF229ffd)
        public static let green: UIColor = UIColor.init(hex: 0xFFA5DE37)
        public static let purple: UIColor = UIColor.init(hex: 0xFF7B72E9)
        public static let black: UIColor = UIColor.init(hex: 0xFF0c0c0c)
    }
}
