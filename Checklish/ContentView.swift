//
//  ContentView.swift
//  Checklish
//
//  Created by Samuel Lee on 23/3/2023.
//

import SwiftUI

var tasks = [["Mon", "Finish assignment", "checkmark"],
             ["Tue", "Go shopping", "checkmark"],
             ["Wed", "Wash, fold and put away laundry", "xmark"]]

struct ContentView: View {
    var body: some View {
        NavigationView() {
            List {
                ForEach(tasks, id:\.self) {
                    task in
                    ListRowView(item: task)
                }
            }.navigationTitle("To Do List")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ListRowView: View {
    var item:[String]
    var body: some View {
        HStack{
            Text(item[0])
                .frame(width:50)
            Divider()
                .overlay(.black)
            Text(item[1])
            Spacer()
            Image(systemName: item[2])
        }.onTapGesture {
            if(item[2] == "checkmark") {
                print("\(item[1]) is completed")
            } else {
                print("\(item[1]) is not completed")
            }
        }
    }
}
