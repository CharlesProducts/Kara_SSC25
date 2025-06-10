//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Text_field: View {

    // MARK: View properties
    public let title : String
    @Binding public var text : String
    
    public var isFocus : FocusState<Bool>.Binding
    @State private var isReallyFocused : Bool = false
    
    public var suggestions : [String]? = nil
    private var suggestionsFiltered : [String] {
        if let suggestions = suggestions {
            return suggestions.filter({$0.localizedStandardContains(text)})
        }
        return []
    }
    
    public var height : Float = 50
    public var isBold : Bool = true
    
    
    public var body: some View {
        VStack {
            GeometryReader { _ in
                TextField("", text: $text)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .focused(isFocus)
                    .padding()
                    .onSubmit {
                        isFocus.wrappedValue.toggle()
                    }
            }
            .frame(height: CGFloat(height))
            .background_title(text: title, height: height, isBold: isBold)
            .onTapGesture {
                isFocus.wrappedValue.toggle()
            }
            
            if !suggestionsFiltered.isEmpty && isReallyFocused {
                ScrollView(.horizontal) {
                    HStack (spacing: 10) {
                        ForEach(suggestionsFiltered, id: \.self) { suggestion in
                            Button {
                                text = suggestion
                                isFocus.wrappedValue.toggle()
                            } label: {
                                Text(suggestion)
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(Color.app_white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 12)
                                    .background {
                                        RoundedRectangle(cornerRadius: 15.0)
                                            .foregroundStyle(Color.app_dark_gray)
                                    }
                            }
                        }
                    }
                    .padding(.leading, 10)
                }
                .scrollIndicators(.hidden)
            }
        }
        .onChange(of: isFocus.wrappedValue) {
            isReallyFocused = isFocus.wrappedValue
        }
    }
}
