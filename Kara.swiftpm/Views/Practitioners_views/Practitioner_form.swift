//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import Contacts
import SwiftData

public struct Practitioner_form: View {
    
    // MARK: Data properties
    @Environment(\.modelContext) private var modelContext
    
    @State private var user : User?
    @State private var profileIcon : String = "person.crop.circle"
    @State private var fullName : String = ""
    @State private var work : String = ""
    @State private var establishment : String = ""
    @State private var adress : String = ""
    @State private var city : String = ""
    @State private var country : String = ""
    @State private var phoneNumber : String = ""
    @State private var mailAdress : String = ""
    @State private var comment : String = ""
    
    @Query private var practitioners : [Practitioner]
    private var practitionersJob : [String] {
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
    
    @State private var contact: CNContact?
    
    
    // MARK: View properties
    @Environment(\.dismiss) private var dismiss
    @State private var showContactPicker : Bool = false
    
    @FocusState private var fullNameFocus : Bool
    @FocusState private var nameFocus : Bool
    @FocusState private var workFocus : Bool
    @FocusState private var establishmentFocus : Bool
    @FocusState private var adressFocus : Bool
    @FocusState private var cityFocus : Bool
    @FocusState private var countryFocus : Bool
    @FocusState private var phoneNumberFocus : Bool
    @FocusState private var mailAdressFocus : Bool
    @FocusState private var commentFocus : Bool
    
    
    // MARK: Init
    public init(user: User? = nil) {
        self._user = State(initialValue: user)
    }
    
    
    // MARK: Functions
    private func check(_ variable: String) -> String? {
        if variable == "" {
            return nil
        } else {
            return variable
        }
    }
    
    private func savePractitioner() {
        
        guard let user = user else {
            print("ERROR: No user selected")
            dismiss()
            return
        }
        
        let practitioner = Practitioner(user: user, profileIcon: profileIcon, fullName: fullName, work: check(work), establishment: check(establishment), adress: check(adress), city: check(city),  country: check(country), phoneNumber: check(phoneNumber), mailAdress: check(mailAdress), comment: check(comment))
        modelContext.insert(practitioner)
        dismiss()
    }
    
    private func requestAccessToContacts(completion: @escaping (Bool) -> Void) {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            completion(granted)
        } 
    }
    
    private func fillPractitionerFileds() {
        fullName = "\(contact?.givenName ?? "") \(contact?.familyName ?? "")"
        work = contact?.jobTitle ?? ""
        establishment = contact?.organizationName ?? ""
        adress = contact?.postalAddresses.first?.value.street ?? ""
        city = contact?.postalAddresses.first?.value.city ?? ""
        country = contact?.postalAddresses.first?.value.country ?? ""
        phoneNumber = contact?.phoneNumbers.first?.value.stringValue ?? ""
        mailAdress = contact?.emailAddresses.first?.value.lowercased ?? ""
        comment = contact?.note ?? ""
    }
    
    
    public var body: some View {
        ScrollView(.vertical) {
            VStack (spacing: 20) {
                header()
                
                HStack (alignment: .top) {
                    Practitioner_picture_choice(profileIcon: $profileIcon, frameSize: 65.0)
                }
                
                User_choice(userSelected: $user)
                    .padding(.vertical, 5)
                
                // All the field
                Text_field(title: "Full name", text: $fullName, isFocus: $fullNameFocus)
                
                Text_field(title: "Work", text: $work, isFocus: $workFocus, suggestions: practitionersJob)
                
                Text_field(title: "Establishment", text: $establishment, isFocus: $establishmentFocus)
                
                Text_field(title: "Adress", text: $adress, isFocus: $adressFocus)
                
                Text_field(title: "City", text: $city, isFocus: $cityFocus)
                
                Text_field(title: "Country", text: $country, isFocus: $countryFocus)
                
                Text_field(title: "Phone number", text: $phoneNumber, isFocus: $phoneNumberFocus)
                
                Text_field(title: "Email address", text: $mailAdress, isFocus: $mailAdressFocus)
                
                footer()
                
            }
            .padding()
        }
        .sheet(isPresented: $showContactPicker) {
            ContactPicker(contact: $contact)
                .ignoresSafeArea()
        }
        .onChange(of: contact) {
            fillPractitionerFileds()
        }
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
            
            Text("New practitioner")
                .font(.title3.bold())
                .foregroundColor(.app_dark_gray)
                .hAlign(.trailing)

        }
    }
    
    private func footer() -> some View {
        Button {
            savePractitioner()
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.app_green)
                .frame(height: 70)
                .overlay {
                    Text("ADD")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.app_white)
                }
        }

    }
}

