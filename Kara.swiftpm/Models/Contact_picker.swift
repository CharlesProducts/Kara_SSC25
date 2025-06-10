//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import ContactsUI

struct ContactPicker: UIViewControllerRepresentable {
    
    /// Allows access to the user's contact list to complete practitioner forms
    
    class Coordinator: NSObject, CNContactPickerDelegate {
        public var parent: ContactPicker

        init(parent: ContactPicker) {
            self.parent = parent
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            parent.contact = contact
        }

        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Environment(\.presentationMode) var presentationMode
    @Binding var contact: CNContact?

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {}
}
