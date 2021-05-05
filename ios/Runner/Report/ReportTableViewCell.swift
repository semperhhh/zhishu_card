//
//  ReportTableViewCell.swift
//  Runner
//
//  Created by zhangpenghui on 2021/5/5.
//

import UIKit
import DesignKit

class ReportTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (m) in
            m.left.equalTo(Spacing.small)
            m.centerY.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var nameLabel: UILabel = {
        let v = UILabel()
        v.textColor = UIColor.designKit.main_text
        v.font = UIFont.designKit.title
        v.text = "日报"
        return v
    }()
    
}
