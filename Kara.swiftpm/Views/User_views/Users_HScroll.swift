//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Card : Identifiable, Hashable {
    public var id: UUID = .init()
    public var user : User
}

public struct Users_HScroll: View { 
    
    // MARK: Data properties
    @Binding public var userNameSelected : String
    public var profileCards: [Card]
    
    
    // MARK: Init
    public init(profileCards: [Card], userNameSelected: Binding<String>) {
        self.profileCards = profileCards
        self._userNameSelected = userNameSelected
    }
    
    
    public var body: some View {
        GeometryReader {
            let size = $0.size
            let cardWidth: CGFloat = 170 // or 150
            let cardSpacing: CGFloat = 80
            let horizontalPadding: CGFloat = (size.width - cardWidth) / 2 - cardSpacing / 2
            
            if profileCards.isEmpty {
                HStack {
                    Text("No profile found")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                        .vAlign(.center)
                        .hAlign(.center)
                }
            } else if profileCards.count == 1 {
                HStack {
                    User_card(user: profileCards[0].user, userNameSelected: $userNameSelected)
                        .frame(width: cardWidth, height: 200)
                        .offset(y: 20)
                        .hAlign(.center)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                userNameSelected = profileCards[0].user.firstName
                            }
                        }
                        .onAppear {
                            if userNameSelected != profileCards[0].user.firstName {
                                userNameSelected = profileCards[0].user.firstName
                            }
                        }
                }
                .vAlign(.center)
            } else if profileCards.count == 2 {
                HStack(spacing: 80) {
                    User_card(user: profileCards[0].user, userNameSelected: $userNameSelected)
                        .frame(width: cardWidth, height: 200)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                userNameSelected = profileCards[0].user.firstName
                            }
                        }
                    
                    User_card(user: profileCards[1].user, userNameSelected: $userNameSelected)
                        .frame(width: cardWidth, height: 200)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                userNameSelected = profileCards[1].user.firstName
                            }
                        }
                }
                .padding(.horizontal, 30)
                .vAlign(.center)
                .hAlign(.center)
            } else {
                LoopingScrollView(width: cardWidth, spacing: cardSpacing, items: profileCards) { card in
                    User_card(user: card.user, userNameSelected: $userNameSelected)
                        .frame(height: 200)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                userNameSelected = card.user.firstName
                            }
                        }
                }
                .contentMargins(.horizontal, horizontalPadding + 15, for: .scrollContent)
            }
        }
        .frame(height: 400)
    }
}
