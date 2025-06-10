//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct ContentView: View {
    
    // MARK: Data properties
    @Query private var users: [User]
    
    // MARK: View properties
    @State private var tutorialStep : Int = 0
    @State private var showIntroduction : Bool = true
    @State private var screenRotation = UIDeviceOrientation.unknown
    @State private var previousScreenRotation = UIDeviceOrientation.unknown
    @State public var selectedTab = 1
    
    private var screenRotationIsGood : Bool {
        return (self.screenRotation == .portrait || self.screenRotation == .portraitUpsideDown) || (self.screenRotation == .faceUp && (self.previousScreenRotation == .portrait || self.screenRotation == .portraitUpsideDown))
    }
    
    private var canShowIntroduction : Bool {
        return (self.screenRotationIsGood && self.showIntroduction)
    }
    private var canShowAppContent : Bool {
        return (self.screenRotationIsGood && !self.showIntroduction)
    }
    
    // MARK: init
    public init(selectedTab: Int = 1) {
        _selectedTab = State(initialValue: selectedTab)
    }
    
    
    public var body: some View {
        ZStack (alignment: .bottom) {
            
            Introduction(showIntroduction: $showIntroduction)
                .allowsHitTesting(self.canShowIntroduction)
                .opacity(self.canShowIntroduction ? 1.0 : 0.0)
            
            TabView(selection: $selectedTab) {
                
                Main_history(tutorialStep: $tutorialStep)
                    .toolbarVisibility(.hidden, for: .tabBar)
                    .tag(0)
                
                Home(tutorialStep: $tutorialStep)
                    .toolbarVisibility(.hidden, for: .tabBar)
                    .tag(1)
                
                Users_page(tutorialStep: $tutorialStep)
                    .toolbarVisibility(.hidden, for: .tabBar)
                    .tag(2)
                
            }
            .allowsHitTesting(self.canShowAppContent)
            .opacity(self.canShowAppContent ? 1.0 : 0.0)
            
            
            Tapbar(selectedTab: $selectedTab)
                .allowsHitTesting(self.canShowAppContent)
                .opacity(self.canShowAppContent ? 1.0 : 0.0)
            
            showOrientationMessage()
                .allowsHitTesting(!self.screenRotationIsGood)
                .opacity(!self.screenRotationIsGood ? 1.0 : 0.0)
        }
        .onRotate { newOrientation in
            self.previousScreenRotation = self.screenRotation
            self.screenRotation = newOrientation
        }
        .onChange(of: tutorialStep) { _, newValue in
            if newValue == 3 && selectedTab == 1 {
                selectedTab = 0
                tutorialStep += 1
            } else if newValue == 7 && selectedTab == 0 {
                selectedTab = 2
                tutorialStep += 1
            } else if newValue == 12 && selectedTab == 2 {
                selectedTab = 1
                tutorialStep += 1
            }
        }
    }
    
    @ViewBuilder
    private func showOrientationMessage() -> some View {
        VStack(alignment: .center, spacing: 10) {
            if screenRotation == .unknown {
                Text("Move the iPad so the app can detect the screen orientation")
                    .font(.title2.bold())
            } else {
                Text("Please keep your iPad in portrait mode")
                    .font(.largeTitle.bold())
            }
        }
        .multilineTextAlignment(.center)
        .foregroundStyle(Color.black.opacity(0.8))
        .hAlign(.center)
        .vAlign(.center)
    }
}

#Preview {
    ContentView()
}
