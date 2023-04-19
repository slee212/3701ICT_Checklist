//
//  ContentView.swift
//  Checklish
//
//  Created by Samuel Lee on 23/3/2023.
//

import SwiftUI
/// The structure that creates the view the content is housed in. The main menu screen. Contains a list of checklists retrieved from the DataModel using a SwiftUI 'List'. Furthermore, the ContentView makes use of a NavigationView to add a title, alongside navigation buttons. On the ContentView page, there are buttons for adding a new list and editing the current list. Ultimately, the ContentView serves as the primary user interface for the application.
struct ContentView: View {
    /// A binding property that represents a data model
    @Binding var model: DataModel
    /// A state property that holds the title of the view
    @State var myTitle = "My Lists"
    
    /// The body of the page, where the actual content is housed.
    var body: some View {
        NavigationView() {
            VStack {
                EditView(item: $myTitle) // A custom view called EditView
                List {
                    // A list of items with a navigation link to a ListView for each item
                    ForEach(model.lists.enumerated().map { $0 }, id: \.element) { (index, p) in
                        NavigationLink(destination: ListView(clist: $model, count: index)) {
                            Text(p.name) // Display the name property of each item in the list
                        }
                    }
                    .onDelete { idx in
                        // Handle deletion of items in the list
                        model.lists.remove(atOffsets: idx)
                        // Save the updated data model
                        model.save()
                    }
                    .onMove { idx, i in
                        // Move the item from one index to another when dragged and dropped
                        model.lists.move(fromOffsets: idx, toOffset: i)
                        model.save()
                    }
                }.navigationTitle(myTitle) // Set the navigation title to the value of myTitle
                    .navigationBarItems(leading: EditButton(), trailing: Button("+"){
                    // Add a button to add a new placeholder item to the list
                    model.lists.append(Checklist(name: "New List", tasks: [["New Task", "xmark"]]))
                    model.save()
                })
            }
        }
        .padding()
    }
}
