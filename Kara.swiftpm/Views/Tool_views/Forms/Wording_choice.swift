//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Wording_choice: View {
    
    // MARK: Data properties
    @Binding var wording : String
    
    
    // MARK: View properties
    var isFocus : FocusState<Bool>.Binding
    
    public var body: some View {
        HStack {
            TextField("Enter a label for this boo-boo...", text: $wording)
                .foregroundColor(.app_dark_gray)
                .tint(.app_dark_gray)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .onTapGesture {
                    isFocus.wrappedValue.toggle()
                }
            
            Spacer()
            
            if isFocus.wrappedValue {
                Button {
                    withAnimation(.easeInOut) {
                        isFocus.wrappedValue.toggle()
                    }
                } label: {
                    Text("OK")
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .fontWeight(.medium)
                        .foregroundColor(.app_yellow)
                        .background {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(.app_dark_gray)
                        }
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .fillView(.app_yellow, cornerRadius: 20)
    }
}
