//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public enum NextAppointmentsFilter {
    case currentWeek, nextWeek, all
}

public struct NextAppointmentsView: View {
    
    // MARK: View properties
    @State private var showAppointmentInformation : Bool = false
    
    @State private var weekOffset : Int = 0
    @State private var filter : String = "Everyone"
    
    
    // MARK: Data properties
    @Query private var users : [User]
    
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            Text("Next appointments")
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundStyle(Color.app_dark_gray)
                .padding(.horizontal)
            
            profileFilter()
             
            GeometryReader {
                let height = $0.size.height > 0 ? $0.size.height : 200
                ScrollViewReader { scrollValue in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack() {
                            NextAppointmentsCardView(title: "This week", maxHeight: height, userFilter: filter, appointmentFilter: .currentWeek)
                                .id(0)
                            
                            NextAppointmentsCardView(title: "Next week", maxHeight: height, userFilter: filter, appointmentFilter: .nextWeek)
                                .id(1)
                            
                            NextAppointmentsCardView(title: "All the upcoming", maxHeight: height, userFilter: filter, appointmentFilter: .all)
                                .id(2)
                        }
                        .padding(.vertical)
                        .padding(.bottom)
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .contentMargins(.horizontal, 15, for: .scrollContent)
                }
            }
            .padding(.bottom)
        }
        .padding(.bottom)
    }
    
    @ViewBuilder
    private func profileFilter() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                buttonProfileFilter("Everyone", isSelected: filter == "Everyone")
                    .padding(.leading)
                
                ForEach(users, id: \.id) { profileInList in
                    buttonProfileFilter(profileInList.firstName, isSelected: filter == profileInList.firstName)
                }
            }
        }
    }
    
    @ViewBuilder
    private func buttonProfileFilter(_ firstName: String, isSelected: Bool) -> some View {
        Text(firstName)
            .font(.system(size: 14))
            .fontWeight(.semibold)
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
            .foregroundColor(.app_white)
            .background {
                RoundedRectangle(cornerRadius: 15.0)
                    .foregroundStyle(isSelected ? Color.app_dark_gray : .app_light_gray)
            }
            .onTapGesture {
                withAnimation(.easeInOut) {
                    filter = firstName
                }
            }
    }

}
 
