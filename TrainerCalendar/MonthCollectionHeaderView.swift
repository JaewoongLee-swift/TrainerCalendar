//
//  MonthCollectionHeaderView.swift
//  TrainerCalendar
//
//  Created by 이재웅 on 2022/02/16.
//

import UIKit
import SnapKit

final class MonthCollectionHeaderView: UICollectionReusableView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        [sun, mon, tue, wed, thu, fri, sat].forEach { stackView.addArrangedSubview($0) }
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var sun: UILabel = {
        let label = UILabel()
        label.text = "일"
        label.textColor = .red
        label.font = .systemFont(ofSize: 10.0)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var mon: UILabel = {
        let label = UILabel()
        label.text = "월"
        label.font = .systemFont(ofSize: 10.0)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var tue: UILabel = {
        let label = UILabel()
        label.text = "화"
        label.font = .systemFont(ofSize: 10.0)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var wed: UILabel = {
        let label = UILabel()
        label.text = "수"
        label.font = .systemFont(ofSize: 10.0)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var thu: UILabel = {
        let label = UILabel()
        label.text = "목"
        label.font = .systemFont(ofSize: 10.0)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var fri: UILabel = {
        let label = UILabel()
        label.text = "금"
        label.font = .systemFont(ofSize: 10.0)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var sat: UILabel = {
        let label = UILabel()
        label.text = "토"
        label.textColor = .blue
        label.font = .systemFont(ofSize: 10.0)
        label.textAlignment = .center
        
        return label
    }()
    
    
    func layout() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            
        }
    }
}
