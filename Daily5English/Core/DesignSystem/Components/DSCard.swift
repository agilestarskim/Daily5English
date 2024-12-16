import SwiftUI

struct DSCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(DSSpacing.small)
            .background(DSColors.surface)
            .cornerRadius(12)
            .shadow(
                color: Color.black.opacity(0.1),
                radius: 8,
                x: 0,
                y: 2
            )
    }
} 