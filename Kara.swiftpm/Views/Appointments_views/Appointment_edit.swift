//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Appointment_edit: View {
    
    // MARK: Data properties
    @Bindable public var appointment : Appointment
    
    @State private var user : User?
    @State private var booboo : Booboo?
    @State private var practitioner : Practitioner?
    @State private var attachmentsData = [Data]()
    @State private var date : Date = Date()
    @State private var isDone : Bool = false
    @State private var comment : String?
    
    
    // MARK: View properties
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var commentFieldIsFocus : Bool
    @State private var showBoobooChoice : Bool = false
    @State private var showPractitionersList : Bool = false
    @State private var showAttachmentViewer : Bool = false
    
    
    // MARK: Initialization
    public init(appointment: Bindable<Appointment>) {
        self._appointment = appointment
    }
    
    
    // MARK: Functions
    private func saveAppointment() {
        
        // Change event in calendar
        CalendarManager.shared.requestAccess()
        let eventIdentifier = CalendarManager.shared.fetchEvents(for: date, boobooWording: booboo!.wording)
        
        saveChanges()
        appointment.booboo!.modificationDate = Date()
        
        if let eventIdentifier = eventIdentifier {
            CalendarManager.shared.modifyEvent(eventIdentifier: eventIdentifier, appointmentChanged: appointment)
        }
        
        dismiss()
    }
    
    private func copyOriginalAppointment() {
        user = appointment.booboo!.user
        booboo = appointment.booboo
        practitioner = appointment.practitioner
        attachmentsData = appointment.attachmentsData
        date = appointment.date
        isDone = appointment.isDone
        comment = appointment.comment
    }
    
    private func saveChanges() {
        
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
        
        appointment.booboo = booboo
        appointment.practitioner = practitioner
        appointment.attachmentsData = attachmentsData
        appointment.date = date
        appointment.isDone = isDone
        appointment.comment = comment
    }
    
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack (spacing: 20) {
                header()
                    .padding(.bottom, 10)
                
                User_choice(userSelected: $user)
                    .padding(.top, 10)
                
                showBooboo()
                    .padding(.top, 10)
                
                Practitioner_choice(practitionersSelected: $practitioner, showPractitionersList: $showPractitionersList)
                    
                Form_date_hour_picker(text: "Start date", dateChoice: $date)
                
                Custom_selector_view(isOne: $isDone, leftTextButton: "Done", rightTextButton: "Not done")
                
                Appointment_attachments_preview(photoData: $attachmentsData)
                    .padding(.top, 10)
                
                Comment(text: $comment.toUnwrapped(defaultValue: ""), isFocus: $commentFieldIsFocus)
                    .padding(.top, 10)
                
                footer()
                    .padding(.top, 10)
            }
            .padding()
        }
        .onAppear(perform: copyOriginalAppointment)
        .overlay {
            VStack {
                if showPractitionersList {
                    Practitioners_popup_choice(userSelected: $user, practitionerChoice: $practitioner, showPopup: $showPractitionersList)
                        .shadow(radius: 10)
                    
                } else if showBoobooChoice {
                    Booboo_popup_choice(userSelected: $user, boobooChoice: $booboo, showPopup: $showBoobooChoice)
                        .shadow(radius: 10)
                }
            }
        }
    }
    
    @ViewBuilder
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
            
            Text("Edit appointment")
                .font(.system(size: 20))
                .foregroundColor(.app_dark_gray)

        }
        .padding(.top)
        .fontWeight(.bold)
    }
    
    @ViewBuilder
    private func showBooboo() -> some View {
        HStack {
            Image(uiImage: UIImage(named: "broken_bone.png") ?? UIImage(named: "snowboard")!)
                .resizable()
                .scaledToFit()
                .frame(height: 45.0)
                .padding(5)
            
            Text(appointment.booboo!.wording)
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .foregroundStyle(Color.app_black)
                .lineLimit(2)
                .hAlign(.leading)
        }
        .padding()
        .frame(height: 75)
        .fillView(.app_yellow)
    }
    
    @ViewBuilder
    private func footer() -> some View {
        Button {
            saveAppointment()
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.app_green)
                .frame(height: 70)
                .overlay {
                    Text("SAVE")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.app_white)
                }
        }
        .disableWithOpacity(user == nil || booboo == nil || practitioner == nil)
    }
}
