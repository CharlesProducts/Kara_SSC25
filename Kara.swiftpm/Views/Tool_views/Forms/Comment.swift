//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Comment: View {
    
    // MARK: Data properties
    @Binding public var text : String
    
    
    // MARK: View properties
    @FocusState.Binding public var isFocus : Bool
    
    
    public var body: some View {
        GeometryReader { _ in
            TextEditor(text: $text)
                .focused($isFocus)
                .padding()
        }
        .frame(height: 140)
        .background {
            GeometryReader { proxy in
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 3)
                    .foregroundColor(.app_light_gray)
                
                HStack {
                    Text("Comment")
                        .padding(.horizontal, 10)
                        .background(Color.app_white)
                        .hAlign(.leading)
                    
                    Button(action: {
                        isFocus = false
                    }, label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                            .padding(.horizontal, 10)
                            .background(Color.app_white)
                    })
                }
                .padding(.horizontal)
                .font(.system(size: 14).bold())
                .foregroundColor(.app_dark_gray)
                .offset(y: -10)
                
            }.frame(height: 140.0)
        }
    }
}
