//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import EventKit
import _PhotosUI_SwiftUI

public struct Appointment_form: View {
    
    // MARK: Data properties
    @Environment(\.modelContext) private var modelContext
    @State private var automaticAppointmentsAddition : Bool = UserDefaults.standard.bool(forKey: "automaticAppointmentsAddition")
    
    @State private var user : User?
    @State private var booboo : Booboo?
    @State private var practitioner : Practitioner?
    @State private var photoData = [Data]()
    
    @State private var date : Date = Date()
    @State private var isDone : Bool = true
    @State private var comment : String?
    
    
    // MARK: View properties
    @Environment(\.dismiss) private var dismiss
    
    @State private var imageSelection = [PhotosPickerItem]()
    @FocusState private var commentFieldIsFocus : Bool
    @State private var showboobooChoice : Bool = false
    @State private var showAttachmentViewer : Bool = false
    @State private var showPractitionersList : Bool = false
    @State private var addToCalendar : Bool = false
    
    
    // MARK: Initialization
    public init(user: User? = nil, booboo: Booboo? = nil, practitioner: Practitioner? = nil) {
        self._user = State(initialValue: user)
        self._booboo = State(initialValue: booboo)
        self._practitioner = State(initialValue: practitioner)
    }
    
    // MARK: Functions
    private func saveAppointment() {
        
        guard let _ = user else {
            print("ERROR : NO BOOBOO SELECTED")
            dismiss()
            return
        }
        
        guard let booboo = booboo else {
            print("ERROR : NO BOOBOO SELECTED")
            dismiss()
            return
        }
        
        guard let practitioner = practitioner else {
            print("ERROR : NO BOOBOO SELECTED")
            dismiss()
            return
        }
        
        
        let appointment = Appointment(booboo: booboo, date: date, isDone: !isDone, comment: comment, practitioner: practitioner, attachmentsData: photoData)
        modelContext.insert(appointment)
        
        if automaticAppointmentsAddition {
            createCalendarEvent(appointment: appointment)
        } else {
            self.addToCalendar.toggle()
        }
        
        dismiss()
    }
    
    private func createCalendarEvent(appointment: Appointment) {
        
        CalendarManager.shared.requestAccess()
        let event = CalendarManager.shared.createEvent(appointment: appointment)
        if let event = event { CalendarManager.shared.addEvent(event: event.1) }
        dismiss()
    }
    
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack (spacing: 20) {
                header()
                    .padding(.bottom, 10)
                
                User_choice(userSelected: $user)
                    .padding(.top, 10)
                
                Booboo_choice(boobooSelected: $booboo, showSelection: $showboobooChoice)
                
                Practitioner_choice(practitionersSelected: $practitioner, showPractitionersList: $showPractitionersList)
                
                Form_date_hour_picker(text: "Start date", dateChoice: $date)
                
                Custom_selector_view(isOne: $isDone, leftTextButton: "Not done", rightTextButton: "Done")
                
                Appointment_attachments_preview(photoData: $photoData)
                    .padding(.top, 10)
                
                Comment(text: $comment.toUnwrapped(defaultValue: ""), isFocus: $commentFieldIsFocus)
                    .padding(.top, 10)
                
                footer()
                    .padding(.top, 10)
            }
            .padding()
        }
        .onChange(of: user) { oldValue, newValue in
            booboo = nil
            practitioner = nil
        }
        .overlay {
            VStack {
                if showPractitionersList {
                    Practitioners_popup_choice(userSelected: $user, practitionerChoice: $practitioner, showPopup: $showPractitionersList)
                        .shadow(radius: 10)
                } else if showboobooChoice {
                    Booboo_popup_choice(userSelected: $user, boobooChoice: $booboo, showPopup: $showboobooChoice)
                        .shadow(radius: 10)
                }
            }
        }
    }
    
    private func header() -> some View {
        HStack(alignment: .bottom) {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .font(.system(size: 16))
                    .foregroundColor(.app_dark_gray)
            }
            
            Spacer()
            
            Text("New appointment")
                .font(.system(size: 20))
                .foregroundColor(.app_dark_gray)
            
        }
        .padding(.top)
        .fontWeight(.bold)
    }
    
    private func footer() -> some View {
        Button {
            saveAppointment()
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.app_green)
                .frame(height: 70)
                .overlay {
                    Text("ADD")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.app_white)
                }
        }
        .disableWithOpacity(booboo == nil || practitioner == nil)
    }
}
