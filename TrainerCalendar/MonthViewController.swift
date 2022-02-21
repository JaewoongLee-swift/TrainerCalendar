//
//  MonthViewController.swift
//  TrainerCalendar
//
//  Created by 이재웅 on 2022/02/08.
//

import UIKit
import SnapKit

class MonthViewController: UIViewController {
    let woong = Member(name: "이재웅", birth: "1996-06-24", class: "기간권", yearStart: 2022, monthStart: 2, dayStart: 10, yearFinish: 2022, monthFinish: 2, dayFinish: 20)
    
    private var member: [Member] = []
    private var membersInSelectedDay: [Member] = []
    private var selectedDay: Int = 0
    
    private lazy var calendarModel = CalendarModel()
    
    private lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MonthTableViewCell.self, forCellReuseIdentifier: "MonthTableViewCell")
        //MARK: prefetchDataSource 구현필요
//      tableView.prefetchDataSource = self
        tableView.rowHeight = 50.0
        
        return tableView
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MonthCollectionViewCell else { fatalError() }
        
        cell.changeLabelAndBackgroundColor(calendarModel)
        findMemberInDay(cell.day)
        self.tableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MonthCollectionViewCell else { fatalError() }
        
        cell.changeLabelAndBackgroundBeforeColor(calendarModel)
    }
}

extension MonthViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let daysCount = calendarModel.days.count
        return daysCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthCollectionViewCell", for: indexPath) as? MonthCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setup(calendarModel: calendarModel, row: indexPath.row, member: member)
        //MARK: collectionView 초기화 시 오늘날짜 cell 선택되있도록 구현
        
        return cell
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
//--------------------------------------------------------------------------------------
//  TableView DelegateFlowLayout / DataSource
//--------------------------------------------------------------------------------------
extension MonthViewController: UITableViewDelegate {
    
}

extension MonthViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MonthTableViewCell", for: indexPath) as? MonthTableViewCell else { return UITableViewCell() }
        cell.setup(selectedMember: membersInSelectedDay[indexPath.row])
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return membersInSelectedDay.count
    }
}
//--------------------------------------------------------------------------------------
//  Layout / Attribute / etc
//--------------------------------------------------------------------------------------

extension MonthViewController {
    private func findMemberInDay(_ day: Int) {
        membersInSelectedDay = []
        selectedDay = day
        
        for mem in member {
            if mem.dayStart <= selectedDay, mem.dayFinish >= selectedDay {
                membersInSelectedDay.append(mem)
            }
        }
        
        //MARK: memberInSelectedDay 배열, 기간권 / PT시간 기준으로 순서 재정렬 구현
    }
    
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
        // 네비게이션 색상변경 보류
//        navigationController?.navigationBar.tintColor = .black
    }
    
    private func layout() {
        [collectionView, separateView, tableView].forEach { view.addSubview($0) }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo((view.frame.width / 7.0 + 5.0) * 5.0)
        }
        
        separateView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.3)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(separateView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
