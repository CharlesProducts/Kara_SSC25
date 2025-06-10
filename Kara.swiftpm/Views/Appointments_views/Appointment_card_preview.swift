//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct Appointment_card_preview: View {
    
    // MARK: Data properties
    @Bindable public var appointment: Appointment
    
    // MARK: View properties
    @State private var showAppointmentInformations : Bool = false
    
    // MARK: Functions
    private func getColorState(appointment: Appointment) -> Color {
        if appointment.isDone {
            return .app_green
        } else if appointment.date > Date() {
            return .app_yellow
        } else {
            return .app_red
        }
    }
    
    private enum DateInfo { case date, hour }
    
    private func writeDate (date: Date, dateInfo: DateInfo) -> String {
        let formater = DateFormatter()
        if dateInfo == .date {
            formater.dateStyle = .full
            formater.timeStyle = .none
        } else if dateInfo == .hour {
            formater.dateStyle = .none
            formater.timeStyle = .short
        }
        return formater.string(from: date).capitalized
    }
    
    public var body: some View {
        VStack {
            Button {
                showAppointmentInformations = true
            } label: {
                HStack {
                    // Picture
                    User_picture_in_shape(userPhotoData: appointment.booboo?.user?.profilePictureData, frameSize: 40, photoShape: .circle)
                    
                    //Text
                    VStack (alignment: .leading) {
                        Text(appointment.booboo!.wording)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(.app_black)
                        
                        
                        Text("\(writeDate(date: appointment.date, dateInfo: .date))")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .foregroundColor(.app_gray)
                    }
                    Spacer()
                    
                    //State
                    Circle()
                        .frame(width: 17, height: 17)
                        .foregroundColor(getColorState(appointment: appointment))
                        .padding(.trailing)
                }
            }
        }
        .sheet(isPresented: $showAppointmentInformations) {
            Appointment_informations(appointment: appointment, viewPath: .constant(NavigationPath()))
        }
    }
}
