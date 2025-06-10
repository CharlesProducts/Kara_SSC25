//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Practitioner_informations: View {
    
    //MARK: Data properties
    @Bindable public var practitioner : Practitioner
    
    
    //MARK: View properties
    @Environment(\.dismiss) private var dismiss
    @State private var showPractitionerEdit : Bool = false
    
    
    public var body: some View {
        ScrollView(.vertical) {
            VStack (spacing: 20) {
                header()
                
                HStack {
                    VStack {
                        Practitioner_picture(profileIcon: practitioner.profileIcon, frameSize: 90.0)
                        
                        Text(practitioner.fullName)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .foregroundStyle(Color.app_black)
                    }
                    
                    VStack (alignment: .trailing, spacing: 10) {
                        
                        Text(practitioner.work ?? "")
                        
                        Text(practitioner.establishment ?? "")
                        
                        Text(practitioner.mailAdress ?? "")
                        
                        Text(practitioner.phoneNumber ?? "")
                    }
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundStyle(Color.gray)
                    .hAlign(.trailing)
                }
                .padding(.horizontal)
                
                divider()
                
                Practitioner_adress_preview(practitioner: practitioner)
                
                divider()
            }
        }
        .padding()
        .background(Color.app_light_purple)
        .fullScreenCover(isPresented: $showPractitionerEdit) {
            Practitioner_edit(practitioner: $practitioner)
        }
    }
    
    @ViewBuilder
    private func divider() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .padding(.horizontal)
            .frame(height: 1, alignment: .center)
            .foregroundColor(.app_light_gray)
    }
    
    @ViewBuilder
    private func header() -> some View {
        HStack {
            Button(action: {
                showPractitionerEdit.toggle()
            }, label: {
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.app_black)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 25)
                    .fillView(.app_white)
            })
            
            Text("Your practitioner")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundStyle(Color.app_gray)
                .hAlign(.center)
            
            Button(action: {
                dismiss()
            }, label: {
                Text("OK")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.app_black)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 25)
                    .fillView(.app_white)
            })
        }
    }
}
