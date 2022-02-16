//
//  MonthCollectionViewCell.swift
//  TrainerCalendar
//
//  Created by 이재웅 on 2022/02/11.
//

import UIKit
import SnapKit

class MonthCollectionViewCell: UICollectionViewCell {
    lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .regular)
        label.textColor = .label
        
        return label
    }()
    
    func setup(calendarModel: CalendarModel, row: Int) {
        dateLabel.text = calendarModel.days[row]
        layout()
    }
    
    private func layout() {
        [separator, dateLabel].forEach { addSubview($0) }
        
        separator.snp.makeConstraints {
            $0.height.equalTo(0.3)
            $0.leading.trailing.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().inset(5.0)
        }
    }
}
