//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct Users_page: View {
    
    // MARK: Data properties
    @Query private var users: [User]
    @Query private var practitioners: [Practitioner]
    
    @State public var userNameSelected : String = ""
    @State private var profileNameSelectedChanged : Bool = false

    private var profileCards : [Card] {
        return users.map{Card(user: $0)}
    }
    
    @State private var practitionersGrouped : Array<EnumeratedSequence<[String: [Practitioner]]>.Element> = []

    
    // MARK: View properties
    @Binding public var tutorialStep : Int
    @State private var viewPath = NavigationPath()
    @State private var showPractitionerForm : Bool = false
    @State private var isFiltering : Bool = false
    
    private let screenSize = UIScreen.main.bounds.size
    
    private let gridItems : [GridItem] = [
        .init(.flexible(), spacing: 10),
        .init(.flexible(), spacing: 10)
    ]
    
    
    // MARK: Init
    public init(tutorialStep: Binding<Int>) {
        self._tutorialStep = tutorialStep
    }
    
    
    // MARK: Functions
    private func getPractitionersGrouped() -> Array<EnumeratedSequence<[String: [Practitioner]]>.Element> {
        var practitionersFiltered = [Practitioner]()
        var groupedPractitioner = [String: [Practitioner]]()
        var organizedPractitioner = [String: [Practitioner]]()
        
        if isFiltering {
            practitionersFiltered = practitioners.filter{$0.user!.firstName == userNameSelected}.sorted(by: {$0.fullName < $1.fullName})
        } else {
            practitionersFiltered = practitioners
        }
        
        // Sort by work
        for practitioner in practitionersFiltered.sorted(by: {$0.work ?? "Autres" < $1.work ?? "Autres"}) {
            let job = practitioner.work ?? "Autres"
            if groupedPractitioner[job] != nil {
                groupedPractitioner[job]?.append(practitioner)
            } else {
                groupedPractitioner[job] = [practitioner]
            }
        }
        
        // Get all the work category and put them into an "Autres" category
        for (key, value) in groupedPractitioner {
            if value.count > 1 {
                if organizedPractitioner[key] != nil {
                    organizedPractitioner[key]?.append(contentsOf: value)
                } else {
                    organizedPractitioner[key] = value
                }
            } else {
                // 999999999 is used to get the uncatogerized practioners at the end
                if organizedPractitioner["999999999"] != nil {
                    organizedPractitioner["999999999"]?.append(contentsOf: value)
                } else {
                    organizedPractitioner["999999999"] = value
                }
            }
        }
        
        organizedPractitioner["999999999"]?.sort(by: {$0.fullName < $1.fullName})
        
        return Array(organizedPractitioner.enumerated()).sorted(by: {$0.element.key < $1.element.key})
    }
    
    
    public var body: some View {
        NavigationStack(path: $viewPath) {
            ZStack {
                ScrollView(.vertical) {
                    LazyVStack {
                        ZStack {
                            header()
                                .zIndex(2)
                            
                            Users_HScroll(profileCards: profileCards, userNameSelected: $userNameSelected)
                                .padding(.top)
                        }
                        
                        filter()
                        
                        footer()
                            .padding(.bottom, 150)
                    }
                }
                .navigationTitle("Profiles")
                .toolbar(.hidden, for: .automatic)
                .navigationDestination(for: Int.self, destination: { index in
                    if index == 0 {
                        Settings(viewPath: $viewPath)
                    }
                })
                .onAppear {
                    userNameSelected = users.first?.firstName ?? ""
                    practitionersGrouped = getPractitionersGrouped()
                }
                .fullScreenCover(isPresented: $showPractitionerForm) {
                    Practitioner_form(user: (isFiltering ? users.first(where: {$0.firstName == userNameSelected}) : nil))
                }
                .onChange(of: userNameSelected) { oldValue, newValue in
                    if oldValue != newValue && isFiltering {
                        
                        practitionersGrouped = getPractitionersGrouped()
                    }
                }
                .onChange(of: isFiltering) {
                    practitionersGrouped = getPractitionersGrouped()
                }
                .onChange(of: practitioners) {
                    practitionersGrouped = getPractitionersGrouped()
                }
                
                tutorialStepView()
            }
            .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    private func header() -> some View {
        HStack(alignment: .center) {
            NavigationLink(value: 0) {
                Image(systemName: "gearshape")
                    .resizable()
                    .scaledToFit()
                    .fontWeight(.semibold)
                    .frame(height: 35)
                    .foregroundStyle(Color.app_black)
                    .padding(.trailing, 5)
            }
            
            Text("Profiles")
                .font(.system(size: 40, weight: .heavy))
        }
        .vAlign(.top)
        .hAlign(.leading)
        .padding(15)
    }
    
    @ViewBuilder
    private func filter() -> some View {
        HStack {
            Text("Your practitioners")
                .font(.system(size: 23))
                .fontWeight(.semibold)
                .hAlign(.leading)
                .foregroundStyle(Color.app_dark_gray)
            
            Button {
                showPractitionerForm = true
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 17, height: 17)
                    .scaledToFit()
                    .foregroundStyle(Color.app_dark_gray)
                    .background {
                        Circle()
                            .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [4]))
                            .foregroundStyle(Color.app_dark_gray)
                            .frame(width: 31, height: 31)
                    }
            }
            .padding(.trailing)

            
            Button(action: {
                isFiltering.toggle()
            }, label: {
                HStack {
                    Text(userNameSelected)
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundStyle(isFiltering ? Color.app_white : Color.app_dark_gray)
                        .padding(.trailing, 5)
                    
                    Image(systemName: isFiltering ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18)
                        .foregroundStyle(isFiltering ? Color.app_white : Color.app_dark_gray)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background {
                    RoundedRectangle(cornerRadius: 15.0)
                        .foregroundStyle(isFiltering ? Color.app_dark_gray : Color.app_light_gray)
                }
            })
        }
        .padding(.horizontal, 15)
    }
    
    @ViewBuilder
    private func footer() -> some View {
        VStack(spacing: 5) {
            ForEach(practitionersGrouped, id:\.0) { _, practitioners in
                VStack(spacing: 0) {
                    if practitionersGrouped.count > 1 {
                        Text(practitioners.key == "999999999" ? "Others" : practitioners.key)
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.app_gray)
                            .hAlign(.leading)
                            .padding(.leading, 15)
                            .padding(.bottom, -5)
                    }
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 15) {
                            ForEach(practitioners.value, id: \.self) { practitioner in
                                Practitioner_grid_card(practitioner: practitioner)
                                    .padding(.vertical)
                            }
                        }
                    }
                    .contentMargins(.horizontal, 15)
                }
            }
        }
    }
    
    @ViewBuilder
    private func tutorialStepView() -> some View {
        
        if tutorialStep == 8 {
            Tutorial_window_view(text: "You can find all your profiles here, just scroll to select.", tutorialStep: $tutorialStep, window_rect: CGRect(x: 10, y: 60, width: screenSize.width - 20, height: screenSize.height/3.6))
        } else if tutorialStep == 9 {
            Tutorial_window_view(text: "Then here you can add new practitioners", tutorialStep: $tutorialStep, window_rect: CGRect(x: 5, y: screenSize.height/2.85, width: screenSize.width - 10, height: 55))
        } else if tutorialStep == 10 {
            Tutorial_window_view(text: "To then be able to see them displayed right here", tutorialStep: $tutorialStep, window_rect: CGRect(x: 5, y: screenSize.height/2.85, width: screenSize.width - 10, height: screenSize.height))
        } else if tutorialStep == 11 {
            Tutorial_window_view(text: "Want to add a profile ? No worries, you can go to the settings to do so", tutorialStep: $tutorialStep, window_rect: CGRect(x: 5, y: 10.5, width: 55, height: 55))
        }
        
    }
}
