//
//  KARA
//
//  Created for the Swift Student Challenge 2025
//
import SwiftUI

public struct LoopingScrollView<Content: View, Item: RandomAccessCollection>: View where Item.Element: Identifiable {
    
    // MARK: View properties
    public var width: CGFloat
    public var spacing: CGFloat = 0
    public var items: Item
    
    // MARK: Data properties
    @ViewBuilder public var content: (Item.Element) -> Content
    
    public var body: some View {
        GeometryReader {
            let size = $0.size
            
            /// Safety check
            let repeatingCount = width > 0 ? Int((size.width / width).rounded()) + 1 : 1
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: spacing) {
                    ForEach(items) {item in
                        content(item)
                            .frame(width: width)
                            .id(UUID())
                    }
                    
                    if items.count > 0 {
                        ForEach(0..<repeatingCount, id:\.self) {index in
                            let item = Array(items)[index % items.count]
                            content(item)
                                .frame(width: width)
                                .id(UUID())
                        }
                    }
                }
                .scrollTargetLayout()
                .background {
                    ScrollViewHelper(width: width, spacing: spacing, itemsCount: items.count, repeatingCount: repeatingCount)
                }
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }
}

fileprivate struct ScrollViewHelper: UIViewRepresentable {
    
    // MARK: View properties
    var width: CGFloat
    var spacing: CGFloat
    var itemsCount: Int
    var repeatingCount: Int
    
    
    // MARK: Functions
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(width: width, spacing: spacing, itemsCount: itemsCount, repeatingCount: repeatingCount)
        return coordinator
    }
    
    func makeUIView(context: Context) -> UIView {
        return .init()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            if let scrollView = uiView.superview?.superview?.superview as? UIScrollView, !context.coordinator.isAdded {
                context.coordinator.defaultDelegate = scrollView.delegate
                
                let mainContentSize = CGFloat(itemsCount) * width
                let spacingSize = CGFloat(itemsCount) * spacing
                scrollView.contentOffset.x += (mainContentSize + spacingSize)
                
                scrollView.delegate = context.coordinator
                context.coordinator.isAdded = true
            }
        }
        
        context.coordinator.width = width
        context.coordinator.spacing = spacing
        context.coordinator.itemsCount = itemsCount
        context.coordinator.repeatingCount = repeatingCount
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        
        var width: CGFloat
        var spacing: CGFloat
        var itemsCount: Int
        var repeatingCount: Int
        
        weak var defaultDelegate: UIScrollViewDelegate?
        
        init(width: CGFloat, spacing: CGFloat, itemsCount: Int, repeatingCount: Int) {
            self.width = width
            self.spacing = spacing
            self.itemsCount = itemsCount
            self.repeatingCount = repeatingCount
        }
        
        /// Tells us wheather the delegate is added or not
        var isAdded: Bool = false
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard itemsCount > 0 else { return }
            
            let minX = scrollView.contentOffset.x
            let mainContentSize = CGFloat(itemsCount) * width
            let spacingSize = CGFloat(itemsCount) * spacing
            
            if minX > (mainContentSize + spacingSize) {
                scrollView.contentOffset.x -= (mainContentSize + spacingSize)
            }
            
            if minX < 0 {
                scrollView.contentOffset.x += (mainContentSize + spacingSize)
            }
        }
        
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            defaultDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
        }
    }
}
