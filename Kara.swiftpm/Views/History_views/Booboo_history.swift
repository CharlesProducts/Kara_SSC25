//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//

import SwiftUI
import SwiftData

public struct Booboo_history: View {
    
    // MARK: View properties
    @Binding private var viewPath : NavigationPath
    @State private var search_text : String = ""
    @State private var showboobooForm : Bool = false
    @State private var showAlert : Bool = false
    
    
    // MARK: Data properties
    private let userSelected : String
    @Query(sort: \Booboo.modificationDate, order: .forward) private var booboosQuery : [Booboo]
    private var booboos : [Booboo] {
        if userSelected == "Everyone" {
            
            if search_text == "" {
                return booboosQuery
            } else {
                return booboosQuery.filter { booboo in
                    booboo.wording.localizedStandardContains(search_text) ||
                    booboo.bodyPart.localizedStandardContains(search_text)
                }
            }
            
        } else {
            
            if search_text == "" {
                return booboosQuery.filter { booboo in
                    booboo.user!.firstName == userSelected
                }
            } else {
                return booboosQuery.filter { booboo in
                    booboo.user!.firstName == userSelected && (
                        booboo.wording.localizedStandardContains(search_text) ||
                        booboo.bodyPart.localizedStandardContains(search_text))
                }
            }
            
        }
    }
    
    
    // MARK: Init
    public init(viewPath: Binding<NavigationPath>, userSelected: String) {
        self._viewPath = viewPath
        self.userSelected = userSelected
    }
    
    
    // MARK: Functions
    public func getColorState(booboo: Booboo) -> Color {
        if booboo.isCured {
            return .app_green
        } else if !booboo.appointments.isEmpty {
            return .app_yellow
        } else {
            return .app_red
        }
    }
    
    
    public var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 10) {
                
                Search_bar(searchText: $search_text)
                
                if search_text == "" {
                    Indicator_and_addButton(showForm: $showboobooForm, itemCount: booboos.count)
                }
                
                footer()
                    .padding(.top, 5)
            }
            .padding()
            .navigationTitle("Your boo-boos")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showboobooForm) {
                Booboo_form()
            }
        }
    }
    
    @ViewBuilder
    private func footer() -> some View {
        VStack (spacing: 15) {
            if booboos.isEmpty {
                Text("No boo-boo")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .hAlign(.center)
                    .padding(.top, 100)
            } else {
                ForEach(booboos) { booboo in
                    let boobooColor : Color = getColorState(booboo: booboo)
                        NavigationLink(value: booboo) {
                            Booboo_preview(booboo: booboo, color: boobooColor)
                        }
                }
            }
        }
    }
}
