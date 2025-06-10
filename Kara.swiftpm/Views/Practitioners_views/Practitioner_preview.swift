//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Practitioner_preview: View {
    
    //MARK: Data properties
    @Bindable public var practitioner : Practitioner
    @Binding public var appointmentDate : Date
    
    
    public var body: some View {
        HStack {
            Practitioner_picture(profileIcon: practitioner.profileIcon, frameSize: 45.0)
            
            VStack (alignment: .leading, spacing: 5) {
                HStack(spacing: 0) {
                    Text(practitioner.fullName)
                }
                .font(.system(size: 24))
                .foregroundStyle(Color.app_black)
                
                Text(practitioner.work ?? "Specialty not specified")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.gray)
                
            }
            .fontWeight(.semibold)
            .hAlign(.leading)
            
            VStack {
                Text(appointmentDate.formatted(date: .numeric, time: .omitted))
                Text(appointmentDate.formatted(date: .omitted, time: .shortened))
            }
            .font(.system(size: 13))
            .fontWeight(.semibold)
            .foregroundColor(.app_gray)
        }
        .padding()
        .frame(height: 75)
        .fillView(.app_white)
    }
}
