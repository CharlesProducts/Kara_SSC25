//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import EventKit
import SwiftData

public struct Appointment_informations: View {
    
    //MARK: Data properties
    @Bindable public var appointment : Appointment
    
    
    //MARK: View properties
    @Environment(\.dismiss) private var dismissSheet
    @Binding var viewPath : NavigationPath
    public var showBoobooButton : Bool = true
    
    @State private var showAppointmentEdit : Bool = false
    @State private var showAppointmentForm : Bool = false
    @State private var addToCalendar : Bool = false
    @State private var showBoobooInformations : Bool = false
    
    
    //MARK: Functions
    private func getCalendarData() -> (EKEventStore, EKEvent) {
        let store = EKEventStore()
        Task {
            if #unavailable(iOS 17) {
                do {
                    guard try await store.requestAccess(to: .event) else {
                        print("The app doesn't have permission to access calendar data. Please grant the app access to Calendar in Settings.")
                        return
                    }
                } catch {
                    print(error.localizedDescription)
                    return
                }
            }
        }
        // Create the event
        let event = EKEvent(eventStore: store)
        event.title = "Appointment - \(appointment.booboo!.wording)"
        event.startDate = appointment.date
        event.endDate = Calendar.current.date(byAdding: .hour, value: 1, to: appointment.date)!
        event.location = "\(appointment.practitioner.adress ?? "") \(appointment.practitioner.city ?? "") \(appointment.practitioner.country ?? "")"
        event.notes = appointment.comment
        let alarmDate1 = Calendar.current.date(byAdding: .day, value: -1, to: appointment.date)!
        let alarmDate2 = Calendar.current.date(byAdding: .hour, value: -1, to: appointment.date)!
        event.alarms = [EKAlarm(absoluteDate: alarmDate1), EKAlarm(absoluteDate: alarmDate2)]
        
        return (store, event)
    }
    
    public var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack (spacing: 20) {
                    header()
                    
                    HStack {
                        Text(appointment.isDone ? "Done" : "Not done")
                            .font(.system(size: 13))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.app_black)
                            .padding(.vertical, 5)
                            .hAlign(.center)
                            .fillView(appointment.isDone ? .app_green : .app_yellow)
                        
                        Button(action: {
                            withAnimation(.easeInOut) {
                                appointment.isDone.toggle()
                            }
                        }, label: {
                            Text(appointment.isDone ? "Mark as uncompleted" : "Mark as completed")
                                .font(.system(size: 13))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.app_white)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 30)
                                .fillView(.app_dark_gray)
                        })
                    }
                    
                    divider()
                    
                    Practitioner_preview(practitioner: appointment.practitioner, appointmentDate: $appointment.date)
                    
                    Practitioner_adress_preview(practitioner: appointment.practitioner)
                    
                    divider()
                    
                    Appointment_attachments_preview(photoData: $appointment.attachmentsData, textBackground: .app_light_purple)
                    
                    if let comment = appointment.comment {
                        Text("Comment :")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.app_dark_gray)
                            .hAlign(.leading)
                            .padding(.top, 5)
                        
                        Text(comment)
                            .font(.system(size: 13))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.app_gray)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10)
                            .hAlign(.leading)
                    } else {
                        Text("No comments added")
                            .font(.system(size: 13))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.app_gray)
                            .padding(.vertical, 20)
                    }
                    
                    footer()
                    
                }
                .padding()
            }
            .background(Color.app_light_purple)
            .fullScreenCover(isPresented: $showAppointmentForm) {
                Appointment_form(user: appointment.booboo?.user, booboo: appointment.booboo, practitioner: appointment.practitioner)
            }
            .fullScreenCover(isPresented: $showAppointmentEdit) {
                Appointment_edit(appointment: $appointment)
            }
            .sheet(isPresented: $addToCalendar, content: {
                let calendarData = self.getCalendarData()
                EventEditViewController(event: calendarData.1, eventStore: calendarData.0)
            })
        }
    }
    
    @ViewBuilder
    private func header() -> some View {
        HStack {
            Button(action: {
                showAppointmentEdit.toggle()
            }, label: {
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.app_black)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 25)
                    .fillView(.app_white)
            })
            
            Text("Your appointment")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundStyle(Color.app_gray)
                .hAlign(.center)
            
            Button(action: {
                dismissSheet()
            }, label: {
                Text("OK")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.app_black)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 25)
                    .fillView(.app_white)
            })
        }
    }
    
    @ViewBuilder
    func divider() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .padding(.horizontal)
            .frame(height: 1, alignment: .center)
            .foregroundColor(.app_light_gray)
    }
    
    @ViewBuilder
    private func footer() -> some View {
        VStack {
            // Top buttons
            HStack {
                Button(action: {
                    showAppointmentForm.toggle()
                }, label: {
                    Text("Reschedule the appointment")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.app_white)
                        .padding(.all)
                        .hAlign(.center)
                        .frame(height: 52)
                        .fillView(.app_green)
                })
                
                Button(action: {
                    self.addToCalendar = true
                }, label: {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 32, height: 30)
                        .foregroundStyle(Color.app_dark_gray)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                        .frame(height: 52)
                        .fillView(.app_yellow)
                })
            }
            
            if showBoobooButton {
                
                NavigationLink {
                    Booboo_informations(booboo: appointment.booboo!)
                } label: {
                    Text("Access the boo-boo")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.app_white)
                        .padding(.all)
                        .hAlign(.center)
                        .frame(height: 52)
                        .fillView(.app_dark_gray)
                }
                .padding(.top, 5)
            }
        }
    }
    
}
