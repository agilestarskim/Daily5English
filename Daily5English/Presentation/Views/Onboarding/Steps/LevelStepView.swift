// 난이도 설정 스텝 뷰

import SwiftUI

struct LevelStepView: View {
    typealias Difficulty = LearningSettings.Difficulty
    @Binding var selectedLevel: Difficulty
    
    var body: some View {
        VStack(spacing: DSSpacing.large) {
            VStack(spacing: DSSpacing.small) {
                Text("학습 난이도를\n선택해주세요")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("현재 실력에 맞는 난이도로 시작해보세요\n나중에 언제든 변경할 수 있어요")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(DSColors.Text.secondary)
            }
            
            VStack(spacing: DSSpacing.medium) {
                ForEach([Difficulty.beginner, .intermediate, .advanced], id: \.self) { level in
                    Button {
                        selectedLevel = level
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(level.rawValue)
                                    .font(.headline)
                                Text(levelDescription(for: level))
                                    .font(.subheadline)
                                    .foregroundColor(DSColors.Text.secondary)
                            }
                            Spacer()
                            if selectedLevel == level {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(DSColors.accent)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedLevel == level ? DSColors.surfaceSelected : DSColors.surface)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
    
    private func levelDescription(for level: Difficulty) -> String {
        switch level {
        case .beginner: return "기초 단어, 간단한 문장"
        case .intermediate: return "일상 회화, 비즈니스 영어"
        case .advanced: return "전문 용어, 복잡한 표현"
        }
    }
}
