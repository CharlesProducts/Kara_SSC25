//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Practitioner_profile_picture_choice: View {
    
    //MARK: Data properties
    @Binding public var iconSelected : String
    private let icons : [String] = [ 
        "person.crop.circle", "stethoscope", "heart", "eye", "lungs", "brain", "ear", "dog", "person.and.background.dotted", "bubble.left.and.text.bubble.right", "pills.circle", "testtube.2", "shoeprints.fill"
    ]
    
    //MARK: View properties
    @Environment(\.dismiss) private var dismiss
    private let gridItems : [GridItem] = [
        .init(.flexible(), spacing: 10),
        .init(.flexible(), spacing: 10),
        .init(.flexible(), spacing: 10)
    ]
    
    
    public var body: some View {
        VStack (spacing: 0) {
            ScrollView(.vertical) {
                LazyVGrid(columns: gridItems) {
                    ForEach(icons, id: \.self) { icon in
                        Image(systemName: icon)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 60)
                            .hAlign(.center)
                            .padding(15)
                            .background {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .foregroundStyle(Color.clear)
                                    .border(3.0, iconSelected == icon ? Color.app_green : Color.clear)
                            }
                            .onTapGesture {
                                withAnimation {
                                    iconSelected = icon
                                }
                            }
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal, 5)
            }
            
            Button {
                dismiss()
            } label: {
                RoundedRectangle(cornerRadius: 15.0)
                    .foregroundStyle(Color.app_green)
                    .frame(height: 50)
                    .overlay {
                        Text("SAVE")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundStyle(Color.app_white)
                            .padding()
                    }
            }
            .padding(.bottom, 20)
        }
        .padding(.horizontal)
    }
}
