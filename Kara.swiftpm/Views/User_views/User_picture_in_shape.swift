//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct User_picture_in_shape: View {
    
    public enum PhotoShape {
        case circle, square
    }

    //MARK: Data properties
    public let userPhotoData : Data?
    
    
    //MARK: View properties
    public let frameSize : CGFloat
    public let photoShape : PhotoShape
    public var colorPlaceholder : Color = .app_dark_gray
    
    
    public var body: some View {
        if photoShape == PhotoShape.square {
            squareView()
        } else if photoShape == PhotoShape.circle {
            circleView()
        }
    }
    
    @ViewBuilder
    private func squareView() -> some View {
        if let userPhotoData = userPhotoData, let uiImage = UIImage(data: userPhotoData) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: frameSize, height: frameSize)
                .background {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: frameSize, height: frameSize)
                        .clipped()
                        .padding(.all, 5)
                        
                }
                .cornerRadius(15)
        } else {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: frameSize, height: frameSize)
                .background {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: frameSize, height: frameSize)
                        .clipped()
                        .padding(.all, 5)
                        .foregroundColor(colorPlaceholder)
                }
                .cornerRadius(15)
        }
    }
    
    @ViewBuilder
    private func circleView() -> some View {
        if let userPhotoData = userPhotoData, let uiImage = UIImage(data: userPhotoData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width: frameSize, height: frameSize)
                .clipShape(Circle())
                .padding(.all, 5)
        } else {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: frameSize, height: frameSize)
                .clipped()
                .padding(.all, 5)
                .foregroundColor(.app_dark_gray)
        }
    }
}
