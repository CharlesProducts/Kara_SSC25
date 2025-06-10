//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Practitioner_preview_select: View {
    
    //MARK: Data properties
    @Binding public var practitionerChoice : Practitioner?
    public let practitioner : Practitioner
    
    
    //MARK: View properties
    public var isSelected : Bool {
        if let practitionerChoice = practitionerChoice {
            return practitionerChoice == practitioner
        } else {
            return false
        }
    }
    
    
    public var body: some View {
        HStack {
            Practitioner_picture(profileIcon: practitioner.profileIcon, frameSize: 45.0)
            
            VStack (alignment: .leading, spacing: 5) {
                HStack {
                    Text(practitioner.fullName)
                        .lineLimit(2)
                }
                .font(.system(size: 24))
                .foregroundStyle(Color.app_black)
                
                Text(practitioner.work ?? "Specialty not specified")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.gray)
                
            }
            .fontWeight(.semibold)
            .hAlign(.leading)
            
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 10)
        .fillClearView(isSelected ? .app_green : .app_light_gray)
    }
}
