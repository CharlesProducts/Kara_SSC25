//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct NextAppointmentsCardView: View {
    
    // MARK: View properties
    private let title : String
    private let maxHeight : CGFloat
    
    @State private var showAppointmentInformation : Bool = false
    @State private var appointmentToShow : Appointment?
    
    // MARK: Data properties
    private let userFilter : String
    private let appointmentFilter : NextAppointmentsFilter
    
    @Query(sort: \Appointment.date, order: .forward) private var appointmentsQuery: [Appointment]
    private var filteredAppointments: [Appointment] {
        switch appointmentFilter {
        case .currentWeek:
            if userFilter == "Everyone" {
                return appointmentsQuery.filter { appointment in
                    Date.isInCurrentWeek(date: appointment.date)
                }
            } else {
                return appointmentsQuery.filter { appointment in
                    appointment.booboo!.user!.firstName == userFilter && Date.isInCurrentWeek(date: appointment.date)
                }
            }
        case .nextWeek:
            if userFilter == "Everyone" {
                return appointmentsQuery.filter { appointment in
                    Date.isInCurrentWeek(offset: 1, date: appointment.date)
                }
            } else {
                return appointmentsQuery.filter { appointment in
                    appointment.booboo!.user!.firstName == userFilter && Date.isInCurrentWeek(offset: 1, date: appointment.date)
                }
            }
        case .all:
            if userFilter == "Everyone" {
                return appointmentsQuery.filter { appointment in
                    appointment.date > Date()
                }
            } else {
                return appointmentsQuery.filter { appointment in
                    appointment.booboo!.user!.firstName == userFilter && appointment.date > Date()
                }
            }
        }
    }
    
    
    // MARK: Initializer
    public init(title: String, maxHeight: CGFloat, userFilter: String, appointmentFilter: NextAppointmentsFilter) {
        self.title = title
        self.maxHeight = maxHeight
        self.userFilter = userFilter
        self.appointmentFilter = appointmentFilter
    }
    
    
    public var body: some View {
        VStack {
            if !filteredAppointments.isEmpty {
                GeometryReader { proxy in
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack {
                            ForEach(filteredAppointments) { appointment in
                                VStack(spacing: 12) {
                                    
                                    Appointment_card_preview(appointment: appointment)
                                    
                                    // Divider
                                    if appointment != filteredAppointments.last {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: proxy.size.width/2, height: 1.5, alignment: .center)
                                            .foregroundColor(.app_gray)
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                Text("No appointment")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .hAlign(.center)
            }
        }
        .frame(height: maxHeight - 15)
        .padding(.top, 8)
        .padding(.horizontal, 8)
        .containerRelativeFrame(.horizontal)
        .background_title(text: title, height: Float(maxHeight), isBold: true)
    }
}

