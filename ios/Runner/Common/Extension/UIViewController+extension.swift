//
//  UIViewController_extension.swift
//  Runner
//
//  Created by zhangpenghui on 2021/3/26.
//


extension UIViewController {
    
    enum NavigationBarStyle {
        case title, image
    }
    
    enum NavigationBarLoaction {
        case left, right
    }
    
    func addBarButton(loaction: NavigationBarLoaction = .left, style: NavigationBarStyle = .title, content: String, aciton: Selector) {
    
        let b = UIButton()
        switch style {
        case .title:
            b.setTitle(content, for: .normal)
            b.setTitleColor(UIColor.black, for: .normal)
            b.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        default:
            b.setImage(UIImage(named: content), for: .normal)
        }
        b.addTarget(self, action: aciton, for: .touchUpInside)
        
        let item = UIBarButtonItem(customView: b)
        
        switch loaction {
        case .left:
            if self.navigationItem.leftBarButtonItems == nil {
                self.navigationItem.leftBarButtonItems = []
            }
            self.navigationItem.leftBarButtonItems?.append(item)
        default:
            if self.navigationItem.rightBarButtonItems == nil {
                self.navigationItem.rightBarButtonItems = []
            }
            self.navigationItem.rightBarButtonItems?.append(item)
        }
    }
}
