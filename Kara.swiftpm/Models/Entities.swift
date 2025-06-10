//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

@Model
public final class User {
    
    public var firstName : String
    
    public var profilePictureData : Data?
    
    @Relationship(deleteRule: .cascade, inverse: \Booboo.user) public var booboos = [Booboo]()
    @Relationship(deleteRule: .cascade, inverse: \Practitioner.user) public var practitioners = [Practitioner]()
    
    public init(firstName: String = "", profilePictureData : Data? = nil) {
        self.firstName = firstName
        self.profilePictureData = profilePictureData
    }

}

@Model
public final class Booboo : Hashable {
    
    public var user : User?
    
    public var wording : String
    public var bodyPart : String
    public var isCured : Bool
    
    public var startDate : Date
    public var endDate : Date?
    public var entryDate : Date
    public var modificationDate : Date
    
    public var comment : String?

    @Relationship(deleteRule: .cascade, inverse: \Appointment.booboo) public var appointments = [Appointment]()
    
    public init(
        
        user: User, wording: String = "", bodyPart: String = "", isCured: Bool = false,
        startDate: Date = Date(), endDate: Date? = nil, entryDate: Date = Date(),
        modificationDate: Date = Date(), comment: String? = nil
        
    ) {
        
        self.user = user
        self.wording = wording
        self.bodyPart = bodyPart
        self.isCured = isCured
        self.startDate = startDate
        self.endDate = endDate
        self.entryDate = entryDate
        self.modificationDate = modificationDate
        self.comment = comment
    }
    
}

@Model
public final class Appointment { 
    
    public var booboo : Booboo?
    
    public var date : Date
    public var isDone : Bool
    public var comment : String?
    
    public var practitioner : Practitioner
    public var attachmentsData : [Data]
    
    public init(booboo: Booboo, date: Date = Date(), isDone: Bool = false, comment: String? = nil, practitioner: Practitioner, attachmentsData: [Data] = []) {
        self.booboo = booboo
        self.date = date
        self.isDone = isDone
        self.comment = comment
        self.practitioner = practitioner
        self.attachmentsData = attachmentsData
    }
    
}

@Model
public final class Practitioner {
    
    public var user : User?
    public var profileIcon : String
    
    public var fullName : String
    
    public var work : String?
    public var establishment : String?
    
    public var adress : String?
    public var city : String?
    public var country : String?
     
    public var phoneNumber : String?
    public var mailAdress : String?
    
    public var comment : String?
    
    public init(
        
        user: User, profileIcon: String = "person.crop.circle", fullName: String = "",
        work: String? = nil, establishment: String? = nil, adress: String? = nil, city: String? = nil,
        country: String? = nil, phoneNumber: String? = nil, mailAdress: String? = nil, comment: String? = nil
        
    ) {
        
        self.user = user
        self.profileIcon = profileIcon
        self.fullName = fullName
        self.work = work
        self.establishment = establishment
        self.adress = adress
        self.city = city
        self.country = country
        self.phoneNumber = phoneNumber
        self.mailAdress = mailAdress
        self.comment = comment
    }
    
}
