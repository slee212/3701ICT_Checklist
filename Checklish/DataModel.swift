//
//  DataModel.swift
//  Checklish
//
//  Created by Samuel Lee on 31/3/2023.
//

import Foundation

/// Represents a checklist. Contains two properties, those being 'name' and 'tasks'. Furthermore, the Checklsit struct conforms to the Hashable and Codable protocols, with Hashable allowing it to be used as a key in a dictionary or as an element in a set, while Codable allows it to be encoded and decoded to and from JSON data.
struct Checklist: Hashable, Codable {
    /// Name of the checklist
    var name: String
    /// Array of tasks as strings
    var tasks: [[String]]
}

/// Returns a URL pointing to the location of the "mytasks.json" file. If the function fails to find the file, it will return 'nil'. This function is used in the load() function in the DataModel struct.
func getFile() -> URL? {
    let filename = "mytasks.json"
    let fm = FileManager.default
    guard let url = fm.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        .first else {
        return nil
    }
    return url.appendingPathComponent(filename)
}

/// Represents the data of the application. The DataModel struct contains an array of 'Checklist' objects, representing all the checklists in the app. The DataModel struct also contains methods for saving and loading checklists to and from a file, and initialises by loading from the file.
struct DataModel: Codable {
    /// Array of Checklist objects.
    var lists:[Checklist]
    /// Initialises an empty array of lists and then calles the load() function to load any saved checklists. If the load() function fails to find any saved data, it will load and set the 'lists' variable to a default set of checklists from 'testLists'.
    init () {
        lists = []
        load()    // Initialize the data model and load data from file
    }
    
    /// Attempts to load the checklists from the "mytasks.json" file retrieved in the getFile() function. If the file exists and can be decoded, the checklists are loaded from the file, otherwise, the function will load a default set of checklists ('testLists').
    mutating func load() {
        guard let url = getFile(),    // Get the URL of the file
              let data = try? Data(contentsOf: url),    // Read data from file
              let datamodel = try? JSONDecoder().decode(DataModel.self, from: data) else {
            self.lists = testLists    // If file doesn't exist or data cannot be decoded, use testLists as default
            return
        }
        self.lists = datamodel.lists    // Load checklists from decoded data
    }
    
    /// Encodes the data model to JSON data and saves it to the "mytasks.json" file retrieved in the getFile() function
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
