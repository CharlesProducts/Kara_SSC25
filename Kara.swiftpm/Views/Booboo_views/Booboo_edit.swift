//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct Booboo_edit: View {
    
    // MARK: Data properties
    @Bindable public var booboo : Booboo
    
    // MARK: View properties
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var wordingFieldIsFocus : Bool
    @FocusState private var commentFieldIsFocus : Bool
    
    @State private var showAttachmentViewer : Bool = false
    
    @State private var user : User?
    @State private var wording : String = ""
    @State private var bodyPart : String = "Left leg"
    @State private var date : Date = Date()
    @State private var isCured : Bool = false
    @State private var comment : String?
    
    // MARK: Initializer
    public init(booboo: Bindable<Booboo>) {
        self._booboo = booboo
    }
    
    // MARK: Functions
    private func saveBooboo() {
        saveChanges()
        booboo.modificationDate = Date()
        dismiss()
    }
    
    private func copyOriginalBooboo() {
        user = booboo.user
        wording = booboo.wording
        bodyPart = booboo.bodyPart
        date = booboo.startDate
        isCured = booboo.isCured
        comment = booboo.comment
    }
    
    private func saveChanges() {
        
        guard let user = user else {
            print("ERROR: No user selected")
            return
        }
        
        booboo.user = user
        booboo.wording = wording
        booboo.bodyPart = bodyPart
        booboo.startDate = date
        booboo.isCured = isCured
        booboo.comment = comment
    }
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack (spacing: 20) {
                header()
                
                Wording_choice(wording: $wording, isFocus: $wordingFieldIsFocus)
                    .focused($wordingFieldIsFocus)
                
                
                User_choice(userSelected: $user)
                    .padding(.top, 10)
                
                BodyPart_choice(bodyPartChoice: $bodyPart)
                    
                Form_date_picker(text: "Start date", dateChoice: $date)
                
                Custom_selector_view(isOne: $isCured, leftTextButton: "Cured", rightTextButton: "Not cured")
                
                Comment(text: $comment.toUnwrapped(defaultValue: ""), isFocus: $commentFieldIsFocus)
                    .padding(.top, 10)
                
                footer()
                    .padding(.top, 10)
            }
            .padding()
        }
        .onAppear(perform: copyOriginalBooboo)
    }
    
    private func header() -> some View {
        HStack(alignment: .bottom) {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .font(.callout.bold())
                    .foregroundColor(.app_dark_gray)
            }
            Spacer()
            Text("Edit boo-boo")
                .font(.title3.bold())
                .foregroundColor(.app_dark_gray)

        }.padding()
    }
    
    private func footer() -> some View {
        Button {
            saveBooboo()
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.app_green)
                .frame(height: 70)
                .overlay {
                    Text("SAVE")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.app_white)
                }
        }
        .disableWithOpacity(user == nil || wording == "")
    }
}
