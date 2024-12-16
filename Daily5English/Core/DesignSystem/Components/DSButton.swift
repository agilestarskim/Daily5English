import SwiftUI

struct DSButton: View {
    enum Style {
        case primary
        case secondary
        case text
    }
    
    let title: String
    let style: Style
    let action: () -> Void
    
    init(
        title: String,
        style: Style = .primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(DSTypography.body1)
                .padding(.horizontal, DSSpacing.small)
                .padding(.vertical, DSSpacing.xxSmall)
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(8)
        }
    }
    
    private var backgroundColor: Color {
        switch style {
        case .primary:
            return DSColors.mainBlue
        case .secondary:
            return DSColors.subGray
        case .text:
            return .clear
        }
    }
    
    private var foregroundColor: Color {
        switch style {
        case .primary, .secondary:
            return .white
        case .text:
            return DSColors.mainBlue
        }
    }
} 