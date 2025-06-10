//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct Appointment_preview: View {
    
    //MARK: Data properties
    @Environment(\.modelContext) private var modelContext
    @Binding public var viewPath : NavigationPath
    @Bindable public var appointment : Appointment
    
    
    //MARK: View properties
    @State private var showAppointmentInformation : Bool = false
    @State private var showDeleteAlert : Bool = false
    private var borderColor : Color {
        if appointment.isDone {
            return .app_light_gray
        } else if appointment.date > Date() {
            return .app_yellow
        } else {
            return .app_red
        }
    }
    
    
    //MARK: Functions
    private enum DateInfo {
        case day, date, hour
    }
    
    private func writeDate (dateInfo: DateInfo) -> String {
        let formater = DateFormatter()
        if dateInfo == .day {
            return formater.weekdaySymbols[Calendar.current.component(.weekday, from: appointment.date) - 1].capitalized
        } else if dateInfo == .date {
            formater.dateStyle = .short
            formater.timeStyle = .none
        } else if dateInfo == .hour {
            formater.dateStyle = .none
            formater.timeStyle = .short
        }
        return formater.string(from: appointment.date)
    }
    
    private func deleteAppointment() {
        modelContext.delete(appointment)
    }
    
    
    public var body: some View {
        HStack {
            User_picture_in_shape(userPhotoData: appointment.booboo?.user?.profilePictureData, frameSize: 55, photoShape: .square)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(appointment.booboo!.wording)
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(.app_black)
                
                Text(appointment.practitioner.fullName)
                .font(.system(size: 13))
                .fontWeight(.semibold)
                .foregroundColor(.app_gray)
            }
            
            Spacer()
            
            VStack {
                Text(writeDate(dateInfo: .day))
                Text(writeDate(dateInfo: .date))
                Text(writeDate(dateInfo: .hour))
            }
            .font(.system(size: 13))
            .fontWeight(.semibold)
            .foregroundColor(.app_gray)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
        .fillClearView(borderColor)
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
        .sheet(isPresented: $showAppointmentInformation) {
            Appointment_informations(appointment: appointment, viewPath: $viewPath)
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(title: Text("Delete this appointment ?"),
                  primaryButton: Alert.Button.destructive(Text("Yes"), action: deleteAppointment),
                  secondaryButton: Alert.Button.default(Text("No")))
        }
    }
}
