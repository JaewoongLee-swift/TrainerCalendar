//
//  MonthViewController.swift
//  TrainerCalendar
//
//  Created by 이재웅 on 2022/02/08.
//

import UIKit
import SnapKit

class MonthViewController: UIViewController, SelectedDayDelegate {
    let woong = Member(name: "이재웅", birth: "1996-06-24", class: "기간권", yearStart: 2022, monthStart: 2, dayStart: 10, yearFinish: 2022, monthFinish: 2, dayFinish: 20)
    
    private var member: [Member] = []
    private lazy var selectedDayMembers: [Member] = []
    private var selectedDay: Int = 0
    
    private lazy var calendarModel = CalendarModel()
    
    private lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let frameCVLayout = UICollectionViewFlowLayout()
        frameCVLayout.sectionHeadersPinToVisibleBounds = true
        let frameCV = UICollectionView(frame: .zero, collectionViewLayout: frameCVLayout)
    
        frameCV.backgroundColor = .systemBackground
        
        frameCV.delegate = self
        frameCV.dataSource = self
        frameCV.register(MonthFrameCollectionViewCell.self, forCellWithReuseIdentifier: "MonthFrameCollectionViewCell")
        frameCV.register(MonthCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MonthCollectionHeaderView")
        
        return frameCV
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
//  FrameCollectionView DelegateFlowLayout / DataSource
//--------------------------------------------------------------------------------------
extension MonthViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height = (width / 7) * 5
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: 15.0)
    }
}

extension MonthViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthFrameCollectionViewCell", for: indexPath) as? MonthFrameCollectionViewCell else { return UICollectionViewCell() }

        cell.setup(calendarModel: calendarModel, member: member)
        cell.delegate = self
        
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
        cell.setup(selectedMember: selectedDayMembers[indexPath.row])
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return selectedDayMembers.count
    }
}
//--------------------------------------------------------------------------------------
//  Layout / Attribute / etc
//--------------------------------------------------------------------------------------

extension MonthViewController {
    func setMemberList(selectedMembers: [Member]) {
        selectedDayMembers = selectedMembers
        
        self.tableView.reloadData()
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
            $0.height.equalTo((view.frame.width / 7.0) * 5.0 + 15.0)
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
