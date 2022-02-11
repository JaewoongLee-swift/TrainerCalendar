//
//  MonthViewController.swift
//  TrainerCalendar
//
//  Created by 이재웅 on 2022/02/08.
//

import UIKit
import SnapKit

class MonthViewController: UIViewController {
    lazy var calendarModel = CalendarModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .tertiarySystemFill
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: "MonthCollectionViewCell")
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemBackground
    
        setupNavigationController()
//        attribute()
        layout()
        calendarModel.setup()
    }
}

extension MonthViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / 7.0

        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let value: CGFloat = 0

        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        0.0
    }
}

extension MonthViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let daysCount = calendarModel.days.count
        return daysCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthCollectionViewCell", for: indexPath) as? MonthCollectionViewCell
        
        cell?.setup(calendarModel: calendarModel, row: indexPath.row)
        
        return cell ?? UICollectionViewCell()
    }
    
    
}

extension MonthViewController {
    private func setupNavigationController() {
        title = "네비게이션 바"
        
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
    
    private func attribute() {
        
    }
    
    private func layout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
