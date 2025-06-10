//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Practitioner_adress_preview: View {
    
    //MARK: Data properties
    @Bindable public var practitioner : Practitioner
    
    
    //MARK: Functions
    private func getStringUrl() -> String {
        var str = "?q="
        if let adress = practitioner.adress {
            str += "\(adress)+"
        }
        if let city = practitioner.city {
            str += "\(city)+"
        }
        if let country = practitioner.country {
            str += "\(country)+"
        }
        return str
    }
    
    
    public var body: some View {
        HStack{
            if practitioner.adress != nil || practitioner.city != nil || practitioner.country != nil {
                VStack {
                    Text(practitioner.adress ?? "")
                        .hAlign(.leading)
                    Text(practitioner.city ?? "")
                        .hAlign(.leading)
                    Text(practitioner.country ?? "")
                        .hAlign(.leading)
                }
                .font(.system(size: 13))
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color.gray)
                .padding(.all, 10)
                .frame(height: 75)
                .hAlign(.leading)
                .fillView(.app_white)
                
            } else {
                
                Text("Aucune adresse")
                    .font(.system(size: 13))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.gray)
                    .padding(.all, 10)
                    .frame(height: 75)
                    .hAlign(.center)
                    .fillView(.app_white)
                
            }
            
            Button(action: {
                UIApplication.shared.open(URL(string: "tel://\(practitioner.phoneNumber ?? "")")!)
            }, label: {
                Image(systemName: "phone.fill")
                    .resizable()
                    .frame(width: 30, height: 31)
                    .foregroundStyle(Color.app_white)
                    .padding(.all, 20)
                    .frame(height: 75)
                    .fillView(.app_dark_gray)
            })
            .disableWithOpacity(practitioner.phoneNumber == nil)
            
            Button(action: {
                UIApplication.shared.open(URL(string: "http://maps.apple.com/\(getStringUrl())")!)
            }, label: {
                Image(systemName: "car")
                    .resizable()
                    .frame(width: 35, height: 28)
                    .foregroundStyle(Color.app_white)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 25)
                    .frame(height: 75)
                    .fillView(.app_dark_gray)
            })
            .disableWithOpacity(practitioner.adress == nil && practitioner.city == nil && practitioner.country == nil)
            
        }
    }
}
