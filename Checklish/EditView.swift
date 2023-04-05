//
//  EditView.swift
//  Checklish
//
//  Created by Samuel Lee on 31/3/2023.
//

import SwiftUI

struct EditView: View {
    @Binding var item: String
    @State var displayItem: String = ""
    @Environment(\.editMode) var editMode // Edit mode environment variable

    var body: some View {
        VStack {
            if(editMode?.wrappedValue == .active) { // Check if edit mode is active
                HStack {
                    Image(systemName: "square.and.pencil") // Edit mode icon
                    TextField("Input:",text: $displayItem) // Textfield to input item
                    Button("Cancel") {
                        displayItem = item // Cancel editing and revert to original item
                    }
                }
                .onAppear {
                    displayItem = item // Set display item to current item on appear
                }
                .onDisappear {
                    item = displayItem // Update original item with display item on disappear
                }
            }
        }
    }
}
