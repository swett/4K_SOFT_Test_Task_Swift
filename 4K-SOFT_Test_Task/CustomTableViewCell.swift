//
//  CustomTableViewCell.swift
//  4K-SOFT_Test_Task
//
//  Created by Vitaliy Griza on 09.09.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    var containerView: UIView!
    var doorProtectView: UIImageView!
    var doorNameLabel: UILabel!
    var doorPlacementLabel: UILabel!
    var doorIsLockedLabel: UILabel!
    var doorLockedView: UIImageView!
    var doorsItem: DoorsItem!
    var spinnerView: SpinnerView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        containerView = UIView().then({ container in
            contentView.addSubview(container)
            container.layer.cornerRadius = 10
            container.layer.borderWidth = 1
            container.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
            container.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.left.right.equalToSuperview().inset(15)
                make.height.equalTo(117)
                make.bottom.equalToSuperview().inset(14)
            }
        })
        
        doorProtectView = UIImageView().then({ imageView in
            containerView.addSubview(imageView)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(18)
                make.left.equalToSuperview().offset(27)
            }
        })
        
        doorNameLabel = UILabel().then({ doorName in
            containerView.addSubview(doorName)
            doorName.textColor = UIColor(named: "PrimaryTextColor")
            doorName.numberOfLines = 0
            doorName.adjustsFontSizeToFitWidth = true
            doorName.backgroundColor = .clear
            doorName.textAlignment = .left
            doorName.font = UIFont(name: "Sk-Modernist-Bold", size: 16)
            doorName.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(22)
                make.left.equalTo(doorProtectView.snp.right).offset(14)
            }
        })
        
        doorPlacementLabel = UILabel().then({ doorPlacement in
            containerView.addSubview(doorPlacement)
            doorPlacement.textColor = UIColor(named: "SecondaryTextColor")
            doorPlacement.numberOfLines = 0
            doorPlacement.backgroundColor = .clear
            doorPlacement.textAlignment = .left
            doorPlacement.font = UIFont(name: "Sk-Modernist-Regular", size: 14)
            doorPlacement.snp.makeConstraints { make in
                make.top.equalTo(doorNameLabel.snp.bottom)
                make.left.equalTo(doorProtectView.snp.right).offset(14)
            }
        })
        
        doorIsLockedLabel = UILabel().then({ doorIsLocked in
            containerView.addSubview(doorIsLocked)
            doorIsLocked.textColor = .black
            doorIsLocked.numberOfLines = 0
            doorIsLocked.adjustsFontSizeToFitWidth = true
            doorIsLocked.backgroundColor = .clear
            doorIsLocked.textAlignment = .center
            doorIsLocked.font = UIFont(name: "Sk-Modernist-Bold", size: 15)
            // i found this action senseless
//            doorIsLocked.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(unlockDoors)))
            doorIsLocked.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().inset(15)
            }
        })
        
        doorLockedView = UIImageView().then({ imageView in
            containerView.addSubview(imageView)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(18)
                make.height.equalTo(45)
                make.width.equalTo(41)
                make.right.equalToSuperview().inset(28)
            }
        })
        
        spinnerView = SpinnerView().then({ spinner in
            containerView.addSubview(spinner)
            spinner.alpha = 0
            spinner.snp.makeConstraints { make in
//                make.top.equalToSuperview().offset(27)
//                make.right.equalToSuperview().inset(20)
                make.center.equalTo(doorLockedView)
                make.height.width.equalTo(22)
                
            }
        })
        
        
    }
    
    
    func loadData(door: DoorsItem) {
//        print(door.isLocked)
//        let string = "\(door.isLocked)"
        doorsItem = door
        self.doorNameLabel.text = door.doorsName
        self.doorPlacementLabel.text = door.doorsPlacement
        configureCellFor(state: door.isLocked)
//        self.doorIsLockedLabel.text = String?(door.isLocked.rawValue)
    }
    
    @objc func unlockDoors() {
        if doorsItem.isLocked == .close {
            doorsItem.isLocked = .loading
            configureCellFor(state: doorsItem.isLocked)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.doorsItem.isLocked = .open
                self.configureCellFor(state: self.doorsItem.isLocked)
            }
            
        } else if doorsItem.isLocked == .open {
            doorsItem.isLocked = .close
            configureCellFor(state: doorsItem.isLocked)
        }
    }
    func configureCellFor(state : LockedState){
        switch state {
        case .close:
            self.stopSpinAnimation()
            self.doorIsLockedLabel.text = "Locked"
            self.doorIsLockedLabel.textColor = UIColor(named: "LockedTextColor")
            self.doorProtectView.image = UIImage(named: "Protected")
            self.doorLockedView.image = UIImage(named: "lockedDoor")
        case .open:
            self.stopSpinAnimation()
            self.doorIsLockedLabel.text = "Unlocked"
            self.doorIsLockedLabel.textColor = UIColor(named: "LockedTextColor")?.withAlphaComponent(0.5)
            self.doorProtectView.image = UIImage(named: "NotProtected")
            self.doorLockedView.image = UIImage(named: "UnlockedDoor")
        case .loading:
            self.doorIsLockedLabel.text = "Unlocking..."
            self.doorIsLockedLabel.textColor = .black.withAlphaComponent(0.17)
            self.doorProtectView.image = UIImage(named: "loadingUnlock")
            self.startSpinAnimation()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startSpinAnimation() {
        UIView.animate(withDuration: 0.15) {
            self.doorLockedView.alpha = 0
            
        } completion: { com in
            UIView.animate(withDuration: 0.15) {
                self.spinnerView.alpha = 1
            }
        }
        
    }
    
    func stopSpinAnimation() {
        UIView.animate(withDuration: 0.15) {
            self.spinnerView.alpha = 0
        } completion: { com in
            UIView.animate(withDuration: 0.15) {
                self.doorLockedView.alpha = 1

            }
        }
    }
    
}
