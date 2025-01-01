import SwiftUI

struct LearningSessionView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(LearningService.self) private var learningService
    @Environment(LearningSettingService.self) private var learningSetting
    @State private var words: [Word] = []
    @State private var index = 0
    @State private var showQuizSession = false
    var body: some View {
        NavigationStack {
            ZStack {
                DSColors.background
                    .ignoresSafeArea()
                if !words.isEmpty {
                    
                    VStack(spacing: 24) {
                        // 진행 상태 표시
                        ProgressView(value: Double(index + 1), total: Double(words.count))
                            .tint(DSColors.accent)
                            .padding(.horizontal)
                        
                        // 현재 진행 상태 텍스트
                        Text("\(index + 1)/\(words.count)")
                            .font(DSTypography.body2)
                            .foregroundColor(DSColors.Text.secondary)
                        
                        Spacer()
                        
                        // 단어 카드
                        WordCard(word: words[index])
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        // 네비게이션 버튼
                        HStack(spacing: 16) {
                            Button(action: {
                                index -= 1
                            }) {
                                Image(systemName: "arrow.left.circle.fill")
                                    .font(.system(size: 44))
                                    .foregroundColor(index == 0 ? DSColors.Text.disabled : DSColors.accent)
                            }
                            .disabled(index == 0)
                            
                            Button(action: {
                                if index < words.count - 1 {
                                    index += 1
                                } else {
                                    showQuizSession = true
                                }
                            }) {
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.system(size: 44))
                                    .foregroundColor(DSColors.accent)
                            }
                        }
                        .padding(.bottom, 32)
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showQuizSession) {
                QuizSessionView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("그만하기") {
                        dismiss()
                    }
                    .foregroundColor(DSColors.Text.primary)
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .dismissLearningFlow)) { _ in
            dismiss()
        }
        .task {
            let setting = learningSetting.setting
            self.words = await learningService.fetchWords(setting: setting)
        }
    }
}

struct WordCard: View {
    let word: Word
    
    var body: some View {
        VStack(spacing: 24) {
            // 단어
            Text(word.english)
                .font(DSTypography.heading1)
                .foregroundColor(DSColors.Text.primary)
            
            // 의미
            VStack(spacing: 8) {
                Text(word.korean)
                    .font(DSTypography.heading2)
                    .foregroundColor(DSColors.Text.primary)
                
                Text(word.partOfSpeech.rawValue)
                    .font(DSTypography.caption1)
                    .foregroundColor(DSColors.Text.secondary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(DSColors.surface)
                    )
                                
            }
            
            // 구분선
            Rectangle()
                .fill(DSColors.divider)
                .frame(height: 1)
                .padding(.horizontal)
            
            // 예문
            VStack(alignment: .leading, spacing: 8) {
                Text("예문")
                    .font(DSTypography.caption1)
                    .foregroundColor(DSColors.Text.secondary)
                
                Text(word.example.english)
                    .font(DSTypography.body1)
                    .foregroundColor(DSColors.Text.primary)
                
                Text(word.example.korean)
                    .font(DSTypography.body2)
                    .foregroundColor(DSColors.Text.secondary)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(DSColors.surface)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
        )
    }
} 
