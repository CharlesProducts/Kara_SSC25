//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI


public enum Tab : Int, CaseIterable {
    
    case history = 0
    case home
    case users
    
    var iconName : String {
        switch self {
        case .history:
            return "list.bullet.rectangle"
        case .home:
            return "house"
        case .users:
            return "person"
        }
    }
}

public struct Tapbar: View {
    
    // MARK: Data properties
    @Binding public var selectedTab : Int
    
    
    // MARK: View properties
    @State private var homeAnimationRunning : Bool = false
    
    
    public var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { item in
                
                Spacer()
                
                Button{
                    selectedTab = item.rawValue
                } label: {
                    CustomTabItem(imageName: item.iconName, isActive: (selectedTab == item.rawValue))
                }
                
                Spacer()
            }
        }
        .frame(height: 70)
        .background(Color.app_dark_gray)
        .cornerRadius(40)
        .padding()
    }
    
    @ViewBuilder
    private func CustomTabItem(imageName: String, isActive: Bool) -> some View {
        
        Image(systemName: isActive ? "\(imageName).fill" : imageName)
            .foregroundColor(.app_white)
            .scaleEffect(isActive ? 1.65 : 1.4)
        
    }
    
}
