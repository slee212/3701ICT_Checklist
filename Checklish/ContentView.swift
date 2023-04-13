//
//  ContentView.swift
//  Checklish
//
//  Created by Samuel Lee on 23/3/2023.
//

import SwiftUI

struct ContentView: View {
    @Binding var model: DataModel // A binding property that represents a data model
    @State var myTitle = "My Lists" // A state property that holds the title of the view
    
    var body: some View {
        NavigationView() {
            VStack {
                EditView(item: $myTitle) // A custom view called EditView
                List {
                    ForEach(model.lists.enumerated().map { $0 }, id: \.element) { (index, p) in
                        // A list of items with a navigation link to a ListView for each item
                        NavigationLink(destination: ListView(clist: $model, count: index)) {
                            Text(p.name) // Display the name property of each item in the list
                        }
                    }
                    .onDelete { idx in
                        // Handle deletion of items in the list
                        model.lists.remove(atOffsets: idx)
                        model.save() // Save the updated data model
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
