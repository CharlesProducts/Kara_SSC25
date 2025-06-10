//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public extension View {
    
    func background_title(text: String, height: Float = 40, isBold: Bool = false, backColor: Color = .app_white) -> some View {
        
        /// Displays a frame around the view with a title
        
        self
            .background {
                GeometryReader { proxy in
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 3)
                        .foregroundColor(.app_light_gray)
                    
                    Text(text)
                        .padding(.horizontal, 10)
                        .font(.system(size: 14))
                        .foregroundColor(.app_dark_gray)
                        .fontWeight(isBold ? .bold : .medium)
                        .background(backColor)
                        .offset(x:20, y: -10)
                    
                }
                .frame(height: CGFloat(height))
            }
    }
    
    func disableWithOpacity(_ condition:Bool) -> some View {
        
        /// Disables a button while reducing its opacity
        
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    
    func hAlign(_ alignement: Alignment) -> some View {
        
        /// Aligns the view horizontally according to the passed argument
        
        self
            .frame(maxWidth: .infinity, alignment: alignement)
    }
    
    func vAlign(_ alignement : Alignment) -> some View {
        
        /// Aligns the view vertically according to the passed argument
        
        self
            .frame(maxHeight: .infinity, alignment: alignement)
    }
    
    func border(_ width: CGFloat, _ color:Color, _ cornerRadius: CGFloat = 20) -> some View {
        
        /// Displays a frame around the view
        
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(color, lineWidth: width)
            }
    }
    
    func fillView( _ color: Color, cornerRadius: Float = 15) -> some View {
        
        /// Fills the background with a rounded rectangle
        
        self
        
            .background {
                RoundedRectangle(cornerRadius: CGFloat(cornerRadius), style: .continuous)
                    .fill(color)
            }
    }
    
    func fillClearView(_ color: Color = .app_light_gray) -> some View {
        
        /// Displays a frame around the view which changes color depending on the parameter
        
        self
            .background {
                ZStack {
                    Color.app_white
                    
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .stroke(lineWidth: 3)
                        .foregroundColor(color)
                }
            }
    }
    
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        
        /// Performs an action if the screen changes orientation
        
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}


public struct DeviceRotationViewModifier: ViewModifier {
    
    /// Check if the screen changes orientation
    
    public let action: (UIDeviceOrientation) -> Void
    
    public func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}
