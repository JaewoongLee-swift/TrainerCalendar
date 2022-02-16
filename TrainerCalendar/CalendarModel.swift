//
//  CalendarModel.swift
//  TrainerCalendar
//
//  Created by 이재웅 on 2022/02/08.
//

import Foundation

class CalendarModel {
    
    let now = Date()
    let dateFormatter = DateFormatter()
    
    var calendar = Calendar.current
    var components = DateComponents()
    var days: [String] = []
    var yearMonth = ""
    
    // 현재 날짜기준 캘린더 세팅
    init() {
        print("CalendarModel - setup")
        dateFormatter.dateFormat = "yyyy년 M월"
        
        components.year = calendar.component(.year, from: now)
        components.month = calendar.component(.month, from: now)
        // 현재 달의 1일 기준
        components.day = 1
        
        self.calculation()
    }
    
    
    
    // 캘린더 세팅 기준 달력계산
    func calculation() {
        print("CalendarModel - calculation")
        guard let firstDay = calendar.date(from: components) else { return }
        
        let firstWeekday = calendar.component(.weekday, from: firstDay)
        let dayCount = calendar.range(of: .day, in: .month, for: firstDay)!.count
        let weekFormatter = 2 - firstWeekday
        
        yearMonth = dateFormatter.string(from: firstDay)
        days = []
        
        for day in weekFormatter...dayCount {
            if day < 1 {
                days.append("")
            } else {
                days.append(String(day))
            }
        }
    }
}
