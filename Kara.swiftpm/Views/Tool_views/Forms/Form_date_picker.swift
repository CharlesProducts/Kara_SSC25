//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Form_date_picker: View {
    
    // MARK: View properties
    public let text : String
    public var color : Color = .app_green
    
    
    // MARK: Data properties
    @Binding public var dateChoice : Date
    
    
    public var body: some View {
        DatePicker(text, selection: $dateChoice, displayedComponents: .date)
            .fontWeight(.semibold)
            .foregroundColor(.app_white)
            .tint(.app_dark_gray)
            .padding(.vertical, 8)
            .padding(.horizontal)
            .fillView(color, cornerRadius: 15)
    }
}
