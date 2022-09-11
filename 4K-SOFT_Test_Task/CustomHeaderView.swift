//
//  CustomHeaderView.swift
//  4K-SOFT_Test_Task
//
//  Created by Vitaliy Griza on 09.09.2022.
//

import UIKit

class CustomHeaderView: UITableViewHeaderFooterView {

    var containerView: UIView!
    var presentLabel: UILabel!
    var homeImageView: UIImageView!
    var titleForHeaderLabel: UILabel!
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        containerView = UIView().then({ container in
            contentView.addSubview(container)
            container.backgroundColor = .white
            container.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.left.equalToSuperview().offset(24)
                make.right.equalToSuperview()
                make.height.equalTo(250)
                make.bottom.equalToSuperview().inset(29)
            }
        })
        presentLabel = UILabel().then({ presentLabel in
            containerView.addSubview(presentLabel)
            presentLabel.textColor = .black
            presentLabel.numberOfLines = 0
            presentLabel.adjustsFontSizeToFitWidth = true
            presentLabel.backgroundColor = .clear
            presentLabel.textAlignment = .center
            presentLabel.text = "Welcome"
            presentLabel.font = UIFont(name: "Sk-Modernist-Bold", size: 35)
            presentLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(63)
                make.left.equalToSuperview()
            }
        })
        homeImageView = UIImageView().then({ image in
            containerView.addSubview(image)
            image.image = UIImage(named: "Home")
            image.snp.makeConstraints { make in
                make.right.equalToSuperview()
                make.height.equalTo(168)
                make.width.equalTo(189)
                make.top.equalToSuperview().offset(18)
            }
        })
        
        titleForHeaderLabel = UILabel().then({ label in
            containerView.addSubview(label)
            label.text = "My doors"
            label.textColor = UIColor(named: "PrimaryTextColor")
            label.font = UIFont(name: "Sk-Modernist-Bold", size: 20)
            label.snp.makeConstraints { make in
                
//                make.left.equalTo(25)
                make.bottom.equalToSuperview()
            }
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
