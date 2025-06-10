//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Tutorial_window_view: View {
    
    // MARK: Data properties
    public let text: String
    
    
    // MARK: View properties
    @Binding public var tutorialStep : Int
    public let window_rect: CGRect
    
    private var textBoxSize: CGSize {
        let screenSize = UIScreen.main.bounds
        return CGSize(width: (screenSize.width/3)*2, height: 200)
    }
    
    private var textBoxYPosition : CGFloat {
        
        let screenHeight = UIScreen.main.bounds.height
        let window_real_maxY = screenHeight/2 - window_rect.maxY
        let window_real_minY = screenHeight/2 - window_rect.minY
        
        if window_rect.maxY > screenHeight - 250 {
            return -window_real_minY - textBoxSize.height/2
        } else {
            return -window_real_maxY + textBoxSize.height/2
        }
    }
    
    
    public var body: some View {
        ZStack {
            
            HoleShape(rect: window_rect)
                .fill(.black.opacity(0.35))
            
            VStack {
                Text(text == "" ? "Welcome on KARA" : text)
                    .font(.system(size: text == "" ? 50 : 19, weight: .bold))
                    .foregroundStyle(Color.app_dark_gray)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 15)
                    .background {
                        RoundedRectangle(cornerRadius: 5.0)
                            .fill(Color.app_light_purple)
                    }
                    .rotationEffect(.degrees(Double.random(in: -1.8...1.8)))
                    .shadow(radius: 20)
                    
            }
            .offset(y: textBoxYPosition)
            .frame(width: textBoxSize.width, height: textBoxSize.height)
            
            
        }
        .onTapGesture {
            tutorialStep += 1
        }
    }
}

public struct HoleShape: Shape {
    
    public let rect: CGRect
    private let cornerRadius = RectangleCornerRadii(topLeading: 20, bottomLeading: 20, bottomTrailing: 20, topTrailing: 20)
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(rect)
        path.addRoundedRect(in: self.rect, cornerRadii: cornerRadius)
        return path.normalized(eoFill: true)
    }
}
