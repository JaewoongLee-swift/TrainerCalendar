//
//  MonthViewController.swift
//  TrainerCalendar
//
//  Created by 이재웅 on 2022/02/08.
//

import UIKit
import SnapKit

class MonthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupNavigationController()
    }
}

extension MonthViewController {
    func setupNavigationController() {
        let searchButton = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: nil
        )
        
        let plusButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.rightBarButtonItems = [plusButton, searchButton]
    }
}
