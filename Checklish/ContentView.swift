//
//  ContentView.swift
//  Checklish
//
//  Created by Samuel Lee on 23/3/2023.
//

import SwiftUI

var tasks = [["Mon", "Finish assignment", "checkmark"],
             ["Tue", "Go shopping", "checkmark"],
             ["Wed", "Wash, fold and put away laundry", "xmark"],
             ["Wed", "Study for upcoming exam", "xmark"]]

struct ContentView: View {
    @Binding var model: DataModel
    @State var myTitle = "My Lists"
    var body: some View {
        NavigationView() {
            VStack {
                EditView(item: $myTitle)
                List {
                    ForEach($model.lists, id:\.self) {
                        $p in
                        
                        NavigationLink(destination: ListView(clist: $p)) {
                            Text(p.name)
                        }
//                    ForEach(model.tasks, id:\.self) {
//                        p in
//                        HStack{
//                            Text(p.day)
//                                .frame(width:50)
//                            Divider()
//                            Text(p.task)
//                        }
                    }.onDelete { idx in
                        model.lists.remove(atOffsets: idx)
                        model.save()
                    }.onMove { idx, i in
                        model.lists.move(fromOffsets: idx, toOffset: i)
                        model.save()
                    }
                    //                ForEach(tasks, id:\.self) {
                    //                    task in
                    //                    ListRowView(item: task)
                    //                }
                }.navigationTitle(myTitle)
                    .navigationBarItems( trailing: Button("+"){
                        model.lists.append(Checklist(name: "New List"))
                        model.save()
                    })
            }
        }
        .padding()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

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
