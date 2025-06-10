//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftData
import SwiftUI

@MainActor
public final class AppState: ObservableObject {
    
    /// Makes it easier to manage loading presentation data
    
    // MARK: View properties
    @Published public var isLoading = true
    
    // MARK: Data properties
    public let modelContainer: ModelContainer
    
    // MARK: Initialization
    public init() {
        
        let config = ModelConfiguration(for: User.self, isStoredInMemoryOnly: false)

        do {
            modelContainer = try ModelContainer(for: User.self, configurations: config)
            if let path = modelContainer.configurations.first?.url.path(percentEncoded: false) {
                let attrs = [FileAttributeKey.protectionKey: FileProtectionType.complete]
                try? FileManager.default.setAttributes(attrs, ofItemAtPath: path)
            }
        } catch {
            fatalError("Failed to initialize store: \(error)")
        }
    }
    
    // MARK: Functions
    public func preloadDataIfNeeded() async {
        
        /// Starts loading presentation data
        
        let context = modelContainer.mainContext
        let fetchDescriptor = FetchDescriptor<User>()
        
        do {
            if try context.fetch(fetchDescriptor).isEmpty {
                await preloadData(context: context)
                print("Presentation data loaded ✅")
            }
        } catch {
            print("Error while verifying data: \(error)")
        }
        
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
    
    private func preloadData(context: ModelContext) async {
        
        /// Adds presentation data
        
        // Documents
        let doc1 = UIImage(named: "doc1.png")!.pngData()!
        let doc2 = UIImage(named: "doc2.png")!.pngData()!
        let doc3 = UIImage(named: "doc3.png")!.pngData()!
        
        let xray1 = UIImage(named: "xray1.png")!.pngData()!
        let xray2 = UIImage(named: "xray2.png")!.pngData()!
        
        // MARK: Louis samples -
        
        let louisProfilePhoto = UIImage(named: "Louis.png")?.pngData()
        let louisUser = User(firstName: "Louis", profilePictureData: louisProfilePhoto)
        
        let practitioner1 = Practitioner(user: louisUser, profileIcon: "eye", fullName: "Dr. Seward", work: "Ophthalmologist", establishment: "Medical office", adress: "425 Grove Street", city: "New York", country: "NY", phoneNumber: "0123456789", mailAdress: "mailAdresse@icloud.com", comment: "Second floor, door 20")
        
        let practitioner2 = Practitioner(user: louisUser, profileIcon: "eye", fullName: "Dr. Batista", work: "Ophthalmologist", establishment: "Medical office", adress: "425 Grove Street", city: "New York", country: "NY", phoneNumber: "0123456789", mailAdress: "mailAdresse@icloud.com", comment: "Second floor, door 20")
        
        let practitioner3 = Practitioner(user: louisUser, profileIcon: "stethoscope", fullName: "Dr. House", work: "Doctor", establishment: "Medical office", adress: "425 Grove Street", city: "New York", country: "NY", phoneNumber: "0123456789", mailAdress: "mailAdresse@icloud.com", comment: "Second floor, door 20")
        
        let practitioner4 = Practitioner(user: louisUser, profileIcon: "heart", fullName: "Dr. Strange", work: "Cardiologist", establishment: "Medical office", adress: "425 Grove Street", city: "New York", country: "NY", phoneNumber: "0123456789", mailAdress: "mailAdresse@icloud.com", comment: "Second floor, door 20")
        
        let visionBooboo = Booboo(user: louisUser, wording: "Distance vision problem", bodyPart: "Eyes", isCured: true, startDate: Date.initDateAt(day: 16, month: 7, year: 2024, hour: 12, minutes: 00), comment: "After a long day at work, I have trouble seeing the signs on the road. Same thing when I'm stressed.")
        
        let heartBooboo = Booboo(user: louisUser, wording: "Cardio increasing at rest", bodyPart: "Heart", isCured: false, startDate: Date.initDateAt(day: 10, month: 11, year: 2024, hour: 12, minutes: 00), comment: nil)
        
        
        let appointment1 = Appointment(booboo: visionBooboo, date: Date.initDateAt(day: 7, month: 8, year: 2024, hour: 9, minutes: 15), isDone: true, comment: "Eye exam, I lost some of my distance vision but stress and fatigue would make it worse.", practitioner: practitioner1, attachmentsData: [])
        
        let appointment2 = Appointment(booboo: visionBooboo, date: Date.initDateAt(day: 30, month: 7, year: 2024, hour: 17, minutes: 30), isDone: true, comment: nil, practitioner: practitioner2, attachmentsData: [])
        
        let appointment3 = Appointment(booboo: visionBooboo, date: Date.initDateAt(day: 16, month: 9, year: 2024, hour: 14, minutes: 45), isDone: true, comment: "Checking - advised me to go see my doctor", practitioner: practitioner1, attachmentsData: [])
        
        let appointment4 = Appointment(booboo: visionBooboo, date: Date.initDateAt(day: 26, month: 9, year: 2024, hour: 19, minutes: 30), isDone: true, comment: "My adviser on relaxation exercises", practitioner: practitioner3, attachmentsData: [])
        
        let appointment5 = Appointment(booboo: visionBooboo, date: Date.initDateAt(day: 24, month: 10, year: 2024, hour: 18, minutes: 45), isDone: true, comment: "Checking", practitioner: practitioner3, attachmentsData: [])
        
        let appointment6 = Appointment(booboo: visionBooboo, date: Date.initDateAt(day: 5, month: 11, year: 2024, hour: 17, minutes: 30), isDone: true, comment: "My vision is a little better thanks to the rest", practitioner: practitioner1, attachmentsData: [])
        
        let appointment7 = Appointment(booboo: visionBooboo, date: Date.initDateAt(day: 8, month: 1, year: 2025, hour: 16, minutes: 45), isDone: true, comment: "Checking", practitioner: practitioner1, attachmentsData: [doc1])
        
        let appointment8 = Appointment(booboo: visionBooboo, date: Calendar.current.date(byAdding: .day, value: -10, to: Date()) ?? Date(), isDone: true, comment: nil, practitioner: practitioner3, attachmentsData: [doc2])
        
        // - - -
        
        let appointment9 = Appointment(booboo: heartBooboo, date: Date.initDateAt(day: 24, month: 11, year: 2024, hour: 14, minutes: 20), isDone: true, comment: "Advise me to go see a cardiologist", practitioner: practitioner3, attachmentsData: [])
        
        let appointment10 = Appointment(booboo: heartBooboo, date: Date.initDateAt(day: 16, month: 2, year: 2025, hour: 8, minutes: 30), isDone: true, comment: nil, practitioner: practitioner4, attachmentsData: [])
        
        let appointment11 = Appointment(booboo: heartBooboo, date: Calendar.current.date(byAdding: .day, value: +1, to: Date()) ?? Date(), isDone: true, comment: "Bring the results", practitioner: practitioner3, attachmentsData: [])
        
        louisUser.practitioners.append(contentsOf: [practitioner1, practitioner2, practitioner3, practitioner4])
        louisUser.booboos.append(contentsOf: [visionBooboo, heartBooboo])
        visionBooboo.appointments.append(contentsOf: [appointment1, appointment2, appointment3, appointment4, appointment5, appointment6, appointment7, appointment8])
        heartBooboo.appointments.append(contentsOf: [appointment9, appointment10, appointment11])
        
        // MARK: Anna samples -
        
        let annaProfilePhoto = UIImage(named: "Anna.png")?.pngData()
        let annaUser = User(firstName: "Anna", profilePictureData: annaProfilePhoto)
        
        let practitioner5 = Practitioner(user: annaUser, profileIcon: "shoeprints.fill", fullName: "Dr. Bennett", work: "Podiatrist", establishment: "Medical office", adress: "425 Grove Street", city: "New York", country: "NY", phoneNumber: "0123456789", mailAdress: "mailAdresse@icloud.com", comment: "Second floor, door 20")
        
        let practitioner6 = Practitioner(user: annaUser, profileIcon: "stethoscope", fullName: "Dr. Greene", work: "Doctor", establishment: "Medical office", adress: "425 Grove Street", city: "New York", country: "NY", phoneNumber: "0123456789", mailAdress: "mailAdresse@icloud.com", comment: "Second floor, door 20")
        
        let feetBooboo = Booboo(user: annaUser, wording: "Male in heels", bodyPart: "Right foot", isCured: false, startDate: Date.initDateAt(day: 24, month: 11, year: 2024, hour: 12, minutes: 00), comment: "Since I started running")
        
        let coughBooboo = Booboo(user: annaUser, wording: "Rhume", bodyPart: "Lungs", isCured: false, startDate: Date.initDateAt(day: 23, month: 2, year: 2025, hour: 12, minutes: 00), comment: nil)
        
        let dermatologistBooboo = Booboo(user: annaUser, wording: "Mole that changes size", bodyPart: "Skin", isCured: false, startDate: Date.initDateAt(day: 18, month: 5, year: 2024, hour: 12, minutes: 00), comment: nil)
        
        
        let aAppointment1 = Appointment(booboo: feetBooboo, date: Date.initDateAt(day: 29, month: 11, year: 2024, hour: 9, minutes: 15), isDone: true, comment: "I need to find new running shoes", practitioner: practitioner5, attachmentsData: [doc3])
        
        let aAppointment2 = Appointment(booboo: feetBooboo, date: Date.initDateAt(day: 16, month: 1, year: 2025, hour: 17, minutes: 30), isDone: true, comment: nil, practitioner: practitioner5, attachmentsData: [])
        
        let aAppointment3 = Appointment(booboo: feetBooboo, date: Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date(), isDone: false, comment: nil, practitioner: practitioner5, attachmentsData: [])
        
        let aAppointment4 = Appointment(booboo: coughBooboo, date: Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date(), isDone: false, comment: nil, practitioner: practitioner6, attachmentsData: [])
        
        annaUser.practitioners.append(contentsOf: [practitioner5, practitioner6])
        annaUser.booboos.append(contentsOf: [feetBooboo, coughBooboo, dermatologistBooboo])
        feetBooboo.appointments.append(contentsOf: [aAppointment1, aAppointment2, aAppointment3])
        coughBooboo.appointments.append(contentsOf: [aAppointment4])
        
        // MARK: Leo samples -
        
        let leoProfilePhoto = UIImage(named: "Leo.png")?.pngData()
        let leoUser = User(firstName: "Leo", profilePictureData: leoProfilePhoto)
        
        let practitioner7 = Practitioner(user: leoUser, profileIcon: "person.and.background.dotted", fullName: "Dr. Silver", work: "Radiologist", establishment: "Medical office", adress: "425 Grove Street", city: "New York", country: "NY", phoneNumber: "0123456789", mailAdress: "mailAdresse@icloud.com", comment: "Second floor, door 20")
        
        let practitioner8 = Practitioner(user: leoUser, profileIcon: "stethoscope", fullName: "Dr. Benton", work: "Doctor", establishment: "Medical office", adress: "425 Grove Street", city: "New York", country: "NY", phoneNumber: "0123456789", mailAdress: "mailAdresse@icloud.com", comment: "Second floor, door 20")
        
        let contusionBooboo = Booboo(user: leoUser, wording: "Contusion", bodyPart: "Left leg", isCured: true, startDate: Date.initDateAt(day: 24, month: 5, year: 2022, hour: 12, minutes: 00), comment: "Bicycle accident")
        
        let fractureBooboo1 = Booboo(user: leoUser, wording: "Fracture", bodyPart: "Left leg", isCured: true, startDate: Date.initDateAt(day: 14, month: 5, year: 2023, hour: 12, minutes: 00), comment: "Playing football")
        
        let fractureBooboo2 = Booboo(user: leoUser, wording: "Fracture", bodyPart: "Left leg", isCured: true, startDate: Date.initDateAt(day: 18, month: 7, year: 2024, hour: 12, minutes: 00), comment: "Falling from a tree")
        
        
        let lAppointment1 = Appointment(booboo: contusionBooboo, date: Date.initDateAt(day: 24, month: 5, year: 2022, hour: 13, minutes: 30), isDone: true, comment: nil, practitioner: practitioner7, attachmentsData: [xray1, xray2])
        
        let lAppointment2 = Appointment(booboo: contusionBooboo, date: Date.initDateAt(day: 7, month: 6, year: 2022, hour: 17, minutes: 30), isDone: true, comment: nil, practitioner: practitioner8, attachmentsData: [doc2])
        
        let lAppointment3 = Appointment(booboo: contusionBooboo, date: Date.initDateAt(day: 28, month: 6, year: 2022, hour: 10, minutes: 30), isDone: true, comment: nil, practitioner: practitioner7, attachmentsData: [])
        
        
        let lAppointment4 = Appointment(booboo: fractureBooboo1, date: Date.initDateAt(day: 14, month: 5, year: 2023, hour: 13, minutes: 30), isDone: true, comment: nil, practitioner: practitioner7, attachmentsData: [xray1, xray2])
        
        let lAppointment5 = Appointment(booboo: fractureBooboo1, date: Date.initDateAt(day: 20, month: 6, year: 2023, hour: 17, minutes: 30), isDone: true, comment: nil, practitioner: practitioner8, attachmentsData: [doc2])
        
        let lAppointment6 = Appointment(booboo: fractureBooboo1, date: Date.initDateAt(day: 13, month: 7, year: 2023, hour: 10, minutes: 30), isDone: true, comment: nil, practitioner: practitioner7, attachmentsData: [])
        
        
        let lAppointment7 = Appointment(booboo: fractureBooboo2, date: Date.initDateAt(day: 18, month: 7, year: 2024, hour: 13, minutes: 30), isDone: true, comment: nil, practitioner: practitioner7, attachmentsData: [xray1, xray2])
        
        let lAppointment8 = Appointment(booboo: fractureBooboo2, date: Date.initDateAt(day: 3, month: 8, year: 2024, hour: 17, minutes: 30), isDone: true, comment: nil, practitioner: practitioner8, attachmentsData: [doc2])
        
        let lAppointment9 = Appointment(booboo: fractureBooboo2, date: Date.initDateAt(day: 14, month: 9, year: 2024, hour: 10, minutes: 30), isDone: true, comment: nil, practitioner: practitioner7, attachmentsData: [])
        
        leoUser.practitioners.append(contentsOf: [practitioner7, practitioner8])
        leoUser.booboos.append(contentsOf: [contusionBooboo, fractureBooboo1, fractureBooboo2])
        contusionBooboo.appointments.append(contentsOf: [lAppointment1, lAppointment2, lAppointment3])
        fractureBooboo1.appointments.append(contentsOf: [lAppointment4, lAppointment5, lAppointment6])
        fractureBooboo2.appointments.append(contentsOf: [lAppointment7, lAppointment8, lAppointment9])

        // MARK: Emma samples -
        
        let emmaProfilePhoto = UIImage(named: "Emma.png")?.pngData()
        let emmaUser = User(firstName: "Emma", profilePictureData: emmaProfilePhoto)
        
        let practitioner9 = Practitioner(user: emmaUser, profileIcon: "stethoscope", fullName: "Dr. Bovary", work: "Doctor", establishment: "Medical office", adress: "425 Grove Street", city: "New York", country: "NY", phoneNumber: "0123456789", mailAdress: "mailAdresse@icloud.com", comment: "Second floor, door 20")
        
        let erhumeoboo = Booboo(user: emmaUser, wording: "Rhume", bodyPart: "Lungs", isCured: false, startDate: Date.initDateAt(day: 20, month: 2, year: 2025, hour: 12, minutes: 00), comment: nil)
        
        let eAppointment1 = Appointment(booboo: erhumeoboo, date: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date(), isDone: false, comment: nil, practitioner: practitioner9, attachmentsData: [])
        
        emmaUser.practitioners.append(practitioner9)
        emmaUser.booboos.append(erhumeoboo)
        erhumeoboo.appointments.append(eAppointment1)
        
        // MARK: More practitioners
        let practitioner10 = Practitioner(user: emmaUser, profileIcon: "bubble.left.and.text.bubble.right", fullName: "Dr. Smith", work: "Psychologist", establishment: "Medical office", adress: "425 Grove Street", city: "New York", country: "NY", phoneNumber: "0123456789", mailAdress: "mailAdresse@icloud.com", comment: "Second floor, door 20")
        let practitioner11 = Practitioner(user: louisUser, profileIcon: "dog", fullName: "Dr. Waller", work: "Veterinarian", establishment: "Medical office", adress: "425 Grove Street", city: "New York", country: "NY", phoneNumber: "0123456789", mailAdress: "mailAdresse@icloud.com", comment: "Second floor, door 20")
        emmaUser.practitioners.append(practitioner10)
        louisUser.practitioners.append(practitioner11)
        
        context.insert(louisUser)
        context.insert(annaUser)
        context.insert(leoUser)
        context.insert(emmaUser)
        
        try? context.save()
    }
}
