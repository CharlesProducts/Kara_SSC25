//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//


import SwiftUI

public struct Appointment_attachments_preview: View {
    
    //MARK: Data properties
    @Binding public var photoData : [Data]
    
    
    //MARK: View properties
    @State private var showAttachmentList : Bool = false
    public var textBackground : Color = .app_white
    
    
    public var body: some View {
        GeometryReader { proxy in
            HStack {
                if !photoData.isEmpty {
                    ScrollView(.horizontal, showsIndicators: true) {
                        LazyHStack(spacing: 0) {
                            ForEach(photoData, id:\.self) { attachmentsData in
                                Attachment_image_preview(imageData: attachmentsData, size: CGSize(width: 170, height: 120))
                                    .cornerRadius(15.0)
                            }
                            .padding(.trailing, 10)
                        }
                        .padding(.leading, 15)
                        .padding(.vertical, 12)
                    }
                    .background_title(text: "Attachments", height: Float(proxy.size.height), isBold: true, backColor: textBackground)
                } else {
                    Text("No attachments")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .hAlign(.center)
                        .vAlign(.center)
                        .background_title(text: "Attachments", height: Float(proxy.size.height), isBold: true, backColor: textBackground)
                }
                
                Spacer()
                
                Button {
                    showAttachmentList = true
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 100, height: proxy.size.height)
                        .foregroundStyle(Color.app_dark_gray)
                        .overlay {
                            Image(systemName: "arrow.right")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 27, height: 16)
                                .foregroundColor(.app_white)
                        }
                }
            }
        }
        .frame(height: 150)
        .fullScreenCover(isPresented: $showAttachmentList) {
            NavigationView {
                Appointment_attachments_list(photoData: $photoData)
            }
        }
    }
    
}

