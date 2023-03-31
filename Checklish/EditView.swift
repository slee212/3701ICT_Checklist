//
//  EditView.swift
//  Checklish
//
//  Created by Samuel Lee on 31/3/2023.
//

import SwiftUI

struct EditView: View {
    @Binding var title: String
    @State var displayTitle: String = ""
    @Environment(\.editMode) var editMode
    var body: some View {
        VStack {
            if(editMode?.wrappedValue == .active) {
                HStack {
                    Image(systemName: "square.and.pencil")
                    TextField("Input:",text: $displayTitle)
                    Button("Cancel") {
                        displayTitle = title
                    }
                }.onAppear {
                    displayTitle = title
                }.onDisappear{
                    title = displayTitle
                }
            }
        }
    }
}
