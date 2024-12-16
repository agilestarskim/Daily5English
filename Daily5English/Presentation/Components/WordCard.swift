import SwiftUI

struct WordCard: View {
    let word: Word
    
    var body: some View {
        DSCard {
            VStack(alignment: .leading, spacing: DSSpacing.xxSmall) {
                Text(word.english)
                    .font(DSTypography.heading3)
                    .foregroundColor(DSColors.Text.primary)
                
                Text(word.korean)
                    .font(DSTypography.body1)
                    .foregroundColor(DSColors.Text.secondary)
                
                Text(word.example)
                    .font(DSTypography.caption)
                    .foregroundColor(DSColors.Text.secondary)
            }
        }
    }
} 
