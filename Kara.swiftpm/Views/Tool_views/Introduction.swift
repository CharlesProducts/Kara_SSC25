//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

struct Introduction: View { 
    
    // MARK: View properties
    @Binding var showIntroduction : Bool
    @State private var currentIndexCard : Int = 0
    
    // MARK: Functions
    private func nextCard() {
        if self.currentIndexCard >= 2 {
            self.showIntroduction = false
        }
        self.currentIndexCard += 1
    }
    
    var body: some View {
        VStack {
            if self.currentIndexCard == 0 {
                self.welcomeCard()
            } else if self.currentIndexCard == 1 {
                self.objectiveCard()
            } else {
                self.featuresCard()
            }
        }
        .hAlign(.center)
        .vAlign(.center)
        .background(.ultraThinMaterial)
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private func welcomeCard() -> some View {
        VStack(spacing: 30) {
            VStack(spacing: 60) {
                Text("📋")
                    .font(.system(size: 100))
                    .rotationEffect(Angle(degrees: 10.0))
                
                Text("Welcome on KARA")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                
            }
            .vAlign(.center)
            .padding(.bottom, 30)
            
            Text("Swift Student Challenge 2025")
                .font(.callout)
                .foregroundStyle(Color.black.opacity(0.7))
            
            Button {
                withAnimation(.smooth) {
                    self.nextCard()
                }
            } label: {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(height: 70)
                    .overlay {
                        Text("Continue")
                            .font(.title.bold())
                            .foregroundStyle(Color.white)
                    }
            }
        }
        .padding(40)
        .frame(width: 550, height: 700)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .shadow(radius: 10)
    }
    
    @ViewBuilder
    private func objectiveCard() -> some View {
        VStack(spacing: 30) {
            
            VStack(spacing: 30) {
                Text("📌")
                    .font(.system(size: 100))
                
                Text("What are the objectives ?")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
            }
            
            VStack(spacing: 30) {
                HStack(spacing: 35) {
                    Text("📋")
                        .font(.system(size: 40))
                    
                    Text("Keep a complete and organized medical history")
                        .font(.system(size: 18).bold())
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.leading)
                        .hAlign(.leading)
                }
                
                HStack(spacing: 35) {
                    Text("🗂️")
                        .font(.system(size: 40))
                    
                    Text("Centralize all health information")
                        .font(.system(size: 18).bold())
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.leading)
                        .hAlign(.leading)
                }
                
                HStack(spacing: 35) {
                    Text("⚡️")
                        .font(.system(size: 40))
                    
                    Text("Make appointment management easier")
                        .font(.system(size: 18).bold())
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.leading)
                        .hAlign(.leading)
                }
            }
            .padding(.horizontal, 32)
            .vAlign(.center)
            
            Button {
                withAnimation(.smooth) {
                    self.nextCard()
                }
            } label: {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(height: 70)
                    .overlay {
                        Text("Continue")
                            .font(.title.bold())
                            .foregroundStyle(Color.white)
                    }
            }
        }
        .padding(40)
        .frame(width: 550, height: 700)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .shadow(radius: 10)
    }
    
    @ViewBuilder
    private func featuresCard() -> some View {
        VStack(spacing: 30) {
            
            VStack(spacing: 20) {
                Text("🚥")
                    .font(.system(size: 100))
                
                Text("What are the major features ?")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
            }
            
            VStack(spacing: 20) {
                HStack(spacing: 35) {
                    Text("👥") 
                        .font(.system(size: 40))
                    
                    Text("Multi-profiles to manage the medical records of the whole family")
                        .font(.system(size: 18).bold())
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.leading)
                        .hAlign(.leading)
                }
                
                HStack(spacing: 35) {
                    Text("🦵")
                        .font(.system(size: 40))
                    
                    Text("Appointment history by symptom to keep track of health concerns")
                        .font(.system(size: 18).bold())
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.leading)
                        .hAlign(.leading)
                }
                
                HStack(spacing: 35) {
                    Text("🩻")
                        .font(.system(size: 40))
                    
                    Text("Store any type of document such as prescriptions or x-rays")
                        .font(.system(size: 18).bold())
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.leading)
                        .hAlign(.leading)
                }
                
                HStack(spacing: 35) {
                    Text("👩‍⚕️")
                        .font(.system(size: 40))
                    
                    Text("Medical contact book for quick access to practitioners with numbers, addresses and emails")
                        .font(.system(size: 18).bold())
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.leading)
                        .hAlign(.leading)
                }
            }
            .padding(.horizontal, 32)
            .vAlign(.center)

            Button {
                withAnimation(.smooth) {
                    self.nextCard()
                }
            } label: {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(height: 70)
                    .overlay {
                        Text("Start the tutorial")
                            .font(.title.bold())
                            .foregroundStyle(Color.white)
                    }
            }
        }
        .padding(40)
        .frame(width: 550, height: 700)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .shadow(radius: 10)
    }
}

#Preview {
    Introduction(showIntroduction: .constant(true))
}
