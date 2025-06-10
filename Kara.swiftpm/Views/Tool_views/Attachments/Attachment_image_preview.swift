//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Attachment_image_preview: View {
    
    // MARK: Data properties
    public let imageData : Data
    
    
    // MARK: View properties
    public let size : CGSize
    
    
    public var body: some View {
        if let uiImage = UIImage(data: imageData) {
            RoundedRectangle(cornerRadius: 15.0)
                .frame(width: size.width, height: size.height)
                .foregroundStyle(Color.app_black)
                .overlay {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: size.height * 0.7)
                        .foregroundStyle(.white)
                }
        }
    }
}
