//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct User_choice_button: View {
    
    //MARK: Data properties
    @Query private var users : [User]
    private var profilList : [String] {
        var profilList = ["Everyone"]
        profilList.append(contentsOf: users.map(\.firstName))
        return profilList
    }
    
    
    //MARK: View properties
    @Binding public var userSelected : String
    
    
    public var body: some View {
        Menu {
            ForEach(profilList, id: \.self) { profil in
                Button(profil) {
                    userSelected = profil
                }
            }
        } label: {
            HStack {
                Text(userSelected)
                    .font(.system(size: 15))
                
                Image(systemName: "chevron.down")
                
            }.font(.caption)
            .fontWeight(.semibold)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .foregroundColor(.app_white)
            .background(Color.app_dark_gray)
            .cornerRadius(15)
        }

    }
}
