//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Loading: View {
    
    // MARK: View Properties
    @Binding public var show : Bool
    
    
    public var body: some View {
        if show {
            ZStack {
                Group {
                    Rectangle()
                        .fill(.black.opacity(0.25))
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .padding(15)
                        .background(.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                }
            }
            .animation(.easeInOut(duration: 0.25), value: show)
        }
    }
}
