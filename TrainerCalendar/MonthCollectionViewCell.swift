//
//  MonthCollectionViewCell.swift
//  TrainerCalendar
//
//  Created by 이재웅 on 2022/02/11.
//

import UIKit
import SnapKit

class MonthCollectionViewCell: UICollectionViewCell {
    var isScheduled: Bool = false
    var year: Int = 0
    var month: Int = 0
    var day: Int = 0
    var days: [String] = []
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    private lazy var backgroundCircleView: UIImageView = {
        let image = UIImage(systemName: "circle.fill")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .red
        
        return imageView
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .regular)
        label.textColor = .label

        return label
    }()
    
    lazy var scheduleIndicator: UIImageView = {
        let image = UIImage(systemName: "circle.fill")
        
        let view = UIImageView(image: image)
        view.tintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        view.isHidden = true
        
        return view
    }()
    
    func setup(year: Int, month: Int, days: [String], today: Int, row: Int, member: [Member]) {
        self.year = year
        self.month = month
        self.days = days
        self.day = Int(self.days[row]) ?? 0
        
        
        matchInformation(member)
        
        if row % 7 == 0 || row % 7 == 6 {
            dateLabel.textColor = .gray
        }
        if isScheduled {
            scheduleIndicator.isHidden = false
        }
        if today == self.day {
            dateLabel.textColor = .red
            self.isSelected = true
        }
        
        dateLabel.text = self.days[row]
        
        layout()
    }
}

extension MonthCollectionViewCell {
    
    func matchInformation(_ member: [Member]) {
        for mem in member {
            if mem.yearStart <= self.year, mem.yearFinish >= self.year {
                if mem.monthStart <= self.month, mem.monthFinish >= self.month {
                    if mem.dayStart <= self.day, mem.dayFinish >= self.day {
                        isScheduled = true
                    }
                }
            }
        }
    }
    
    func changeLabelAndBackgroundColor(today: Int) {
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 20.0, weight: .bold)
        
        if today == self.day {
            backgroundCircleView.tintColor = .red
        } else {
            backgroundCircleView.tintColor = .label
        }
    }
    
    func changeLabelAndBackgroundBeforeColor(today: Int) {
        dateLabel.font = .systemFont(ofSize: 20.0, weight: .regular)
        if today == self.day {
            dateLabel.textColor = .red
        } else {
            dateLabel.textColor = .label
        }
    }
    
    private func layout() {
        self.selectedBackgroundView = backgroundCircleView
        [separator, dateLabel, scheduleIndicator].forEach { addSubview($0) }
        
        separator.snp.makeConstraints {
            $0.height.equalTo(0.2)
            $0.leading.trailing.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().inset(5.0)
        }
        
        scheduleIndicator.snp.makeConstraints {
            $0.height.width.equalTo(6.0)
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        backgroundCircleView.snp.makeConstraints {
            $0.centerX.equalTo(dateLabel.snp.centerX)
            $0.centerY.equalTo(dateLabel.snp.centerY)
            $0.height.width.equalTo(35.0)
        }
    }
}
