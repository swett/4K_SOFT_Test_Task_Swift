//
//  ViewController.swift
//  4K-SOFT_Test_Task
//
//  Created by Vitaliy Griza on 08.09.2022.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
  

    var tableDoorsView: FadeTableView!
    var separatorView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
//        for family in UIFont.familyNames.sorted() {
//          let names = UIFont.fontNames(forFamilyName: family)
//          print("Family: \(family) Font names: \(names)")
//        }
        separatorView = UIView().then({ v in
            view.addSubview(v)
            v.backgroundColor = .darkGray.withAlphaComponent(0.7)
            v.alpha = 0
            v.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide)
                make.left.right.equalToSuperview()
                make.height.equalTo(1/UIScreen.main.scale)
            }
        })
        
        tableDoorsView = FadeTableView(frame: CGRect(), style: .grouped).then({ tableview in
            view.addSubview(tableview)
            tableview.backgroundColor = .white
            tableview.delegate = self
            tableview.dataSource = self
            tableview.separatorStyle = .none
            tableview.showsVerticalScrollIndicator = false
            tableview.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
            tableview.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
            tableview.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide)
                make.bottom.equalToSuperview()
                make.left.right.equalToSuperview()

            }
        })
        
    }
    func configureNavigationBar() {
        //create logo image
        let logoImageView = UIImageView().then { logo in
            logo.image = UIImage(named: "logo")
            logo.contentMode = .scaleAspectFill
        }
        let imageItem = UIBarButtonItem(customView: logoImageView)
        //create button
        let settingsButton = UIButton().then { button in
            button.backgroundColor = .clear
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 13
            button.layer.borderColor = UIColor(named: "BorderColor")!.cgColor
            button.setImage(UIImage(named: "Setting"), for: .normal)
            button.addTarget(self, action: #selector(self.settingsButtonTapped), for: .touchUpInside)
            button.setTitle(nil, for: .normal)
            button.snp.makeConstraints { make in
                make.width.height.equalTo(44)
            }
        }
        let item = UIBarButtonItem(customView: settingsButton)
        // Customizing our navigation bar

        self.navigationItem.setRightBarButton(item, animated: false)
        self.navigationItem.setLeftBarButton(imageItem, animated: true)
    }

    @objc func settingsButtonTapped(){
        UIView.animate(withDuration: 0.15) {
            self.navigationItem.rightBarButtonItem?.customView?.transform = .init(scaleX: 0.85, y: 0.85)
        } completion: { com in
            UIView.animate(withDuration: 0.15) {
                self.navigationItem.rightBarButtonItem?.customView?.transform = .identity
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AppData.shared.doorsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableDoorsView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell

        cell.loadData(door: AppData.shared.doorsArray[indexPath.row])
        

        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! CustomHeaderView
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableDoorsView.cellForRow(at: indexPath) as! CustomTableViewCell
        UIView.animate(withDuration: 0.15) {
            cell.transform = .init(scaleX: 0.95, y: 0.95)
            cell.unlockDoors()
        } completion: { com in
            UIView.animate(withDuration: 0.15) {
                cell.transform = .identity
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! CustomTableViewCell
         
        cell.spinnerView.animate()
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! CustomTableViewCell
        cell.spinnerView.layer.removeAllAnimations()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.15) {
            self.separatorView.alpha = scrollView.contentOffset.y > 0 ? 1 : 0
        }
        tableDoorsView.updateGradient()
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        let label = UILabel().then { label in
//            label.text = "My Doors"
//            label.textColor = UIColor(named: "PrimaryTextColor")
//            label.font = UIFont(name: "Sk-Modernist-Bold", size: 20)
//        }
//        
//        return label
//    }
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 300
//    }

    
}

