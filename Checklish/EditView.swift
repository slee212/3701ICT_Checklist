//
//  EditView.swift
//  Checklish
//
//  Created by Samuel Lee on 31/3/2023.
//

import SwiftUI

/// The EditView struct is a view component that displays an editable text field alongside a cancel button. Furthermore, the EditView makes use of the editMode environment variable to determine whether edit mode is currently active. If edit mode is actuve, the view shows the text field along with the cancel button and edit mode icon. Ultimately, the EditView allows the user to edit an item.
struct EditView: View {
    /// A binding variable representing the text of the item being edited
    @Binding var item: String
    /// A state variable representing the text to be displayed in the edit mode text field. Initially this string is empty.
    @State var displayItem: String = ""
    /// An environment variable called editMode. This is provided by SwiftUI and is used to determing whether edit mode is active.
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
