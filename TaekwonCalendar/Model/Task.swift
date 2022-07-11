//
//  Task.swift
//  TaekwonCalendar
//
//  Created by 최은성 on 2022/05/11.
//

import SwiftUI

// Task Model and Sample Tasks...
// Array of Tasks...
//struct Task: Identifiable {
//    var id = UUID().uuidString
//    var title: String
//    var time: Date = Date()
//}

// Total Task Meta View...
struct TaskMetaData: Identifiable {
    var id = UUID().uuidString
    var university: String
    var date: Date = Date()
}

// sample Date for Testing...
func getSampleDate(offset: Int)->Date{
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

// Sample Tasks...
//var tasks: [TaskMetaData] = [
//    TaskMetaData(task: [
//        Task(title: "Talk to A"),
//        Task(title: "iPhone 13 Great Desing Change"),
//        Task(title: "Nothing Much Workout !!!")
//    ], taskDate: getSampleDate(offset: 1)),
//
//    TaskMetaData(task: [
//        Task(title: "Talk to B"),
//    ], taskDate: getSampleDate(offset: -3)),
//
//    TaskMetaData(task: [
//        Task(title: "Meeting with C"),
//    ], taskDate: getSampleDate(offset: -8)),
//
//    TaskMetaData(task: [
//        Task(title: "Nect version of SwiftUI"),
//    ], taskDate: getSampleDate(offset: 10)),
//
//    TaskMetaData(task: [
//        Task(title: "Nothing Much Workout !!!"),
//    ], taskDate: getSampleDate(offset: -22)),
//    
//    TaskMetaData(task: [
//        Task(title: "iPhone 13 Great Desing Change"),
//    ], taskDate: getSampleDate(offset: -15)),
//
//    TaskMetaData(task: [
//        Task(title: "software App updates..."),
//    ], taskDate: getSampleDate(offset: -20))
//
//]
