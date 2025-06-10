//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//


import SwiftUI
import PhotosUI

public struct Appointment_attachments_list: View {
    
    //MARK: Data properties
    @Binding public var photoData : [Data]
    
    
    //MARK: View properties
    @Environment(\.dismiss) private var dismissSheet
    
    @State private var imageSelection : [PhotosPickerItem] = []
    @State private var editMode : Bool = false
    @State private var librairySelectorIsPresented : Bool = false
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
                    
                    addButton()
                }
            }
        }
        .padding()
        .photosPicker(isPresented: $librairySelectorIsPresented,
                      selection: $imageSelection,
                      matching: .images,
                      photoLibrary: .shared())
        .task(id: imageSelection) {
            if !imageSelection.isEmpty {
                for image in imageSelection {
                    if let data = try? await image.loadTransferable(type: Data.self) {
                        photoData.append(data)
                    }
                }
            }
        }
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
                
                Button {
                    editMode.toggle()
                } label: {
                    Text(editMode ? "Finished" : "Edit")
                        .font(.callout.bold())
                        .foregroundColor(.app_dark_gray)
                }
                
            }
        }
    }
    
    @ViewBuilder
    private func addButton() -> some View {
        Menu {
            Button {
                librairySelectorIsPresented = true
            } label: {
                Label("Add from Photo Library", systemImage: "photo.on.rectangle.angled")
            }
        } label : {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .strokeBorder(style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [10]))
                .frame(height: 180)
                .foregroundStyle(Color.app_dark_gray)
                .overlay {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .fontWeight(.light)
                        .foregroundStyle(Color.app_dark_gray)
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
            if !editMode {
                attachmentDataToShow = attachmentData
            }
        }
        .overlay {
            if editMode {
                Button(action: {
                    photoData.removeAll(where: { $0 == attachmentData })
                }, label: {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .foregroundStyle(Color.red)
                        .shadow(radius: 10)
                        .vAlign(.top)
                        .hAlign(.trailing)
                        .padding(.all, 5)
                })
            }
        }
    }
}
