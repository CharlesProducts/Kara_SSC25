//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct Booboo_popup_choice: View {
    
    //MARK: Data properties
    @Binding public var userSelected : User?
    @Binding public var boobooChoice : Booboo?
    @Query private var booboosQuery : [Booboo]
    private var booboos : [Booboo] {
        if let userSelected = userSelected {
            return booboosQuery.filter { booboo in
                booboo.user == userSelected
            }
        }
        return []
    }
    
    //MARK: View properties
    @Binding public var showPopup : Bool
    @State private var showBoobooForm : Bool = false
    @State private var defaultSelection : Bool = true
    
    // MARK: Initializer
    public init(userSelected: Binding<User?>, boobooChoice: Binding<Booboo?>, showPopup: Binding<Bool>) {
        self._userSelected = userSelected
        self._boobooChoice = boobooChoice
        self._showPopup = showPopup
    }
    
    
    public var body: some View {
        GeometryReader {proxy in
            ScrollView(.vertical) {
                VStack {
                    HStack (alignment: .center) {
                        Text("Your booboos")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.app_gray)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.easeInOut) {
                                showPopup.toggle()
                            }
                        }, label: {
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.app_gray)
                        })
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .padding(.top, 10)
                    
                    if !booboos.isEmpty {
                        ForEach(booboos) { booboo in
                            let color = booboo == boobooChoice ? Color.green : Color.app_light_gray
                            Booboo_preview(booboo: booboo, color: color)
                                .padding(.horizontal, 10)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        boobooChoice = booboo
                                        showPopup.toggle()
                                    }
                                }
                        }
                    } else if userSelected != nil {
                        Text("You have no boo-boo")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.gray)
                            .padding(.top, 60)
                    }
                    
                    // ADD BUTTON
                    if userSelected != nil {
                        Button(action: {
                            showBoobooForm.toggle()
                        }, label: {
                            HStack {
                                Text("Add a boo-boo")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(Color.app_gray)
                                
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(Color.app_gray)
                            }
                            .padding(.vertical, 15)
                            .hAlign(.center)
                            .fillClearView(.app_light_gray)
                        })
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                    } else {
                        Text("Select a user before")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.gray)
                            .padding(.top, 60)
                    }
                }
            }
            .frame(width: proxy.size.width*0.8, height: proxy.size.height*0.5)
            .background(Color.app_white)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .vAlign(.center)
            .hAlign(.center)
        }
        .fullScreenCover(isPresented: $showBoobooForm) {
            Booboo_form()
        }
    }
}
