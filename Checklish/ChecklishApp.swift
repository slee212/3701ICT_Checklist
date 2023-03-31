//
//  ChecklishApp.swift
//  Checklish
//
//  Created by Samuel Lee on 23/3/2023.
//

import SwiftUI

@main
struct ChecklishApp: App {
    @State var model:DataModel = DataModel(tasks: testTasks)
    var body: some Scene {
        WindowGroup {
            ContentView(model: $model)
        }
    }
}
