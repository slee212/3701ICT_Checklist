//
//  DataModel.swift
//  Checklish
//
//  Created by Samuel Lee on 31/3/2023.
//

import Foundation

struct Checklist: Hashable, Codable {
    var name: String
    var test = [String]()
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
    var lists:[Checklist]
    init () {
        lists = []
        load()
    }
    
    mutating func load() {
        guard let url = getFile(),
              let data = try? Data(contentsOf: url),
              let datamodel = try? JSONDecoder().decode(DataModel.self, from: data) else {
            self.lists = testLists
            return
        }
        self.lists = datamodel.lists
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

var testLists = [
    Checklist(name: "Groceries"),
    Checklist(name: "To Do List")
]
