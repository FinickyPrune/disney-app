import SwiftUI

// MARK: - StickyHeader

struct StickyHeader<Content: View>: View {
    // MARK: Lifecycle

    init(minHeight: CGFloat = 243, @ViewBuilder content: () -> Content) {
        self.minHeight = minHeight
        self.content = content()
    }

    // MARK: Internal

    var body: some View {
        GeometryReader { geo in
            self.content
                .offset(y: -max(0, geo.frame(in: .global).minY))
                .frame(width: geo.size.width, height: geo.size.height + max(0, geo.frame(in: .global).minY))
        }.frame(minHeight: self.minHeight, alignment: .center)
    }

    // MARK: Private

    private let minHeight: CGFloat
    private let content: Content
}
