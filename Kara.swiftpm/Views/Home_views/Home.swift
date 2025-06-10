//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import EventKit
import SwiftData

public struct Home: View {
    
    // MARK: Data properties
    @Query private var users : [User]
    @State private var viewPath = NavigationPath()
    @StateObject private var calendarManager = CalendarManager()
    
    // MARK: View properties
    @Binding public var tutorialStep : Int
    @State private var largeNextAppointmentsPreview : Bool = UserDefaults.standard.bool(forKey: "largeNextAppointmentsPreview")
    @State private var showBoobooForm : Bool = false
    @State private var showAppointmentForm : Bool = false
    @State private var showTutorial : Bool = false
    
    private let screenSize = UIScreen.main.bounds.size
    
    // MARK: Init
    public init(tutorialStep: Binding<Int>) {
        self._tutorialStep = tutorialStep
    }
    
    
    public var body: some View {
        NavigationStack(path: $viewPath) {
            ZStack {
                VStack(spacing: 30) {
                    
                    header()
                    
                    addButtons()
                    
                    tutorialButton()
                    
                    NextAppointmentsView()
                    // To be above the tap bar which is 70 high
                        .safeAreaPadding(.bottom, 88)
                }
                .fullScreenCover(isPresented: $showBoobooForm) {
                    Booboo_form()
                }
                .fullScreenCover(isPresented: $showAppointmentForm) {
                    Appointment_form()
                }
                .sheet(isPresented: $showTutorial) {
                    EmptyView()
                }
                .navigationTitle("Hello,")
                .toolbar(.hidden, for: .automatic)
                
                tutorialStepView()
            }
            .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    private func header() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Hello,")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundStyle(Color.app_black)
                
                Text("\(Date().formatted(date: .complete, time: .omitted))")
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.gray)
            }
            
            Spacer()
            
            Image(uiImage: (UIImage(named: "Kara_wBg.png") ?? UIImage(systemName: "person"))!)
                .resizable()
                .scaledToFit()
                .frame(width: 60)
                .padding(.bottom, 5)
        }
        .padding(.horizontal)
        .padding(.top)
        
    }
    
    @ViewBuilder
    private func addButtons() -> some View {
        VStack(spacing: 50) {
            HStack {
                // Add booboo Button
                Button(action: {
                    showBoobooForm = true
                }, label: {
                    HStack(spacing: 20) {
                        Image(uiImage: UIImage(named: "broken_bone.png") ?? UIImage(systemName: "snowboard")!)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 25)
                        
                        Text("Add a boo-boo")
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.app_black)
                    }
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(height: 50)
                            .foregroundStyle(Color.app_purple)
                    }
                })
                .layoutPriority(1)
                
                // Line
                RoundedRectangle(cornerRadius: 15.0)
                    .frame(height: 4)
                    .foregroundStyle(Color.app_light_gray)
                    .padding(.leading, 5)
            }
            
            HStack {
                // Line
                RoundedRectangle(cornerRadius: 15.0)
                    .frame(height: 4)
                    .foregroundStyle(Color.app_light_gray)
                    .padding(.trailing, 5)
                
                // Add Appointment Button
                Button(action: {
                    showAppointmentForm = true
                }, label: {
                    HStack(spacing: 20) {
                        Text("Add an appointment")
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.app_black)
                        
                        Image(systemName: "calendar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 23)
                            .foregroundStyle(Color.app_black)
                    }
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(height: 50)
                            .foregroundStyle(Color.app_mallow)
                    }
                })
                .layoutPriority(1)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func tutorialButton() -> some View {
        Button {
            tutorialStep = 0
        } label: {
            Image(uiImage: (UIImage(named: "wallPaperTutorial.png") ?? UIImage(systemName: "book.pages.fill"))!)
                .resizable()
                .scaledToFill()
                .opacity(0.9)
                .frame(height: largeNextAppointmentsPreview ? 100 : 180)
                .clipShape(.rect(cornerRadius: 15.0))
                .padding(.horizontal, 15)
                .overlay {
                    Text("Click to restart the tutorial")
                        .font(.title2.bold())
                        .foregroundStyle(Color.app_white)
                }
        }
            
    }
    
    @ViewBuilder
    private func tutorialStepView() -> some View {
        
        if tutorialStep == 0 {
            Tutorial_window_view(text: "This is the home page, as Kara is centered around boo-boos, you can just click on it to add one", tutorialStep: $tutorialStep, window_rect: CGRect(x: 10, y: 125, width: 240, height: 70))
        } else if tutorialStep == 1 {
            Tutorial_window_view(text: "Once a boo-boo is created, you can directly add the associated appointments to it", tutorialStep: $tutorialStep, window_rect: CGRect(x: screenSize.width - 302.5, y: 202.5, width: 295, height: 70))
        } else if tutorialStep == 2 {
            Tutorial_window_view(text: "Then, here you can view the different upcoming appointments, you can scroll to see more. You can also click on the appointments to view more information", tutorialStep: $tutorialStep, window_rect: CGRect(x: 5, y: screenSize.height/2 - 90, width: screenSize.width - 10, height: screenSize.height/2))
        } else if tutorialStep == 13 {
            Tutorial_window_view(text: "", tutorialStep: $tutorialStep, window_rect: CGRect(x: screenSize.width/2, y: screenSize.height/4, width: 0.5, height: 0.5))
        }
        
    }
}

#Preview {
    ContentView()
}


























































