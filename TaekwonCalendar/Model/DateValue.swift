//
//  DateValue.swift
//  TaekwonCalendar
//
//  Created by 최은성 on 2022/05/11.
//

import SwiftUI

// Date Value Model...
struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
