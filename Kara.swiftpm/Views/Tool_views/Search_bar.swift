//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Search_bar: View {
    
    // MARK: View properties
    @FocusState private var fieldIsFocus : Bool
    
    
    // MARK: Data properties
    @Binding public var searchText : String
    
    
    public var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.title3.bold())
                .foregroundColor(.app_light_gray)
            
            TextField("Search...", text: $searchText)
                .focused($fieldIsFocus)
                .onSubmit {
                    fieldIsFocus = false
                }
            
            if fieldIsFocus {
                Button {
                    withAnimation(.easeOut) {
                        fieldIsFocus = false
                    }
                } label: {
                    Text("OK")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .foregroundColor(.app_white)
                        .background(Color.app_light_gray)
                        .cornerRadius(20)
                }
                
            }
            
        }.padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
                .foregroundColor(.app_light_gray)
                .frame(height: 50)
        }
        
    }
}
