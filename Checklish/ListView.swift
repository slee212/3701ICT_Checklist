//
//  ListView.swift
//  Checklish
//
//  Created by Samuel Lee on 4/4/2023.
//

import SwiftUI

struct ListView: View {
    @Binding var clist: DataModel
    var count: Int
    @State var listName: String = ""
    @State var newItem: String = ""
    @State var listItems: [[String]] = []
    @State var tempList: [[String]] = []
    
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
                            print("\(item[0]) is checked")
                        } else {
                            item[1] = "checkmark"
                            print("\(item[0]) is not checked")
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
                    tempList = listItems
                }) {
                    Text("Reset")
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
