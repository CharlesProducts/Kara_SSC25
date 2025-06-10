//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct User_card: View {
    
    //MARK: Data properties
    @Environment(\.modelContext) private var modelContext
    @Bindable public var user : User
    
    
    //MARK: View properties
    @Binding public var userNameSelected : String
    @State private var autoSelectDone : Bool = false
    @State private var showUserEdit : Bool = false
    @State private var showAlert : Bool = false
    private var isSelected : Bool {
        return user.firstName == userNameSelected
    }
    let screenWidth = UIScreen.main.bounds.width
    
    
    //MARK: Functions
    private func calculateOffset(geometry: GeometryProxy) -> CGFloat {
        let x = geometry.frame(in: .global).midX
        return (x - screenWidth/2) * 0.35
    }
    
    private func autoSelectProfile(x: CGRect) {
        if x.minX > (screenWidth/3) && x.maxX < (screenWidth/3)*2 && userNameSelected != user.firstName && !autoSelectDone {
            withAnimation(.easeInOut) {
                autoSelectDone = true
                userNameSelected = user.firstName
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                autoSelectDone = false
            }
        }
    }
    
    private func deleteProfile() {
        modelContext.delete(user)
    }
    
    
    public var body: some View {
        GeometryReader {
            let size = $0.size
            RoundedRectangle(cornerRadius: 15.0)
                .foregroundStyle(isSelected ? Color.app_dark_gray : Color.app_light_gray)
                .overlay {
                    VStack(spacing: 5) {
                        HStack(alignment: .top) {
                            
                            User_picture_in_shape(userPhotoData: user.profilePictureData, frameSize: size.height / 2.36, photoShape: .square, colorPlaceholder: isSelected ? .app_white : .app_dark_gray)
                                .hAlign(.leading)
                            
                            halfRectangle(height: size.height / 2.36)
                        }
                        .vAlign(.top)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text(user.firstName)
                                .font(.system(size: 24).bold())
                                .minimumScaleFactor(0.8)
                                .foregroundStyle(Color.app_white)
                                .hAlign(.leading)
                            
                            Text("This text must be on two lines.")
                                .font(.system(size: 11))
                                .fontWeight(.medium)
                                .foregroundStyle(Color.gray)
                                .lineLimit(2, reservesSpace: true)
                                .padding(.leading, 1)
                            
                            Menu {
                                Group {
                                    Button("Edit", systemImage: "pencil") {
                                        showUserEdit = true
                                    }
                                    
                                    Button("Delete", systemImage: "trash", role: .destructive) {
                                        showAlert = true
                                    }
                                }
                            } label: {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .foregroundStyle(Color.app_white)
                                    .frame(width: 38, height: 24)
                                    .overlay {
                                        Image(systemName: "ellipsis")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 13)
                                    }
                            }
                            .disabled(!isSelected)
                            .hAlign(.trailing)
                        }
                        .hAlign(.leading)
                        .vAlign(.top)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 15)
                }
                .offset(y: -self.calculateOffset(geometry: $0))
                .onChange(of: $0.frame(in: .global)) { _ , value in
                    autoSelectProfile(x: value)
                }
        }
        .opacity(isSelected ? 1 : 0.7)
        .scaleEffect(isSelected ? 1 : 0.8)
        .shadow(radius: isSelected ? 10 : 0)
        .sheet(isPresented: $showUserEdit) {
            User_edit(user: $user)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Delete user profile ?"),
                  message: Text("Are you really sure? This action is irreversible !"),
                  primaryButton: Alert.Button.destructive(Text("Yes"), action: {deleteProfile()}),
                  secondaryButton: Alert.Button.default(Text("No")))
        }
    }
    
    @ViewBuilder 
    private func halfRectangle(height: CGFloat) -> some View {
        RoundedCornerShape()
            .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round))
            .foregroundStyle(Color.app_white)
            .frame(width: 42, height: 55)
            .padding([.top, .trailing], 3)
    }
    
}

public struct RoundedCornerShape: Shape {
    
    /// To create a rectangle corner
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let radius: CGFloat = 6
        let startPoint = CGPoint(x: rect.minX + radius, y: rect.minY)
        let horizontalEndPoint = CGPoint(x: rect.maxX - radius, y: rect.minY)
        let verticalEndPoint = CGPoint(x: rect.maxX, y: rect.maxY - radius)

        path.move(to: startPoint)
        path.addLine(to: horizontalEndPoint)
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius),
                    radius: radius,
                    startAngle: Angle(degrees: 270),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        path.addLine(to: verticalEndPoint)

        return path
    }
    
}
