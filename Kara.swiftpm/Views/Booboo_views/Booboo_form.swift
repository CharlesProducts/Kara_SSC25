//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct Booboo_form: View {
    
    // MARK: Data properties
    @Environment(\.modelContext) private var modelContext
    
    @State private var user : User?
    @State private var wording : String = ""
    @State private var bodyPart : String = "Left leg"
    @State private var date : Date = Date()
    @State private var isCured : Bool = false
    @State private var comment : String?
    
    // MARK: View properties
    @Environment(\.dismiss) private var dismiss
    @State private var showAttachmentViewer : Bool = false
    
    @FocusState private var wordingFieldIsFocus : Bool
    @FocusState private var commentFieldIsFocus : Bool
    
    // MARK: Functions
    public func saveBooboo() {
        
        guard let user = user else {
            print("ERROR : No user selected")
            return
        }
        
        let newBooboo = Booboo(
            user: user,
            wording: wording,
            bodyPart: bodyPart,
            isCured: !isCured,
            startDate: date,
            endDate: isCured ? Date() : nil,
            entryDate: Date(),
            modificationDate: Date(),
            comment: comment
        )
        
        modelContext.insert(newBooboo)
        dismiss()
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
                    .padding(.top, 10)
                    
                Form_date_picker(text: "Start date", dateChoice: $date)
                
                Custom_selector_view(isOne: $isCured, leftTextButton: "Not cured", rightTextButton: "Cured")
                
                Comment(text: $comment.toUnwrapped(defaultValue: ""), isFocus: $commentFieldIsFocus)
                    .padding(.top, 10)
                
                footer()
                    .padding(.top, 10)
            }
            .padding()
        }
    }
    
    @ViewBuilder
    public func header() -> some View {
        HStack(alignment: .bottom) {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .font(.callout.bold())
                    .foregroundColor(.app_dark_gray)
            }
            Spacer()
            Text("New boo-boo")
                .font(.title3.bold())
                .foregroundColor(.app_dark_gray)

        }.padding(.vertical)
    }
    
    @ViewBuilder
    public func footer() -> some View {
        Button {
            saveBooboo()
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.app_green)
                .frame(height: 70)
                .overlay {
                    Text("ADD")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.app_white)
                }
        }
        .disableWithOpacity(user == nil || wording == "")
    }
}
