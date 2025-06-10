//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct History_alert: View {
    
    // MARK: Data properties
    @Query private var booboosQuery : [Booboo]
    private let userSelected : String
    private var booboos: [Booboo] {
        if userSelected == "Everyone" {
            return booboosQuery
        } else {
            return booboosQuery.filter { booboo in
                booboo.user!.firstName == userSelected
            }
        }
        
    }
    
    
    // MARK: View properties
    private var boobooWithoutAppointmentExist: Bool {
        for booboo in booboos {
            if booboo.appointments.isEmpty {
                return true
            }
        }
        
        return false
    }
    
    private var boobooNotCuredWithoudAppointmentExist: Bool {
        for booboo in booboos {
            if booboo.appointments.isEmpty && !booboo.isCured {
                return true
            }
        }
        
        return false
    }
    
    
    // MARK: Init
    public init(userSelected: String) {
        self.userSelected = userSelected
    }
    
    
    public var body: some View {
        VStack {
            if boobooNotCuredWithoudAppointmentExist {
                Notification_in_app(titleMessage: "Important Note",
                                    message: "You have a boo-boo without an appointment !")
            } else if boobooNotCuredWithoudAppointmentExist {
                Notification_in_app(titleMessage: "Important Note",
                                    message: "You have an unhealed boo-boo without an appointment !")
            }
        }
    }
}
