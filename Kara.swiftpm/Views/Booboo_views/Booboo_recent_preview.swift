//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct Booboo_recent_preview: View {
    
    //MARK: View properties
    @Binding public var path : NavigationPath
    
    
    //MARK: Data properties
    private let userSelected: String
    @Query(sort: \Booboo.modificationDate, order: .reverse) private var booboosQuery : [Booboo]
    private var booboosFiltredByUser : [Booboo] {
        if userSelected == "Everyone" {
            return booboosQuery
        } else {
            return booboosQuery.filter { booboo in
                booboo.user!.firstName == userSelected
            }
        }
    }
    
    private var boobooList : [Booboo] {
        return booboosFiltredByUser.count >= 3 ? Array(booboosFiltredByUser[0..<3]) : booboosFiltredByUser
    }
    
    
    // MARK: Init
    public init(path: Binding<NavigationPath>, userSelected: String) {
        self._path = path
        self.userSelected = userSelected
    }
    
    //MARK: Functions
    private func getColorState(booboo: Booboo) -> Color {
        if booboo.isCured {
            return .app_green
        } else if !booboo.appointments.isEmpty {
            return .app_yellow
        } else {
            return .app_red
        }
    }
    
    public var body: some View {
        HStack {
            VStack {
                if !boobooList.isEmpty {
                    GeometryReader { proxy in
                        VStack {
                            ForEach(boobooList) { booboo in
                                VStack(spacing: 8) {
                                    NavigationLink(value: booboo) {
                                        HStack {
                                            // Picture
                                            User_picture_in_shape(userPhotoData: booboo.user?.profilePictureData, frameSize: 40, photoShape: .circle)
                                             
                                            //Text
                                            VStack (alignment: .leading) {
                                                Text(booboo.wording)
                                                    .font(.system(size: 20))
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.app_black)
                                                
                                                
                                                Text(booboo.bodyPart)
                                                    .font(.system(size: 15))
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.app_gray)
                                            }
                                            Spacer()
                                            
                                            //State
                                            Circle()
                                                .frame(width: 15, height: 15)
                                                .foregroundColor(getColorState(booboo: booboo))
                                                .padding(.trailing)
                                        }
                                    }
                                    
                                    // Divider
                                    if booboo != boobooList.last {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: proxy.size.width/2, height: 1, alignment: .center)
                                            .foregroundColor(.app_gray)
                                    }
                                    
                                }
                            }
                        }
                    }
                } else {
                    Text("No boo-boo")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .hAlign(.center)
                }
            }
            .frame(height: 190)
            .padding(.top, 5)
            .padding(.horizontal, 5)
            .background_title(text: "Recent boo-boos", height: 210, isBold: true)
            
            NavigationLink(value: 1) {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 100, height: 210)
                    .foregroundColor(.app_dark_gray)
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
}
