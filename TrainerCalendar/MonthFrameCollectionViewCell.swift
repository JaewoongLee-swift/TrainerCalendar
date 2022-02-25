//
//  MonthFrameCollectionViewCell.swift
//  TrainerCalendar
//
//  Created by 이재웅 on 2022/02/22.
//

import UIKit
import SnapKit

class MonthFrameCollectionViewCell: UICollectionViewCell {
    weak var delegate: SelectedDayDelegate?
    
    private var member: [Member] = []
    private var selectedDayMembers: [Member] = []
    private var selectedDay: Int = 0
    
    private var isScheduled: Bool = false
    
    private var year: Int = 0
    private var month: Int = 0
    private var days: [String] = []
    private var today: Int = 0
    
    lazy var collectionView: UICollectionView = {
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
    
    func setup(calendarModel: CalendarModel, member: [Member]) {
        year = calendarModel.components.year ?? 0
        month = calendarModel.components.month ?? 0
        days = calendarModel.days
        today = calendarModel.today
        self.member = member
        
        layout()
    }
}

//--------------------------------------------------------------------------------------
//  CalendarCollectionView DelegateFlowLayout / DataSource
//--------------------------------------------------------------------------------------
extension MonthFrameCollectionViewCell: UICollectionViewDelegateFlowLayout {
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

        cell.changeLabelAndBackgroundColor(today: today)
        findMemberInDay(cell.day)
        self.delegate?.setMemberList(selectedMembers: selectedDayMembers)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MonthCollectionViewCell else { fatalError() }

        cell.changeLabelAndBackgroundBeforeColor(today: today)
    }
}

extension MonthFrameCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let daysCount = days.count
        
        return daysCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthCollectionViewCell", for: indexPath) as? MonthCollectionViewCell else { return UICollectionViewCell() }

        cell.setup(year: year, month: month, days: days, today: today, row: indexPath.row, member: member)
        //MARK: collectionView 초기화 시 오늘날짜 cell 선택되있도록 구현
        cell.matchInformation(member)

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
//  Layout
//--------------------------------------------------------------------------------------

extension MonthFrameCollectionViewCell {
    
    private func findMemberInDay(_ day: Int) {
        selectedDayMembers = []
        selectedDay = day

        for mem in member {
            if mem.dayStart <= selectedDay, mem.dayFinish >= selectedDay {
                selectedDayMembers.append(mem)
            }
        }

        //MARK: memberInSelectedDay 배열, 기간권 / PT시간 기준으로 순서 재정렬 구현
    }
    
    private func layout() {
        self.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


protocol SelectedDayDelegate: class {
    func setMemberList(selectedMembers: [Member])
}
