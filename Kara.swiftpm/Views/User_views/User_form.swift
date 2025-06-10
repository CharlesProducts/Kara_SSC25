//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData
import _PhotosUI_SwiftUI


public struct User_form: View {
    
    //MARK: Data properties
    @Environment(\.modelContext) private var modelContext
    
    @State private var imageSelection = [PhotosPickerItem]()
    @State private var selectedPhotoData : Data?
    @State private var firstName : String = ""
    
    
    //MARK: View properties
    @Environment(\.dismiss) private var dismiss
    
    @State private var showPictureChoice : Bool = false
    @FocusState private var firstNameFocus : Bool
    @FocusState private var nameFocus : Bool
    
    
    //MARK: Functions
    private func saveProfile() {
        
        let newUser = User(firstName: firstName, profilePictureData: selectedPhotoData)
        modelContext.insert(newUser)
        dismiss()
    }
    
    private func cancelForm() {
        dismiss()
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
        .photosPicker(isPresented: $showPictureChoice,
                      selection: $imageSelection,
                      maxSelectionCount: 1,
                      matching: .images,
                      photoLibrary: .shared())
        .task(id: imageSelection) {
            if !imageSelection.isEmpty {
                if let data = try? await imageSelection[0].loadTransferable(type: Data.self) {
                    selectedPhotoData = data
                }
            }
        }
    }
    
    @ViewBuilder
    private func header() -> some View {
        HStack(alignment: .bottom) {
            Button {
                cancelForm()
            } label: {
                Text("Cancel")
                    .font(.callout.bold())
                    .foregroundColor(.app_dark_gray)
            }
            
            Text("New profile")
                .font(.title3.bold())
                .foregroundColor(.app_dark_gray)
                .hAlign(.trailing)

        }
    }
    
    @ViewBuilder
    private func profile_picture() -> some View {
        VStack (alignment: .center) {
            User_picture_in_shape(userPhotoData: selectedPhotoData, frameSize: 65, photoShape: .circle)
            
            Text("Edit profile picture")
                .font(.system(size: 12))
                .foregroundStyle(Color.app_gray)
        }
    }
    
    @ViewBuilder
    private func footer() -> some View {
        Button {
            saveProfile()
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.app_green)
                .frame(height: 70)
                .overlay {
                    Text("ADD")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.app_white)
                }
        }
        .disableWithOpacity(firstName == "")
    }
}
