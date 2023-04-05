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
            EditView(item: $listName)
            HStack {
                TextField("Add Items:", text: $newItem)
                Button(action: {
                    tempList.append([newItem, "xmark"])
                    newItem = ""
                }) {
                    Text("+")
                }
            }
            List {
                ForEach($tempList, id:\.self) {
                    $item in
                    HStack {
                        Text(item[0])
                        Spacer()
                        Image(systemName: "\(item[1])")
                    }.onTapGesture {
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
                    tempList.remove(atOffsets: idx)
                }
                .onMove { idx, i in
                    tempList.move(fromOffsets: idx, toOffset: i)
                }
            }
        }.navigationTitle("\(listName)")
            .navigationBarItems(
                leading:
                    Button(action: {
                        tempList = listItems
                    }) {
                        Text("Reset")
                    },
                trailing:
                    HStack {
                        Button(action: {
                            clist.lists[count].tasks = tempList
                            listItems = tempList
                            clist.save()
                        }) {
                            Text("Save")
                        }
                        EditButton()
                    }
            )
            .onAppear {
                listName = clist.lists[count].name
                listItems = clist.lists[count].tasks
                tempList = clist.lists[count].tasks
            }
            .onDisappear {
                clist.lists[count].name = listName
                clist.lists[count].tasks = listItems
            }
            .padding()
    }
}
