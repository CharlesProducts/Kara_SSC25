//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import Contacts
import SwiftData

public struct Practitioner_edit: View {
    
    //MARK: Data properties
    @Query private var practitioners : [Practitioner]
    @Bindable public var practitioner : Practitioner
    @State private var original_practitioner : Practitioner?
    
    @State private var user : User?
    @State private var profileIcon : String = "person.crop.circle"
    @State private var fullName : String = ""
    @State private var work : String?
    @State private var establishment : String?
    @State private var adress : String?
    @State private var city : String?
    @State private var country : String?
    @State private var phoneNumber : String?
    @State private var mailAdress : String?
    @State private var comment : String?
    
    @State private var contact: CNContact?
    
    private var practitionerJobs : [String] {
        var practitionerJobs = [String]()
        for practitioner in practitioners {
            if let practitionersJob = practitioner.work {
                if !practitionerJobs.contains(where: { $0 == practitionersJob }) {
                    practitionerJobs.append(practitionersJob)
                }
            }
        }
        return practitionerJobs
    }
    
    
    //MARK: View properties
    @Environment(\.dismiss) private var dismiss
    
    @State private var showContactPicker : Bool = false
    
    @FocusState private var fullNameFocus : Bool
    @FocusState private var workFocus : Bool
    @FocusState private var establishmentFocus : Bool
    @FocusState private var adressFocus : Bool
    @FocusState private var cityFocus : Bool
    @FocusState private var countryFocus : Bool
    @FocusState private var phoneNumberFocus : Bool
    @FocusState private var mailAdressFocus : Bool
    @FocusState private var commentFocus : Bool
    
    
    // MARK: Init
    public init(practitioner: Bindable<Practitioner>) {
        self._practitioner = practitioner
    }
    
    
    //MARK: Functions
    private func savePractitioner() {
        saveChanges()
        dismiss()
    }
    
    private func copyOriginalPractitioner() {
        user = practitioner.user
        profileIcon = practitioner.profileIcon
        fullName = practitioner.fullName
        work = practitioner.work
        establishment = practitioner.establishment
        adress = practitioner.adress
        city = practitioner.city
        country = practitioner.country
        phoneNumber = practitioner.phoneNumber
        mailAdress = practitioner.mailAdress
        comment = practitioner.comment
    }
    
    private func saveChanges() {
        
        guard let user = user else {
            print("ERROR: User is nil")
            return
        }
        
        practitioner.user = user
        practitioner.profileIcon = profileIcon
        practitioner.fullName = fullName
        practitioner.work = work
        practitioner.establishment = establishment
        practitioner.adress = adress
        practitioner.city = city
        practitioner.country = country
        practitioner.phoneNumber = phoneNumber
        practitioner.mailAdress = mailAdress
        practitioner.comment = comment
        
    }
    
    private func requestAccessToContacts(completion: @escaping (Bool) -> Void) {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            completion(granted)
        }
    }
    
    private func fillPractitionerFileds() {
        practitioner.fullName = "\(contact?.givenName ?? "") \(contact?.familyName ?? "")"
        practitioner.work = contact?.jobTitle ?? ""
        practitioner.establishment = contact?.organizationName ?? ""
        practitioner.adress = contact?.postalAddresses.first?.value.street ?? ""
        practitioner.city = contact?.postalAddresses.first?.value.city ?? ""
        practitioner.country = contact?.postalAddresses.first?.value.country ?? ""
        practitioner.phoneNumber = contact?.phoneNumbers.first?.value.stringValue ?? ""
        practitioner.mailAdress = contact?.emailAddresses.first?.value.lowercased ?? ""
        practitioner.comment = contact?.note ?? ""
    }
    
    public var body: some View {
        ScrollView(.vertical) {
            VStack (spacing: 20) {
                header()
                
                Practitioner_picture_choice(profileIcon: $profileIcon, frameSize: 45.0)
                
                User_choice(userSelected: $user)
                    .padding(.vertical, 5)
                
                // All the field
                Text_field(title: "Full name", text: $fullName, isFocus: $fullNameFocus)
                
                Text_field(title: "Work", text: $work.toUnwrapped(defaultValue: ""), isFocus: $workFocus, suggestions: practitionerJobs)
                
                Text_field(title: "Establishment", text: $establishment.toUnwrapped(defaultValue: ""), isFocus: $establishmentFocus)
                
                Text_field(title: "Adress", text: $adress.toUnwrapped(defaultValue: ""), isFocus: $adressFocus)
                
                Text_field(title: "City", text: $city.toUnwrapped(defaultValue: ""), isFocus: $cityFocus)
                
                Text_field(title: "Country", text: $country.toUnwrapped(defaultValue: ""), isFocus: $countryFocus)
                
                Text_field(title: "Phone number", text: $phoneNumber.toUnwrapped(defaultValue: ""), isFocus: $phoneNumberFocus)
                
                Text_field(title: "Email adress", text: $mailAdress.toUnwrapped(defaultValue: ""), isFocus: $mailAdressFocus)
                
                footer()
                
            }.padding()
        }
        .sheet(isPresented: $showContactPicker) {
            ContactPicker(contact: $contact)
                .ignoresSafeArea()
        }
        .onChange(of: contact) {
            fillPractitionerFileds()
        }
        .onAppear(perform: copyOriginalPractitioner)
    }
    
    @ViewBuilder
    private func header() -> some View {
        HStack(alignment: .bottom) {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .font(.callout.bold())
                    .foregroundColor(.app_dark_gray)
            }
            
            Button {
                requestAccessToContacts { granted in
                    if granted {
                        DispatchQueue.main.async {
                            showContactPicker = true
                        }
                    } else {
                        print("Unable to access contacts")
                    }
                }
            } label: {
                Image(systemName: "square.and.arrow.down.fill")
                    .resizable()
                    .frame(width: 20, height: 24.6)
                    .foregroundStyle(Color.app_dark_gray)
            }
            .padding(.leading, 30)
            
            Text("Edit practitioner")
                .font(.title3.bold())
                .foregroundColor(.app_dark_gray)
                .hAlign(.trailing)

        }
    }
    
    @ViewBuilder
    private func footer() -> some View {
        Button {
            savePractitioner()
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.app_green)
                .frame(height: 70)
                .overlay {
                    Text("SAVE")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.app_white)
                }
        }

    }
}
