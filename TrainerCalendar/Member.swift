//
//  Member.swift
//  TrainerCalendar
//
//  Created by 이재웅 on 2022/02/16.
//

import Foundation

struct Member: Hashable, Decodable {
    let name: String
    let birth: String
    let `class`: String
    
    let yearStart: Int
    let monthStart: Int
    let dayStart: Int
    
    let yearFinish: Int
    let monthFinish: Int
    let dayFinish: Int
}
