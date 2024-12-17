import SwiftUI

struct DSButton: View {
    enum Style {
        case primary
        case secondary
        case text
    }
    
    enum Size {
        case large
        case medium
        case small
        
        var height: CGFloat {
            switch self {
            case .large: return 48
            case .medium: return 40
            case .small: return 32
            }
        }
        
        var horizontalPadding: CGFloat {
            switch self {
            case .large: return 24
            case .medium: return 16
            case .small: return 12
            }
        }
    }
    
    let title: String
    let style: Style
    let size: Size
    let icon: Image?
    let isEnabled: Bool
    let action: () -> Void
    
    init(
        title: String,
        style: Style = .primary,
        size: Size = .medium,
        icon: Image? = nil,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.size = size
        self.icon = icon
        self.isEnabled = isEnabled
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon {
                    icon
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(foregroundColor)
                }
                
                Text(title)
                    .font(DSTypography.button)
                    .foregroundColor(foregroundColor)
            }
            .frame(height: size.height)
            .padding(.horizontal, size.horizontalPadding)
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: style == .secondary ? 1 : 0)
            )
        }
        .disabled(!isEnabled)
    }
    
    private var backgroundColor: Color {
        guard isEnabled else { return DSColors.surface }
        
        switch style {
        case .primary: return DSColors.accent
        case .secondary: return .clear
        case .text: return .clear
        }
    }
    
    private var foregroundColor: Color {
        guard isEnabled else { return DSColors.Text.disabled }
        
        switch style {
        case .primary: return DSColors.Text.onColor
        case .secondary: return DSColors.accent
        case .text: return DSColors.Text.primary
        }
    }
    
    private var borderColor: Color {
        guard isEnabled else { return DSColors.border }
        return style == .secondary ? DSColors.accent : .clear
    }
} 
