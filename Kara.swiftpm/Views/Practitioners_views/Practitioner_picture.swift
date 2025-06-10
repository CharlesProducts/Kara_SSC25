//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Practitioner_picture: View {
    
    //MARK: Data properties
    public let profileIcon : String
    
    
    //MARK: View properties
    public let frameSize : CGFloat
    
    
    public var body: some View {
        Image(systemName: profileIcon)
            .resizable()
            .scaledToFit()
            .frame(width: frameSize, height: frameSize)
            .padding(.all, 5)
            .foregroundColor(.app_dark_gray)
    }
}

public struct Practitioner_picture_choice: View {
    
    //MARK: Data properties
    @Binding public var profileIcon : String
    
    
    //MARK: View properties
    public let frameSize : CGFloat
    @State private var showProfileIconChoice : Bool = false
    
    
    public var body: some View {
        Button {
            showProfileIconChoice = true
        } label: {
            VStack (alignment: .center, spacing: 0) {
                Image(systemName: profileIcon)
                    .resizable()
                    .scaledToFit() 
                    .frame(width: frameSize, height: frameSize)
                    .padding(.all, 5)
                    .foregroundColor(.app_dark_gray)
                
                Text("Add an icon")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color.app_gray)
                    .padding(.top)
            }
        }
        .sheet(isPresented: $showProfileIconChoice) {
            Practitioner_profile_picture_choice(iconSelected: $profileIcon)
        }
    }
}
