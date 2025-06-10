//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Form_date_hour_picker: View {
    
    // MARK: View properties
    public let text : String
    @Binding public var dateChoice : Date
    
    
    public var body: some View {
        DatePicker(text, selection: $dateChoice)
            .fontWeight(.semibold)
            .foregroundColor(.app_white)
            .tint(.app_dark_gray)
            .padding(.vertical, 8)
            .padding(.horizontal)
            .fillView(.app_green, cornerRadius: 15)
    }
}
