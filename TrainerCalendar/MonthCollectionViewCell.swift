//
//  MonthCollectionViewCell.swift
//  TrainerCalendar
//
//  Created by 이재웅 on 2022/02/11.
//

import UIKit
import SnapKit

class MonthCollectionViewCell: UICollectionViewCell {
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .light)
        label.textColor = .label
        
        return label
    }()
    
    func setup(calendarModel: CalendarModel, row: Int) {
        dateLabel.text = calendarModel.days[row]
        layout()
    }
    
    private func layout() {
        addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().inset(5.0)
        }
    }
}
