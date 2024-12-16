import SwiftUI

struct DSTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .font(DSTypography.body1)
            .padding(DSSpacing.xxSmall)
            .background(DSColors.surface)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(DSColors.mainBlue.opacity(0.3), lineWidth: 1)
            )
    }
} 
