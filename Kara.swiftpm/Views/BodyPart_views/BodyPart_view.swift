//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct BodyPart_view: View {
    
    //MARK: Data properties
    let bodyPart : String
    
    
    public var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(height: 200)
            .foregroundColor(.app_light_purple)
            .overlay {
                VStack {
                    Image(uiImage: UIImage(named: "broken_bone.png") ?? UIImage(named: "snowboard")!)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 75)
                        .padding([.leading, .top], 5)
                        .hAlign(.leading)
                        .vAlign(.top)
                    
                    Text(bodyPart)
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.app_dark_gray)
                        .hAlign(.trailing)
                        .multilineTextAlignment(.trailing)
                        .lineLimit(2, reservesSpace: false)
                        .padding(.bottom, 5)
                }
                .padding(.vertical, 13)
                .padding(.horizontal, 13)
            }
    }
}
