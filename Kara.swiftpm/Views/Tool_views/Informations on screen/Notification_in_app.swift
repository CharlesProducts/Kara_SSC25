//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Notification_in_app: View {
    
    //MARK: View properties
    public let titleMessage : String
    public let message : String
    
    
    public var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            HStack {
                Text(titleMessage)
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            Text(message)
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .hAlign(.leading)
            
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.app_yellow)
        }
    }
}
