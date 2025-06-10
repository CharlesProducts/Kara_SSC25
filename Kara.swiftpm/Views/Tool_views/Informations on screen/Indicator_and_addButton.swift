//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Indicator_and_addButton: View {
    
    //MARK: View properties
    @Binding public var showForm : Bool
    
    
    // MARK: Data properties
    public let itemCount : Int
    
    
    public var body: some View {
        GeometryReader { proxy in
            HStack {
                Text("\(itemCount) \(itemCount <= 1 ? "Element" : "Elements")")
                    .frame(width: (proxy.size.width/2) - 5, height: proxy.size.height)
                    .fillClearView()
                
                Spacer()
                
                Button {
                    showForm.toggle()
                } label: {
                    Text("ADD")
                        .frame(width: (proxy.size.width/2) - 5, height: proxy.size.height)
                        .fillView(.app_light_purple)
                }

            }
            .font(.system(size: 20))
            .fontWeight(.bold)
            .foregroundColor(.app_dark_gray)
        }.frame(height: 45)
    }
}
