import SwiftUI

struct QuizSessionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentQuizIndex = 0
    @State private var showResult = false
    
    var body: some View {
        VStack {
            // 진행 상태 바
            ProgressBar(progress: 0.5)
                .padding()
            
            // 퀴즈 문제
            Text("문제")
                .font(.title2)
                .padding()
            
            // 보기 선택지
            VStack(spacing: 15) {
                ForEach(0..<4) { index in
                    Button {
                        if currentQuizIndex < 3 {
                            currentQuizIndex += 1
                        } else {
                            showResult = true
                        }
                    } label: {
                        Text("보기 \(index + 1)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $showResult) {
            LearningResultView()
        }
    }
}

struct LearningResultView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("학습 완료!")
                .font(.title)
                .bold()
            
            VStack(spacing: 10) {
                Text("정답률")
                    .font(.headline)
                Text("80%")
                    .font(.system(size: 48, weight: .bold))
            }
            .padding()
            
            Button("완료") {
                // 모든 화면을 한 번에 닫기 위해 NotificationCenter 사용
                NotificationCenter.default.post(
                    name: .dismissLearningFlow,
                    object: nil
                )
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

// Notification 이름 정의
extension Notification.Name {
    static let dismissLearningFlow = Notification.Name("dismissLearningFlow")
}
