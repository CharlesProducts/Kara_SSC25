//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import EventKit

public final class CalendarManager: ObservableObject {
    
    /// Allows reading and writing to the user's calendar (for appointments)
    
    static public let shared = CalendarManager()
    private var eventStore = EKEventStore()

    public func requestAccess() {
        
        /// Request access to the calendar
        
        Task {
            if #unavailable(iOS 17) {
                do {
                    guard try await eventStore.requestAccess(to: .event) else {
                        print("The app doesn't have permission to access calendar data. Please grant the app access to Calendar in Settings.")
                        return
                    }
                } catch {
                    print(error.localizedDescription)
                    return
                }
            }
        }
    }
    
    public func createEvent(appointment: Appointment) -> (EKEventStore, EKEvent)? {
        
        /// Create the event for the given appointment
        
        let event = EKEvent(eventStore: eventStore)
        
        event.title = "Appointment - \(appointment.booboo!.wording)"
        event.startDate = appointment.date
        event.endDate = Calendar.current.date(byAdding: .hour, value: 1, to: appointment.date)!
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        let location = "\(appointment.practitioner.adress ?? "") \(appointment.practitioner.city ?? "") \(appointment.practitioner.country ?? "")"
        event.location = location.isEmpty ? nil : location
        
        event.notes = appointment.comment
        let alarmDate1 = Calendar.current.date(byAdding: .day, value: -1, to: appointment.date)!
        let alarmDate2 = Calendar.current.date(byAdding: .hour, value: -1, to: appointment.date)!
        event.alarms = [EKAlarm(absoluteDate: alarmDate1), EKAlarm(absoluteDate: alarmDate2)]
        
        return (eventStore, event)
    }
    
    public func addEvent(event: EKEvent) {
        
        /// Add the event to the calendar
        
        do {
            try eventStore.save(event, span: .thisEvent)
            print("Event saved successfully")
        } catch {
            print("Error saving event: \(error)")
        }
    }
    
    public func fetchEvents(for date: Date, boobooWording: String) -> String? {
        
        /// Search for appointments for a given booboo
        
        var components = DateComponents()
        components.day = 1
        let endDate = Calendar.current.date(byAdding: components, to: date)!

        let predicate = eventStore.predicateForEvents(withStart: date, end: endDate, calendars: nil)
        let events = eventStore.events(matching: predicate)
        
        let bestResult = events.first(where: {$0.title.contains("Appointment - \(boobooWording)")})
        return bestResult?.eventIdentifier
    }
    
    public func modifyEvent(eventIdentifier: String, appointmentChanged: Appointment) {
        
        /// Modify an appointment in the calendar
        
        guard let event = eventStore.event(withIdentifier: eventIdentifier) else {
            print("Event not found")
            return
        }

        event.title = "Appointment - \(appointmentChanged.booboo!.wording)"
        event.startDate = appointmentChanged.date
        event.endDate = Calendar.current.date(byAdding: .hour, value: 1, to: appointmentChanged.date)!
        
        let location = "\(appointmentChanged.practitioner.adress ?? "") \(appointmentChanged.practitioner.city ?? "") \(appointmentChanged.practitioner.country ?? "")"
        event.location = location.isEmpty ? nil : location
        
        event.notes = appointmentChanged.comment
        
        self.addEvent(event: event)
    }
    
    public func deleteEvent(eventIdentifier: String) {
        
        /// Deletes an appointment present in the calendar
        
        guard let event = eventStore.event(withIdentifier: eventIdentifier) else {
            print("Event not found")
            return
        }
        
        do {
            try eventStore.remove(event, span: .thisEvent)
            print("Event deleted successfully")
        } catch {
            print("Error deleting event: \(error)")
        }
    }
}
