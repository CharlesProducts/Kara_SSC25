//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import _PhotosUI_SwiftUI

public struct User_edit: View {
    
    // MARK: Data properties
    @Bindable public var user : User
    
    @State private var userDetached : Bool = false
    @State private var imageSelection = [PhotosPickerItem]()
    
    @State private var firstName : String = ""
    @State private var profilePictureData : Data?
    
    
    // MARK: View properties
    @Environment(\.dismiss) private var dismiss
    
    @State private var showPictureChoice : Bool = false
    @State private var photoChanged : Bool = false
    
    @FocusState private var firstNameFocus : Bool
    
    
    // MARK: Init
    public init(user: Bindable<User>) {
        self._user = user
    }
    
    
    // MARK: Functions
    private func saveprofile() {
        user.profilePictureData = profilePictureData
        user.firstName = firstName
        dismiss()
    }
    
    private func cancelEdit() {
        dismiss()
    }
    
    private func copyOriginalUser() {
        firstName = user.firstName
        profilePictureData = user.profilePictureData
    }
    
    
    public var body: some View {
        ScrollView(.vertical) {
            VStack (spacing: 20) {
                header()
                
                profile_picture()
                    .onTapGesture {
                        showPictureChoice.toggle()
                    }
                
                Text_field(title: "First name", text: $firstName, isFocus: $firstNameFocus)
                
                footer()
                
            }.padding()
        }
        .onAppear(perform: copyOriginalUser)
        .photosPicker(isPresented: $showPictureChoice,
                      selection: $imageSelection,
                      maxSelectionCount: 1,
                      matching: .images,
                      photoLibrary: .shared())
        .task(id: imageSelection) {
            if !imageSelection.isEmpty {
                if let data = try? await imageSelection[0].loadTransferable(type: Data.self) {
                    profilePictureData = data
                    photoChanged = true
                }
            }
        }
    }
    
    @ViewBuilder
    private func header() -> some View {
        HStack(alignment: .bottom) {
            Button {
                cancelEdit()
            } label: {
                Text("Cancel")
                    .font(.callout.bold())
                    .foregroundColor(.app_dark_gray)
            }
            
            Text("Edit profile")
                .font(.title3.bold())
                .foregroundColor(.app_dark_gray)
                .hAlign(.trailing)

        }
    }
    
    @ViewBuilder
    private func profile_picture() -> some View {
        VStack (alignment: .center) {
            User_picture_in_shape(userPhotoData: profilePictureData, frameSize: 65, photoShape: .circle)
            
            Text("Edit profile picture")
                .font(.system(size: 12))
                .foregroundStyle(Color.app_gray)
        }
    }
    
    @ViewBuilder
    private func footer() -> some View {
        Button {
            saveprofile()
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.app_green)
                .frame(height: 70)
                .overlay {
                    Text("SAVE")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.app_white)
                }
        }
    }
}
