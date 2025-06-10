//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Booboo_attachments_list: View {
    
    //MARK: Data properties
    public var photoData : [Data]
    
    
    //MARK: View properties
    @Environment(\.dismiss) private var dismissSheet

    @State private var attachmentDataToShow : Data?
    @State private var showAttachment : Bool = false
    
    private let gridItems : [GridItem] = [
        .init(.flexible(), spacing: 10),
        .init(.flexible(), spacing: 10)
    ]
    
     
    public var body: some View {
        VStack {
            header()
                .padding(.bottom, 20)
            
            ScrollView(.vertical) {
                LazyVGrid(columns: gridItems, spacing: 10) {
                    ForEach(photoData, id:\.self) { attachmentData in
                        showAttachment(attachmentData: attachmentData)
            
                    }
                }
            }
        }
        .padding()
        .onChange(of: attachmentDataToShow, { oldValue, newValue in
            if let _ = attachmentDataToShow {
                showAttachment = true
            }
        })
        .fullScreenCover(isPresented: $showAttachment) {
            Display_attachment(attachmentData: attachmentDataToShow!)
        }
    }
    
    @ViewBuilder
    private func header() -> some View {
        ZStack {
            Text("Attachments")
                .font(.title3.bold())
                .foregroundColor(.app_dark_gray)
                .hAlign(.center)
            
            HStack(alignment: .bottom) {
                Button {
                    dismissSheet()
                } label: {
                    Text("Done")
                        .font(.callout.bold())
                        .foregroundColor(.app_dark_gray)
                }
                
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func showAttachment(attachmentData: Data) -> some View {
        VStack {
            GeometryReader { proxy in
                let size = proxy.size
                Attachment_image_preview(imageData: attachmentData, size: CGSize(width: size.width, height: 180))
                    .cornerRadius(15.0)
            }
        }
        .frame(height: 180)
        .onTapGesture {
            attachmentDataToShow = attachmentData
        }
    }
}
