//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Custom_selector_view: View {
    
    // MARK: Data properties
    @Binding public var isOne : Bool

    
    // MARK: View properties
    public let leftTextButton : String
    public let rightTextButton : String
    
    
    public var body: some View {
        GeometryReader { proxy in
            HStack {
                if isOne {
                    Text(leftTextButton)
                        .frame(width: (proxy.size.width/2) - 5, height: proxy.size.height)
                        .fillView(.app_yellow)
                    
                    Spacer()
                    
                    Text(rightTextButton)
                        .frame(width: (proxy.size.width/2) - 5, height: proxy.size.height)
                        .fillClearView()
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isOne = false
                            }
                        }
                    
                } else {
                    Text(leftTextButton)
                        .frame(width: (proxy.size.width/2) - 5, height: proxy.size.height)
                        .fillClearView()
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isOne = true
                            }
                        }
                    
                    Spacer()
                    
                    Text(rightTextButton)
                        .frame(width: (proxy.size.width/2) - 5, height: proxy.size.height)
                        .fillView(.app_yellow)
                }
            }
            .font(.system(size: 14))
            .fontWeight(.semibold)
            .foregroundColor(.app_dark_gray)
            
        }.frame(height: 55)
    }
}

