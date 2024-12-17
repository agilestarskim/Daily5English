import SwiftUI

struct DSTextField: View {
    let placeholder: String
    let icon: Image?
    let errorMessage: String?
    @Binding var text: String
    
    init(
        placeholder: String,
        icon: Image? = nil,
        errorMessage: String? = nil,
        text: Binding<String>
    ) {
        self.placeholder = placeholder
        self.icon = icon
        self.errorMessage = errorMessage
        self._text = text
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 12) {
                if let icon {
                    icon
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(DSColors.Text.secondary)
                }
                
                TextField(placeholder, text: $text)
                    .font(DSTypography.body1)
                    .foregroundColor(DSColors.Text.primary)
            }
            .frame(height: DSSpacing.Component.inputHeight)
            .padding(.horizontal, 16)
            .background(DSColors.surface)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 1)
            )
            
            if let errorMessage {
                Text(errorMessage)
                    .font(DSTypography.caption1)
                    .foregroundColor(DSColors.error)
                    .padding(.leading, 4)
            }
        }
    }
    
    private var borderColor: Color {
        if let errorMessage, !errorMessage.isEmpty {
            return DSColors.error
        }
        return DSColors.border
    }
} 
