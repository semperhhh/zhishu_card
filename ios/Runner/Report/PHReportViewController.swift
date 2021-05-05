//
//  PHReportViewController.swift
//  Runner
//
//  Created by zhangpenghui on 2021/3/25.
//

import UIKit
import ZPHSuppleKit

class PHReportViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let v = UITableView()
        v.dataSource = self
        v.delegate = self
        v.register(ReportTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        return v
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
        self.navigationItem.title = "周报"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.addBarButton(loaction: .left, style: .image, content: "back_black", aciton: #selector(closeItemAction))
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (m) in
            m.top.left.right.bottom.equalTo(view)
        }
    }
    
    @objc func closeItemAction() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PHReportViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReportTableViewCell
        return cell
    }
}


