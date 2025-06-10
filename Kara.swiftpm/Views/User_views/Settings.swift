//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Settings: View {
    
    // MARK: Data properties
    // User preferences
    @State private var automaticAppointmentsAddition : Bool = UserDefaults.standard.bool(forKey: "automaticAppointmentsAddition")
    @State private var largeNextAppointmentsPreview : Bool = UserDefaults.standard.bool(forKey: "largeNextAppointmentsPreview")
    
    
    // MARK: View properties
    @Binding private var viewPath: NavigationPath
    @State private var showUserForm : Bool = false
    
    
    // MARK: Init
    public init(viewPath: Binding<NavigationPath>) {
        self._viewPath = viewPath
    }
    
    
    public var body: some View {
        List {
            /*
            Section {
                Toggle("Large visualisation", isOn: $largeNextAppointmentsPreview)
                    .onChange(of: largeNextAppointmentsPreview) {
                        UserDefaults.standard.set(largeNextAppointmentsPreview, forKey: "largeNextAppointmentsPreview")
                    }
            } header: {
                Text("Accueil")
            } footer: {
                Text("Permet de visualiser plus de rendez-vous à la fois sur la page d'accueil. (Vous devrez redémarrer l'application.)")
            }
             */
            
            Section {
                Toggle("New event created automatically", isOn: $automaticAppointmentsAddition)
                    .onChange(of: automaticAppointmentsAddition) {
                        UserDefaults.standard.set(automaticAppointmentsAddition, forKey: "automaticRdvsAddition")
                    }
            } header: {
                Text("Apple Calendar")
            } footer: {
                Text("Appointments will be automatically added to your Apple Calendar.")
            }
            
            Section("Accounts and profiles") {
                Button("Add a profile", systemImage: "person.badge.plus") {
                    showUserForm = true
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showUserForm) {
            User_form()
        }
        .onChange(of: showUserForm) { _, newValue in
            if !newValue {
                viewPath.removeLast()
            }
        }
    }
}
