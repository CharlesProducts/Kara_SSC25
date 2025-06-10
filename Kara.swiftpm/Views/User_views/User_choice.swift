//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct User_choice: View {
    
    // MARK: Data properties
    @Query private var users : [User]
    @Binding var userSelected : User?
    
    
    public var body: some View {
        if users.isEmpty {
            Text("No profile found")
                .bold()
                .hAlign(.center)
                .frame(height: 125)
                .background_title(text: "Profile selection", height: 135, isBold: true)
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(users) { user in
                        VStack {
                            User_picture_in_shape(userPhotoData: user.profilePictureData, frameSize: 70, photoShape: .square)
                                .padding(.all, 6)
                                .background {
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(userSelected == user ? .app_yellow : .app_white)
                                }
                            
                            Text(user.firstName)
                                .foregroundColor(.app_gray)
                            
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                userSelected = user
                            }
                        }
                    }
                    
                }
            }.background_title(text: "Profile selection", height: 135, isBold: true)
        }
    }
}
