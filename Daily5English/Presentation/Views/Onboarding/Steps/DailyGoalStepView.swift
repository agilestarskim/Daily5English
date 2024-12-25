// 일일 학습량 설정 스텝 뷰

import SwiftUI

struct DailyGoalStepView: View {
    @Binding var selectedGoal: Int
    let goals = [3, 5, 7, 10]
    
    var body: some View {
        VStack(spacing: DSSpacing.large) {
            VStack(spacing: DSSpacing.small) {
                Text("하루에 몇 개의 단어를\n학습해볼까요?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("너무 많이 하면 부담스러울 수 있어요\n조금씩 꾸준히 해보는 건 어떨까요?")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(DSColors.Text.secondary)
            }
            
            VStack(spacing: DSSpacing.medium) {
                ForEach(goals, id: \.self) { goal in
                    Button {
                        selectedGoal = goal
                    } label: {
                        HStack {
                            Text("\(goal)개")
                                .font(.headline)
                            Spacer()
                            if selectedGoal == goal {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(DSColors.accent)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedGoal == goal ? DSColors.surfaceSelected : DSColors.surface)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
