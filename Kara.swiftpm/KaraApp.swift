//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

@main
struct KaraApp: App {
    
    // MARK: Data properties
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            
            if appState.isLoading && true {
                ProgressView()
                    .task {
                        await appState.preloadDataIfNeeded()
                    }
            } else {
                ContentView(selectedTab: 1)
                    .modelContainer(appState.modelContainer)
                    .preferredColorScheme(.light)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .ignoresSafeArea()
                    .statusBarHidden()
            }
            
            
        }
    }
}
