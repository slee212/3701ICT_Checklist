//
//  ListView.swift
//  Checklish
//
//  Created by Samuel Lee on 4/4/2023.
//

import SwiftUI

struct ListView: View {
    @Binding var clist: Checklist
    @State var listName: String = ""
    var body: some View {
        VStack {
            Text("Checklist name: \(listName)")
            EditView(item: $listName)
        }.navigationTitle("\(listName)")
            .navigationBarItems( trailing: EditButton())
            .onAppear {
                listName = clist.name
            }
            .onDisappear {
                clist.name = listName
            }
            .padding()
    }
}
