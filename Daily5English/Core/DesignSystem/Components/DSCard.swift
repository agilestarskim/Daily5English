import SwiftUI

struct DSCard<Content: View>: View {
    enum Style {
        case elevated
        case filled
        case outlined
    }
    
    let style: Style
    let isSelected: Bool
    let content: Content
    
    init(
        style: Style = .elevated,
        isSelected: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.style = style
        self.isSelected = isSelected
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(DSSpacing.Component.cardPadding)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(borderColor, lineWidth: style == .outlined ? 1 : 0)
            )
            .shadow(
                color: shadowColor,
                radius: style == .elevated ? 8 : 0,
                y: style == .elevated ? 2 : 0
            )
    }
    
    private var backgroundColor: Color {
        if isSelected {
            return DSColors.surfaceSelected
        }
        switch style {
        case .elevated, .outlined:
            return DSColors.surface
        case .filled:
            return DSColors.background
        }
    }
    
    private var borderColor: Color {
        isSelected ? DSColors.accent : DSColors.border
    }
    
    private var shadowColor: Color {
        Color.black.opacity(0.08)
    }
} 