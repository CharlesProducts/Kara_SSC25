//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct Booboo_choice: View {
    
    // MARK: Data properties
    @Binding public var boobooSelected : Booboo?
    
    // MARK: View properties
    @Binding public var showSelection : Bool
    
    public var body: some View {
        HStack {
            Image(uiImage: UIImage(named: "broken_bone.png") ?? UIImage(named: "snowboard")!)
                .resizable()
                .scaledToFit()
                .frame(height: 45.0)
                .padding(5)
            
            if let boobooSelected = boobooSelected {
                Text(boobooSelected.wording)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.app_black)
                    .lineLimit(2)
                    .hAlign(.leading) 
                
                
                Button(action: {
                    showSelection = true
                }, label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.all, 12)
                        .foregroundStyle(Color.app_dark_gray)
                        .fillView(.app_light_purple)
                })
            } else {
                Text("Select a boo-boo")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.app_black)
                    .hAlign(.leading)
                
                Button(action: {
                    showSelection = true
                }, label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.all, 12)
                        .foregroundStyle(Color.app_dark_gray)
                        .fillView(.app_light_purple)
                })
            }
        }
        .padding()
        .frame(height: 75)
        .fillView(.app_yellow)
    }
}
