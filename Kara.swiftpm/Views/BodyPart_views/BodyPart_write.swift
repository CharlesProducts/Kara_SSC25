//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct BodyPart_write: View {
    
    //MARK: Data properties
    @Binding public var selectedBodyPart : String
    
    
    //MARK: View properties
    @Environment(\.dismiss) private var dismiss
    @FocusState private var fieldIsFocus : Bool
    
    
    public var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                TextField("Body part", text: $selectedBodyPart)
                    .border(2, .app_dark_gray)
                    .focused($fieldIsFocus)
                    .onTapGesture(coordinateSpace: .global) {_ in
                        fieldIsFocus.toggle()
                    }
                    .onSubmit {
                        fieldIsFocus.toggle()
                        dismiss()
                    }
                
                Button {
                    dismiss()
                } label: {
                    Text("SAVE")
                        .foregroundColor(.white)
                        .font(.title3)
                        .hAlign(.center)
                        .padding(.vertical, 10)
                        .disableWithOpacity(selectedBodyPart.isEmpty)
                        .fillView(.app_purple)
                }
                
                Spacer()
                
            }.padding()
                .navigationTitle("Body part")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("Cancel")
                        })
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            fieldIsFocus = false
                        }, label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                        })
                        
                    }
                }
                .tint(.app_purple)
        }
    }
}
