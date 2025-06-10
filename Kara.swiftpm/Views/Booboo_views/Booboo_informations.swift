//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Booboo_informations: View {
    
    //MARK: View properties
    @State private var showBoobooEdit : Bool = false
    @State private var boobooStateChanged : Bool = false
    @State private var showAttachmentViewer : Bool = false
    @State private var showAppointmentForm : Bool = false
    
    //MARK: Data properties
    @Bindable public var booboo : Booboo
    private var appointments : [Appointment] {
        booboo.appointments.sorted { $0.date > $1.date }
    }
    
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                
                HStack(spacing: 20) {
                    BodyPart_view(bodyPart: booboo.bodyPart)
                    
                    Booboo_small_edit_view(showBoobooEdit: $showBoobooEdit, booboo: booboo)
                }
                
                Booboo_attachments_preview(appointments: $booboo.appointments)
                
                Indicator_and_addButton(showForm: $showAppointmentForm, itemCount: booboo.appointments.count)
                
                footer()
                    .padding(.bottom, 100)
                
            }.padding()
        }
        .navigationTitle(booboo.wording)
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showAppointmentForm) {
            Appointment_form(user: booboo.user, booboo: booboo)
        }
        .fullScreenCover(isPresented: $showBoobooEdit) {
            Booboo_edit(booboo: $booboo)
        }
        .onChange(of: showAppointmentForm) { oldValue, newValue in
            if oldValue == true && newValue == false {
                print(booboo.appointments.count)
            }
        }
        
    }
    
    @ViewBuilder
    private func footer() -> some View {
        VStack {
            if booboo.appointments.isEmpty {
                Text("No appointment")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .hAlign(.center)
                    .padding(.top, 100)
            } else {
                ForEach(appointments) { appointment in
                    let index = appointments.firstIndex(where: {$0 == appointment})  ?? 0
                    Appointment_booboo_preview(appointment: appointment, appointmentIndex: appointments.count - index)
                }
            }
        }
    }
}
