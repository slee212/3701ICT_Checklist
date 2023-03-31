//
//  DataModel.swift
//  Checklish
//
//  Created by Samuel Lee on 31/3/2023.
//

import Foundation

struct Item: Hashable {
    var day: String
    var task: String
}

struct DataModel {
    var tasks:[Item]
}

var testTasks = [
    Item(day: "Mon", task: "Do laundry"),
    Item(day: "Wed", task: "Go shopping")
]
