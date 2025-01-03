import SwiftUI

struct ContributionGridView: View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 10)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 16) {
                Text("최근 30일간의 학습 기록이에요")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 8) {
                    Circle()
                        .fill(DSColors.accent)
                        .frame(width: 8, height: 8)
                    Text("학습완료")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(0..<30) { index in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(contributionColor(for: Int.random(in: 0...5)))
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.secondary.opacity(0.2), lineWidth: 0.5)
                        )
                }
            }
        }
    }
    
    private func contributionColor(for level: Int) -> Color {
        switch level {
        case 0: return Color.gray.opacity(0.1)
        case 1: return DSColors.accent.opacity(0.2)
        case 2: return DSColors.accent.opacity(0.4)
        case 3: return DSColors.accent.opacity(0.6)
        case 4: return DSColors.accent.opacity(0.8)
        default: return DSColors.accent
        }
    }
} 
