//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct Practitioner_choice: View {
    
    //MARK: Data properties
    @Binding public var practitionersSelected : Practitioner?
    
    
    //MARK: View properties
    @Binding public var showPractitionersList : Bool
    
    
    public var body: some View {
        HStack {
            if let practitionersSelected = practitionersSelected {
                
                Practitioner_picture(profileIcon: practitionersSelected.profileIcon, frameSize: 45.0)
                
                VStack (alignment: .leading, spacing: 5) {
                    HStack(spacing: 0) {
                        Text(practitionersSelected.fullName)
                    }
                    .font(.system(size: 24))
                    .foregroundStyle(Color.app_black)
                    .lineLimit(2)
                    
                    Text(practitionersSelected.work ?? "Specialty not specified")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.gray)
                    
                }
                .fontWeight(.semibold)
                .hAlign(.leading)
                
                Button(action: {
                    showPractitionersList.toggle()
                }, label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.all, 12)
                        .foregroundStyle(Color.app_dark_gray)
                        .fillView(.app_yellow)
                })
            } else {
                Text("Add a practitioner")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.app_black)
                    .hAlign(.leading)
                
                Button(action: {
                    showPractitionersList.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.all, 12)
                        .foregroundStyle(Color.app_dark_gray)
                        .fillView(.app_yellow)
                })
            }
        }
        .padding()
        .frame(height: 75)
        .fillView(.app_light_purple)
    }
}
