//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData


public struct Booboo_preview: View {
    
    //MARK: Data properties
    @Environment(\.modelContext) private var modelContext
    public let booboo : Booboo
    public var color : Color
    
    //MARK: View properties
    @State private var showAlert : Bool = false
    
    //MARK: Functions
    private func deletebooboo() {
        modelContext.delete(booboo)
    }
    
    
    public var body: some View {
        HStack (spacing: 15) {
            User_picture_in_shape(userPhotoData: booboo.user?.profilePictureData, frameSize: 55, photoShape: .square)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(booboo.wording)
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(.app_black)
                
                Text(booboo.bodyPart)
                    .font(.system(size: 13))
                    .fontWeight(.semibold)
                    .foregroundColor(.app_gray)
            }
            .multilineTextAlignment(.leading)
            .hAlign(.leading)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
        .fillView(color)
        .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 15.0))
        .contextMenu {
            Group {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    showAlert = true
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Delete this booboo ?"),
                  primaryButton: Alert.Button.destructive(Text("Yes"), action: deletebooboo),
                  secondaryButton: Alert.Button.default(Text("No")))
        }
    }
}
