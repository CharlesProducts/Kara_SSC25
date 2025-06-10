//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct BodyPart_choice: View {
    
    //MARK: Data properties
    @Binding var bodyPartChoice : String
    
    
    //MARK: View properties
    @State var showSheet : Bool = false
    
    
    public var body: some View {
        GeometryReader { proxy in
            HStack {
                Text(bodyPartChoice)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.app_dark_gray)
                    .padding()
                    .frame(height: proxy.size.height)
                    .hAlign(.leading)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.app_light_purple)
                    }
                
                Button(action: {
                    showSheet.toggle()
                }, label: {
                    Text("Press to change")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .foregroundColor(.app_white)
                        .frame(width: 100)
                        .padding()
                        .frame(height: proxy.size.height)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.app_dark_gray)
                        }
                })
            }
        }
        .frame(height: 65)
        .sheet(isPresented: $showSheet) {
            withAnimation(.spring()) {
                BodyPart_write(selectedBodyPart: $bodyPartChoice)
                    .presentationDetents([.fraction(0.3)])
            }
        }
    }
}
