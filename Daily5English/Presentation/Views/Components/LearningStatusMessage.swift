import SwiftUI

struct LearningStatusMessage: View {
    let hasStudied: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            // 상태에 따른 아이콘
            Circle()
                .fill(hasStudied ? .green : .orange)
                .frame(width: 40, height: 40)
                .overlay {
                    Image(systemName: hasStudied ? "checkmark.circle.fill" : "books.vertical.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .shadow(color: hasStudied ? .green.opacity(0.3) : .orange.opacity(0.3),
                       radius: 8, x: 0, y: 4)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(hasStudied ? "오늘 학습 완료! 🎉" : "아직 오늘 학습을 시작하지 않았어요")
                    .font(.subheadline)
                    .bold()
                
                Text(messageContent)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var messageContent: String {
        if hasStudied {
            return "학습한 내용을 내일 복습하면 기억력이 2배 향상됩니다!"
        } else {
            return "매일 5분 학습으로 영어 실력을 향상시켜보세요"
        }
    }
} 