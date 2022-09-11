//
//  NavigationVC.swift
//  4K-SOFT_Test_Task
//
//  Created by Vitaliy Griza on 08.09.2022.
//

import UIKit

class NavigationVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
                                          .foregroundColor: UIColor.white]
        navigationBar.tintColor = .white
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        // Do any additional setup after loading the view.
    }
    



}
