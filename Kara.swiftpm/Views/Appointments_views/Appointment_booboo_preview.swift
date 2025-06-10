//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Appointment_booboo_preview: View {
    
    //MARK: Data properties
    @Environment(\.modelContext) private var modelContext
    @Bindable public var appointment : Appointment
    
    private var stringDate : String {
        let unformattedDate : Date = appointment.date
        let date : String = unformattedDate.formatted(date: .numeric, time: .omitted)
        let time : String = unformattedDate.formatted(date: .omitted, time: .shortened)
        return "\(date) at \(time)"
    }
    
    
    //MARK: View properties
    @State private var viewPath = NavigationPath()
    @State private var showAppointmentInformation : Bool = false
    @State private var showDeleteAlert : Bool = false
    let appointmentIndex : Int
    
    
    //MARK: Functions
    private func deleteAppointment() {
        modelContext.delete(appointment)
    }
    
    
    public var body: some View {
        HStack {
            indexView()
            
            VStack (alignment: .leading, spacing: 5) {
                HStack(spacing: 0) {
                    Text(appointment.practitioner.fullName)
                }
                .font(.system(size: 24))
                .foregroundStyle(Color.app_black)
                .lineLimit(2)
                
                Text("\(stringDate)")
                    .font(.system(size: 13))
                    .foregroundColor(.app_gray)
                
            }.fontWeight(.semibold)
                .hAlign(.leading)
            
            itemInfo()
            
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
        .fillClearView(appointment.isDone ? .app_light_gray : .app_yellow)
        .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 15.0))
        .onTapGesture {
            showAppointmentInformation.toggle()
        }
        .contextMenu {
            Group {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    showDeleteAlert = true
                }
            }
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(title: Text("Delete this appointment?"),
                  primaryButton: Alert.Button.destructive(Text("Yes"), action: deleteAppointment),
                  secondaryButton: Alert.Button.default(Text("No")))
        }
        .sheet(isPresented: $showAppointmentInformation) {
            Appointment_informations(appointment: appointment, viewPath: $viewPath)
        }
    }
    
    @ViewBuilder
    private func indexView() -> some View {
        HStack(alignment: .top, spacing: 2) {
            Text("n°")
                .font(.system(size: 16))
                .padding(.top, 5)
            
            Text("\(appointmentIndex)")
                .font(.system(size: 36))
                
            
        }.fontWeight(.semibold)
        .foregroundColor(.app_gray)
    }
    
    @ViewBuilder
    private func itemInfo() -> some View {
        HStack (alignment: .center, spacing: 15) {

            if !appointment.attachmentsData.isEmpty {
                HStack(spacing: 0) {
                    Text("\(appointment.attachmentsData.count)")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.app_black)
                    
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .frame(width: 45, height: 37)
                        .foregroundColor(appointment.isDone ? .app_light_gray : .app_yellow)
                }
            }
            
            if appointment.comment != nil {
                Image(systemName: "text.alignright")
                    .resizable()
                    .frame(width: 35, height: 30)
                    .foregroundColor(appointment.isDone ? .app_light_gray : .app_yellow)
            }
        }
    }
}
