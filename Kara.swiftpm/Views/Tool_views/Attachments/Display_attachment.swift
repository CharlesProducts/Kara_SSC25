//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//


import SwiftUI

public struct Display_attachment: View {
    
    //MARK: Data properties
    @Environment(\.dismiss) private var dismissSheet
    public let attachmentData: Data
    
    
    public var body: some View {
        NavigationView {
            ZStack {
                if let uiImage = UIImage(data: attachmentData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("Loading...")
                        .font(.largeTitle)
                        .foregroundStyle(Color.app_black)
                }
            }
            .toolbar {
                HStack(alignment: .center) {
                    Button(action: {
                        dismissSheet()
                    }, label: {
                        Text("Done")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.app_black)
                            .hAlign(.trailing)
                            .vAlign(.bottom)
                    })
                }
                .padding(.bottom, 8)
            }
            .ignoresSafeArea()
        }
    }
}
