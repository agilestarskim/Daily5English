import SwiftUI

struct LearningSessionView: View {
    @Environment(LearningContainerViewModel.self) private var learningContainerViewModel
    @Environment(LearningSessionViewModel.self) private var viewModel
    
    var body: some View {
        ZStack {
            DSColors.background
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // 진행 상태 표시
                ProgressView(value: viewModel.learningProgress)
                    .tint(DSColors.accent)
                    .padding(.horizontal)
                
                // 현재 진행 상태 텍스트
                Text("\(viewModel.currentWordNumber)/\(viewModel.totalWordCount)")
                    .font(DSTypography.body2)
                    .foregroundColor(DSColors.Text.secondary)
                
                Spacer()
                
                // 단어 카드
                TabView(selection: .init(
                    get: { viewModel.wordIndex },
                    set: { newIndex in
                        withAnimation {
                            if newIndex > viewModel.wordIndex {
                                _ = viewModel.moveToNextWord()
                            } else if newIndex < viewModel.wordIndex {
                                viewModel.moveToPreviousWord()
                            }
                        }
                    }
                )) {
                    ForEach(Array(viewModel.words.enumerated()), id: \.element.id) { index, word in
                        WordCard(word: word)
                            .padding(.horizontal)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 400)
                
                Spacer()
                
                // 네비게이션 버튼
                HStack(spacing: 16) {
                    Button(action: {
                        withAnimation {
                            viewModel.moveToPreviousWord()
                        }
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .font(.system(size: 44))
                            .foregroundColor(viewModel.isFirstWord ? DSColors.Text.disabled : DSColors.accent)
                    }
                    .disabled(viewModel.isFirstWord)
                    
                    Button {
                        withAnimation {
                            if viewModel.moveToNextWord() {
                                learningContainerViewModel.goToQuiz()
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.system(size: 44))
                            .foregroundColor(DSColors.accent)
                    }
                }
                .padding(.bottom, 32)
            }
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
