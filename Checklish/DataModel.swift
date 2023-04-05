//
//  DataModel.swift
//  Checklish
//
//  Created by Samuel Lee on 31/3/2023.
//

import Foundation

struct Checklist: Hashable, Codable {
    var name: String    // Name of the checklist
    var tasks: [[String]]    // Array of tasks
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
    var lists:[Checklist]    // Array of checklists
    init () {
        lists = []
        load()    // Initialize the data model and load data from file
    }
    
    mutating func load() {
        guard let url = getFile(),    // Get the URL of the file
              let data = try? Data(contentsOf: url),    // Read data from file
              let datamodel = try? JSONDecoder().decode(DataModel.self, from: data) else {
            self.lists = testLists    // If file doesn't exist or data cannot be decoded, use testLists as default
            return
        }
        self.lists = datamodel.lists    // Load checklists from decoded data
    }
    
    func save() {
        guard let url = getFile(),    // Get the URL of the file
              let data = try? JSONEncoder().encode(self) else {    // Encode data model as JSON data
            return
        }
        try? data.write(to: url)    // Write encoded data to file
    }
}

var testLists = [
    Checklist(name: "Groceries", tasks: [["Milk", "checkmark"], ["Eggs", "xmark"], ["Bacon", "xmark"], ["Coffee", "checkmark"]]),
    Checklist(name: "To Do List", tasks: [["Finish assignment", "xmark"], ["Go Shopping", "xmark"], ["Walk dog", "checkmark"], ["Work out", "checkmark"]])
]
