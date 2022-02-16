//
//  MonthViewController.swift
//  TrainerCalendar
//
//  Created by 이재웅 on 2022/02/08.
//

import UIKit
import SnapKit

class MonthViewController: UIViewController {
    let woong = Member(name: "이재웅", birth: "1996-06-24", class: "PT", yearStart: 2022, monthStart: 2, dayStart: 10, yearFinish: 2022, monthFinish: 2, dayFinish: 20)
    
    private var member: [Member] = []
    private lazy var calendarModel = CalendarModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        let color: UIColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        collectionView.backgroundColor = color
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: "MonthCollectionViewCell")
        collectionView.register(MonthCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MonthCollectionHeaderView")
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    
        member.append(woong)
        setupNavigationController()
        layout()
    }
}
//--------------------------------------------------------------------------------------
//  CollectionView DelegateFlowLayout / DataSource
//--------------------------------------------------------------------------------------
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 15.0)
    }
}

extension MonthViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let daysCount = calendarModel.days.count
        return daysCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthCollectionViewCell", for: indexPath) as? MonthCollectionViewCell
        
        cell?.setup(calendarModel: calendarModel, row: indexPath.row, member: member)
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "MonthCollectionHeaderView",
                for: indexPath
              ) as? MonthCollectionHeaderView
        else { return UICollectionReusableView() }
        
        header.backgroundColor = .systemBackground
        header.layout()
        
        return header
    }
}

extension MonthViewController {
    private func setupNavigationController() {
        
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
        // 색상변경 보류
//        navigationController?.navigationBar.tintColor = .black
    }
    
    private func layout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo((view.frame.width / 7.0 + 5.0) * 5.0)
        }
    }
}
