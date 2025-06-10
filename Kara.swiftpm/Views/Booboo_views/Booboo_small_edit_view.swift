//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Booboo_small_edit_view: View {
    
    //MARK: View properties
    @Binding public var showBoobooEdit : Bool
    
    
    //MARK: Data properties
    @Bindable public var booboo: Booboo
    
    
    public var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack {
                    // Modif button
                    HStack {
                        Button {
                            showBoobooEdit = true
                        } label: {
                            RoundedRectangle(cornerRadius: 20)
                              .frame(width: 62, height: 38)
                              .foregroundColor(.app_light_purple)
                              .overlay {
                                  Image(systemName: "square.and.pencil")
                                      .resizable()
                                      .scaledToFit()
                                      .frame(width: 20, height: 20)
                                      .foregroundColor(.app_dark_gray)
                                      .hAlign(.center)
                                      .vAlign(.center)
                              }
                        }
                        
                        Button {
                            booboo.isCured.toggle()
                            booboo.modificationDate = Date()
                        } label: {
                            RoundedRectangle(cornerRadius: 20)
                              .frame(width: 62, height: 38)
                              .foregroundColor(.app_green)
                              .overlay {
                                  Image(systemName: "checkmark")
                                      .resizable()
                                      .scaledToFit()
                                      .frame(width: 15, height: 15)
                                      .foregroundColor(.app_dark_gray)
                                      .hAlign(.center)
                                      .vAlign(.center)
                              }
                        }

                    }
                    .hAlign(.leading)
                    
                    // Date information
                    HStack {
                        Text("Since :")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.app_black)
                        
                        Text(booboo.startDate.formatted(date: .numeric, time: .omitted))
                            .font(.system(size: 13))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 5)
                    .hAlign(.leading)
                }
                
                User_picture_in_shape(userPhotoData: booboo.user?.profilePictureData, frameSize: 65, photoShape: .square)
            }
            
            Divider()
                .frame(width: 250)
            
            if let comment = booboo.comment {
                Text(comment)
                    .font(.system(size: 13))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .hAlign(.leading)
                    .padding(.top)
                
                Spacer()
            } else {
                Text("No comments")
                    .font(.system(size: 13))
                    .fontWeight(.semibold)
                    .vAlign(.center)
            }
        }
        .padding(.all, 12)
        .frame(width: 500, height: 200)
        .fillClearView(booboo.isCured ? .app_dark_gray : .app_yellow)
    }
}
