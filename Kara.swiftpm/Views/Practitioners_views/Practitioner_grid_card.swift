//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI

public struct Practitioner_grid_card: View {
    
    //MARK: Data properties
    @Environment(\.modelContext) private var modelContext
    @Bindable public var practitioner : Practitioner
    
    
    //MARK: View properties
    @State private var showPractitionerInformation : Bool = false
    @State private var showPractitionerEdit : Bool = false
    @State private var showAlert : Bool = false
    
    
    //MARK: Functions
    private func deletePractitioner() {
        modelContext.delete(practitioner)
    }
    
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: practitioner.profileIcon)
                .resizable()
                .scaledToFit() 
                .frame(height: 50)
                .foregroundStyle(Color.app_dark_gray)
            
            Text(practitioner.fullName)
                .font(.system(size: 21).bold())
                .minimumScaleFactor(0.7)
                .foregroundStyle(Color.app_white)
                .lineLimit(2, reservesSpace: true)
                .multilineTextAlignment(.leading)
                .hAlign(.leading)
        
            Text(practitioner.work ?? "Job isn't registered")
                .font(.system(size: 11))
                .fontWeight(.semibold)
                .foregroundStyle(Color.app_gray)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .frame(height: 160)
        .frame(width: 130)
        .background {
            RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                .foregroundStyle(Color.app_light_gray)
        }
        .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 15.0)) 
        .onTapGesture {
            showPractitionerInformation = true
        }
        .contextMenu {
            Group {
                Button("Edit", systemImage: "pencil") {
                    showPractitionerEdit = true
                }
                
                Button("Delete", systemImage: "trash", role: .destructive) {
                    showAlert = true
                }
            }
        }
        .sheet(isPresented: $showPractitionerInformation) {
            Practitioner_informations(practitioner: practitioner)
        }
        .fullScreenCover(isPresented: $showPractitionerEdit) {
            Practitioner_edit(practitioner: $practitioner)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Delete practitioner ?"),
                  primaryButton: Alert.Button.destructive(Text("Yes"), action: deletePractitioner),
                  secondaryButton: Alert.Button.default(Text("No")))
        }
    }
}
