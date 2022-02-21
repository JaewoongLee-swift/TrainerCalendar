//
//  MonthTableViewCell.swift
//  TrainerCalendar
//
//  Created by 이재웅 on 2022/02/20.
//

import UIKit
import SnapKit

class MonthTableViewCell: UITableViewCell {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var periodLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        label.textColor = .label
        
        return label
    }()
    
    func setup(selectedMember member: Member) {
        nameLabel.text = member.name
        periodLabel.text = "\(member.yearStart)년 \(member.monthStart)월 \(member.dayStart)일 ~ \(member.yearFinish)년 \(member.monthFinish)월 \(member.dayFinish)일"
        typeLabel.text = "\(member.class) 회원"
        
        layout()
    }
}

extension MonthTableViewCell {
    private func layout() {
        [nameLabel, periodLabel, typeLabel].forEach { addSubview($0) }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10.0)
            $0.centerY.equalToSuperview()
        }
        
        periodLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(3.0)
            $0.trailing.equalToSuperview().inset(10.0)
            $0.height.equalTo(20.0)
        }
        
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(periodLabel.snp.bottom).offset(3.0)
            $0.trailing.equalTo(periodLabel.snp.trailing)
            $0.height.equalTo(periodLabel.snp.height)
        }
        
    }
}
