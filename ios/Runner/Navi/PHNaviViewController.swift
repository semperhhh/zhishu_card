//
//  PHNaviViewController.swift
//  Runner
//
//  Created by zhangpenghui on 2021/3/25.
//

import UIKit

class PHNaviViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let app = UINavigationBarAppearance()
        app.configureWithOpaqueBackground()
        app.backgroundColor = UIColor.designKit.main_app
        app.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.designKit.main_text]
        UINavigationBar.appearance().standardAppearance = app
        UINavigationBar.appearance().scrollEdgeAppearance = app
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if !viewControllers.isEmpty {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
