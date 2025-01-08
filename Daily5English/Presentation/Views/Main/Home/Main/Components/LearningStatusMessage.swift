import SwiftUI

struct LearningStatusMessage: View {
    let hasStudied: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 4) {
                    Text(formattedDate)
                        .foregroundColor(.secondary)
                    Text(hasStudied ? "오늘 학습 완료" : "오늘 학습 미완료")
                }
                .font(.subheadline)
                .bold()
            }
            
            Spacer()
            
            // 상태에 따른 아이콘
            Circle()
                .fill(hasStudied ? .green : .red)
                .frame(width: 32, height: 32)
                .overlay {
                    Image(systemName: hasStudied ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                .shadow(color: hasStudied ? .green.opacity(0.3) : .red.opacity(0.3),
                       radius: 8, x: 0, y: 4)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var formattedDate: String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M/d (E)"
        return formatter.string(from: now)
    }
} 
