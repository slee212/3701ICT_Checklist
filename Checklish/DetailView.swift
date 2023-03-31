//
//  DetailView.swift
//  Checklish
//
//  Created by Samuel Lee on 31/3/2023.
//

import SwiftUI

struct DetailView: View {
    @Binding var item: Item
    @State var iday: String = ""
    @State var itask: String = ""
    var body: some View {
        VStack {
            Text("Day: \(iday)")
            EditView(title: $iday)
            Divider()
            Text("Task: \(itask)")
            EditView(title: $itask)
            Spacer()
            
        }.navigationTitle("Edit Task")
            .navigationBarItems(trailing: EditButton())
            .onAppear{
                iday = item.day
                itask = item.task
            }
            .onDisappear{
                item.day = iday
                item.task = itask
            }
            .padding()
    }
}

