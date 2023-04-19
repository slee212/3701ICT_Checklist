//
//  ListView.swift
//  Checklish
//
//  Created by Samuel Lee on 4/4/2023.
//

import SwiftUI

/// The ListView struct is a view that displays a list of items that can be checked and unchecked. Specifically, the list of items is an in-depth look at the list selected on the main ContentView. Similar to the ContentView, the ListView utilises a Navigation bar to house buttons for functionality, those being the Reset / Undo button which alternate upon being pressed, a save button and an edit button. Upon pressing the edit button, the ListView uses an EditView to allow the deletion and moving of list items. Ultimately, the ListView is a detailed view of a checklist.
struct ListView: View {
    /// A binding to the DataModel containing the stored data for the application.
    @Binding var clist: DataModel
    /// A simple integer representing an index of the current list being displayed.
    var count: Int
    /// A string representing the name of the current list.
    @State var listName: String = ""
    /// A string representing the name of a new item being added to the list.
    @State var newItem: String = ""
    /// An array of strings representing the items in the list with the first object in the list being the name and second being the status ("checkmark" or "xmark").
    @State var listItems: [[String]] = []
    /// A temporary copy of the 'listItems' array used for making changes that are yet to be saved.
    @State var tempList: [[String]] = []
    /// State variable for checking if items are checked or not
    @State var isTicked: Bool = false
    
    /// The body of the page, where the actual content is housed.
    var body: some View {
        VStack {
            // EditView for setting the list name
            EditView(item: $listName)
            
            HStack {
                // TextField for adding new items to the list
                TextField("Add Items:", text: $newItem)
                
                // Button for adding new items to the list
                Button(action: {
                    tempList.append([newItem, "xmark"])
                    newItem = ""
                }) {
                    Text("+")
                }
            }
            
            // List view for displaying the items in the list
            List {
                ForEach($tempList, id:\.self) { $item in
                    HStack {
                        // Display the item name and a system image based on its status (checkmark or xmark)
                        Text(item[0])
                        Spacer()
                        Image(systemName: "\(item[1])")
                    }
                    .onTapGesture {
                        // Toggle the status of the item when tapped
                        if(item[1] == "checkmark") {
                            item[1] = "xmark"
                        } else {
                            item[1] = "checkmark"
                        }
                    }
                }
                .onDelete { idx in
                    // Delete the item at the specified index when swipe deleted
                    tempList.remove(atOffsets: idx)
                }
                .onMove { idx, i in
                    // Move the item from one index to another when dragged and dropped
                    tempList.move(fromOffsets: idx, toOffset: i)
                }
            }
        }
        .navigationTitle("\(listName)")
        .navigationBarItems(
            leading:
                // Button for resetting the list to its original state
                Button(action: {
                    if isTicked {
                        tempList = listItems // Reset the temporary list to the original list items
                        isTicked.toggle()
                    } else {
                        listItems = tempList // Update the original list items with the changes made in the temporary list
                        tempList = tempList.map{ [$0[0], "xmark"] } // Reset the temporary list to default status "xmark"
                        isTicked.toggle()
                    }
                }) {
                    Text(isTicked ? "Reset" : "Undo")
                },
            trailing:
                HStack {
                    // Button for saving the changes made to the list
                    Button(action: {
                        clist.lists[count].tasks = tempList
                        listItems = tempList
                        clist.save()
                    }) {
                        Text("Save")
                    }
                    // EditButton for enabling edit mode in the list
                    EditButton()
                }
        )
        .onAppear {
            // Load the list name and items from the DataModel when the view appears
            listName = clist.lists[count].name
            listItems = clist.lists[count].tasks
            tempList = clist.lists[count].tasks
        }
        .onDisappear {
            // Save the list name and items to the DataModel when the view disappears
            clist.lists[count].name = listName
            clist.lists[count].tasks = listItems
        }
        .padding()
    }
}
