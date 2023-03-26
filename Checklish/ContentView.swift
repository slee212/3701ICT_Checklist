//
//  ContentView.swift
//  Checklish
//
//  Created by Samuel Lee on 23/3/2023.
//

import SwiftUI

var tasks = [["Monday: ", "Finish assignment", "checkmark"],
             ["Tuesday: ", "Go shopping", "checkmark"],
             ["Wednesday: ", "Do laundry", "xmark"]]

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("To Do List:")
            List {
                ForEach(tasks, id:\.self) {
                    task in
                    ListRowView(item: task)
                }
            }
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
                .frame(width:100)
            Text(item[1])
            Spacer()
            Image(systemName: item[2])
        }.onTapGesture {
            if(item[2] == "checkmark") {
                print("\(item[1]) is ticked")
            } else {
                print("\(item[1]) is not ticked")
            }
        }
    }
}
