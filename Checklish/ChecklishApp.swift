//
//  ChecklishApp.swift
//  Checklish
//
//  Created by Samuel Lee on 23/3/2023.
//

import SwiftUI

@main
/// The ChecklishApp struct creates an instancee of the DataModel class to provide storage for the application. Furthermore, it provides a way to initialise and manager the user interface of the application.
struct ChecklishApp: App {
    /// Creates a variable called model marked with the '@State' property, allowing the app to observe changes made to the DataModel and update the app accordingly.
    @State var model:DataModel = DataModel()
    var body: some Scene {
        WindowGroup {
            ContentView(model: $model)
        }
    }
}
