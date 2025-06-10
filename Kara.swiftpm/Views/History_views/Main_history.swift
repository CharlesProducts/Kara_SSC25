//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct Main_history: View {
    
    // MARK: View properties
    @Binding public var tutorialStep : Int
    @State public var viewPath = NavigationPath()
    
    @State private var showBoobooHistory : Bool = false
    @State private var search_text : String = ""
    @State private var userSelected : String = "Everyone"
    
    private let screenSize = UIScreen.main.bounds.size
    
    
    // MARK: Data properties
    @Query(sort: \Appointment.date, order: .reverse) private var appointmentsQuery: [Appointment]
    private var appointments : [Appointment] {
        
        if userSelected == "Everyone" {
            
            if search_text.isEmpty {
                return appointmentsQuery
            } else {
                return appointmentsQuery.filter { appointment in
                    appointment.booboo!.wording.localizedStandardContains(search_text) ||
                    appointment.practitioner.fullName.localizedStandardContains(search_text) ||
                    appointment.date.formatted(date: .numeric, time: .standard).localizedStandardContains(search_text) ||
                    appointment.date.formatted(date: .complete, time: .omitted).localizedStandardContains(search_text)
                }
                
            }
        } else {
            
            if search_text.isEmpty {
                return appointmentsQuery.filter { appointment in
                    appointment.booboo!.user!.firstName == userSelected
                }
            } else {
                return appointmentsQuery.filter { appointment in
                    (appointment.booboo!.user!.firstName == userSelected) &&
                    (appointment.booboo!.wording.localizedStandardContains(search_text) ||
                     appointment.practitioner.fullName.localizedStandardContains(search_text) ||
                     appointment.date.formatted(date: .numeric, time: .standard).localizedStandardContains(search_text) ||
                     appointment.date.formatted(date: .complete, time: .omitted).localizedStandardContains(search_text))
                }
            }
            
        }
        
    }
    
    
    // MARK: Init
    public init(tutorialStep: Binding<Int>) {
        self._tutorialStep = tutorialStep
    }
    
    
    //MARK: Functions
    private func getStringDate(with date: Date) -> String {
        return date.formatted(date: .complete, time: .complete)
    }
    
    public var body: some View {
        NavigationStack(path: $viewPath) {
            ZStack {
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVStack(spacing: 25) {
                        
                        header()
                        
                        Search_bar(searchText: $search_text)
                        
                        if search_text == "" {
                            Booboo_recent_preview(path: $viewPath, userSelected: userSelected)
                            
                            History_alert(userSelected: userSelected)
                        }
                        
                        footer()
                            .padding(.bottom, 100)
                    }
                    .padding()
                }
                .navigationTitle("History")
                .toolbar(.hidden, for: .automatic)
                .navigationDestination(for: Int.self, destination: { _ in
                    Booboo_history(viewPath: $viewPath, userSelected: userSelected)
                })
                .navigationDestination(for: Booboo.self) { booboo in
                    Booboo_informations(booboo: booboo)
                }
                
                tutorialStepView()
            }
            .ignoresSafeArea()
        }
    } 
    
    @ViewBuilder
    private func header() -> some View {
        HStack {
            Text("History")
                .font(.system(size: 40, weight: .heavy))
            
            User_choice_button(userSelected: $userSelected)
                .hAlign(.trailing)
        }
    }
    
    @ViewBuilder
    private func footer() -> some View {
        VStack {
            Text("All your appointments")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(.app_dark_gray)
                .hAlign(.leading)
            
            if appointments.isEmpty {
                Text("No appointment")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .hAlign(.center)
                    .padding(.top, 50)
                
            } else {
                ForEach(appointments) { appointment in
                    Appointment_preview(viewPath: $viewPath, appointment: appointment)
                }
            }
        }
    }
    
    @ViewBuilder
    private func tutorialStepView() -> some View {
        
        if tutorialStep == 4 {
            Tutorial_window_view(text: "Here you can find the boo-boos you have recently modified as well as all the others by clicking on the arrow", tutorialStep: $tutorialStep, window_rect: CGRect(x: 5, y: 150, width: screenSize.width - 10, height: screenSize.height/4.8))
        } else if tutorialStep == 5 {
            Tutorial_window_view(text: "Then, here, all the appointments that you have entered", tutorialStep: $tutorialStep, window_rect: CGRect(x: 5, y: screenSize.height/2.35, width: screenSize.width - 10, height: screenSize.height))
        } else if tutorialStep == 6 {
            Tutorial_window_view(text: "You can also filter by profile for ease of use.", tutorialStep: $tutorialStep, window_rect: CGRect(x: screenSize.width - 140, y: 15, width: 135, height: 50))
        }
        
    }
}
