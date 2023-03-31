//
//  DataModel.swift
//  Checklish
//
//  Created by Samuel Lee on 31/3/2023.
//

import Foundation

struct Item: Hashable, Codable {
    var day: String
    var task: String
}

func getFile() -> URL? {
    let filename = "mytasks.json"
    let fm = FileManager.default
    guard let url = fm.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        .first else {
        return nil
    }
    return url.appendingPathComponent(filename)
}

struct DataModel: Codable {
    var tasks:[Item]
    init () {
        tasks = []
        load()
    }
    
    mutating func load() {
        guard let url = getFile(),
              let data = try? Data(contentsOf: url),
              let datamodel = try? JSONDecoder().decode(DataModel.self, from: data) else {
            self.tasks = testTasks
            return
        }
        self.tasks = datamodel.tasks
    }
    func save() {
        guard let url = getFile(),
              let data = try? JSONEncoder().encode(self)
        else {
            return
        }
        try? data.write(to: url)
    }
}

var testTasks = [
    Item(day: "Mon", task: "Do laundry"),
    Item(day: "Wed", task: "Go shopping")
]
