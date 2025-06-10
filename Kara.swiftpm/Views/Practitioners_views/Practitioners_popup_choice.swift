//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct Practitioners_popup_choice: View {
    
    // MARK: Data properties
    @Query private var practitionersQuery : [Practitioner]
    @Binding public var userSelected : User?
    @Binding public var practitionerChoice : Practitioner?
    
    private var practitioners : [Practitioner] {
        if let userSelected = userSelected {
            return practitionersQuery.filter { practitioner in
                practitioner.user == userSelected
            }
        } else {
            return []
        }
    }
    
    
    // MARK: View properties
    @Binding public var showPopup : Bool
    @State private var showPractitionersForm : Bool = false
    
    
    // MARK: Init
    public init(userSelected: Binding<User?>, practitionerChoice: Binding<Practitioner?>, showPopup: Binding<Bool>) {
        self._userSelected = userSelected
        self._practitionerChoice = practitionerChoice
        self._showPopup = showPopup
    }
    
    
    public var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical) {
                VStack {
                    HStack (alignment: .center) {
                        Text("Your practitioners")
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
                    
                    if !practitioners.isEmpty {
                        ForEach(practitioners) { practitioner in
                            Practitioner_preview_select(practitionerChoice: $practitionerChoice, practitioner: practitioner)
                                .padding(.horizontal, 10)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        practitionerChoice = practitioner
                                        showPopup.toggle()
                                    }
                                }
                        } 
                    } else if userSelected != nil {
                        Text("You have no practitioner")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.gray)
                            .padding(.top, 60)
                    }
                    
                    // ADD BUTTON
                    if userSelected != nil {
                        Button(action: {
                            showPractitionersForm.toggle()
                        }, label: {
                            HStack {
                                Text("Add a practitioner")
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
                .padding(.top, 10)
                .padding(.bottom, 15)
            }
            .frame(width: proxy.size.width*0.8, height: proxy.size.height*0.5)
            .background(Color.app_white)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .vAlign(.center)
            .hAlign(.center)
        }
        .fullScreenCover(isPresented: $showPractitionersForm) {
            Practitioner_form()
        }
    }
}
