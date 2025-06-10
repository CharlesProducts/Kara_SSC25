//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import EventKit
import EventKitUI

struct EventEditViewController : UIViewControllerRepresentable {
    
    /// Allows you to select a contact from the user's contacts.
    
    @Environment(\.presentationMode) var presentationMode
    typealias UIViewControllerType = EKEventEditViewController
    
    let event: EKEvent?
    let eventStore: EKEventStore
    
    /// Create an event edit view controller, then configure it with the specified event and event store.
    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let controller = EKEventEditViewController()
        controller.eventStore = eventStore
        controller.event = event
        controller.editViewDelegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: EKEventEditViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator { return Coordinator(self) }
    
    class Coordinator: NSObject, EKEventEditViewDelegate {
        var parent: EventEditViewController
        
        init(_ controller: EventEditViewController) {
            self.parent = controller
        }
        
        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

