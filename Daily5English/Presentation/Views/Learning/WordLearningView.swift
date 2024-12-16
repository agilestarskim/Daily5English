import SwiftUI

struct WordLearningView: View {
    @StateObject private var viewModel = WordLearningViewModel()
    @State private var showMeaning = false
    
    var body: some View {
        VStack(spacing: DSSpacing.medium) {
            // 진행 상태
            ProgressBar(current: viewModel.currentIndex + 1, total: viewModel.totalWords)
                .frame(height: 4)
                .padding(.horizontal)
            
            Spacer()
            
            // 단어 카드
            DSCard {
                VStack(spacing: DSSpacing.medium) {
                    Text(viewModel.currentWord?.english ?? "")
                        .font(DSTypography.heading1)
                        .foregroundColor(DSColors.Text.primary)
                    
                    if showMeaning {
                        VStack(spacing: DSSpacing.small) {
                            Text(viewModel.currentWord?.korean ?? "")
                                .font(DSTypography.heading3)
                                .foregroundColor(DSColors.Text.secondary)
                            
                            Text(viewModel.currentWord?.example ?? "")
                                .font(DSTypography.body1)
                                .foregroundColor(DSColors.Text.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.top, DSSpacing.small)
                        }
                        .transition(.opacity)
                    }
                }
                .padding()
            }
            .onTapGesture {
                withAnimation {
                    showMeaning.toggle()
                }
            }
            
            Spacer()
            
            // 컨트롤 버튼들
            HStack(spacing: DSSpacing.medium) {
                DSButton(title: "이전", style: .secondary) {
                    withAnimation {
                        viewModel.previousWord()
                        showMeaning = false
                    }
                }
                
                DSButton(title: "다음") {
                    withAnimation {
                        viewModel.nextWord()
                        showMeaning = false
                    }
                }
            }
            .padding()
        }
        .navigationTitle("단어 학습")
        .navigationBarTitleDisplayMode(.inline)
    }
}

class WordLearningViewModel: ObservableObject {
    @Published private(set) var currentIndex = 0
    @Published private(set) var currentWord: Word?
    
    let totalWords = 10 // 임시 값
    
    func nextWord() {
        if currentIndex < totalWords - 1 {
            currentIndex += 1
            // 다음 단어 로드
        }
    }
    
    func previousWord() {
        if currentIndex > 0 {
            currentIndex -= 1
            // 이전 단어 로드
        }
    }
} 