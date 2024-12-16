import SwiftUI

struct SentenceLearningView: View {
    @StateObject private var viewModel = SentenceLearningViewModel()
    @State private var showTranslation = false
    @State private var isRecording = false
    
    var body: some View {
        VStack(spacing: DSSpacing.medium) {
            // 진행 상태
            ProgressBar(current: viewModel.currentIndex + 1, total: viewModel.totalSentences)
                .frame(height: 4)
                .padding(.horizontal)
            
            Spacer()
            
            // 문장 카드
            DSCard {
                VStack(spacing: DSSpacing.medium) {
                    Text(viewModel.currentSentence?.english ?? "")
                        .font(DSTypography.heading3)
                        .foregroundColor(DSColors.Text.primary)
                        .multilineTextAlignment(.center)
                    
                    if showTranslation {
                        VStack(spacing: DSSpacing.small) {
                            Text(viewModel.currentSentence?.korean ?? "")
                                .font(DSTypography.body1)
                                .foregroundColor(DSColors.Text.secondary)
                                .multilineTextAlignment(.center)
                            
                            // 문장 분석
                            SentenceAnalysisView(analysis: viewModel.currentSentence?.analysis ?? "")
                        }
                        .transition(.opacity)
                    }
                }
                .padding()
            }
            .onTapGesture {
                withAnimation {
                    showTranslation.toggle()
                }
            }
            
            Spacer()
            
            // 녹음 버튼
            RecordingButton(isRecording: $isRecording) {
                if isRecording {
                    viewModel.stopRecording()
                } else {
                    viewModel.startRecording()
                }
            }
            .padding(.bottom)
            
            // 컨트롤 버튼들
            HStack(spacing: DSSpacing.medium) {
                DSButton(title: "이전", style: .secondary) {
                    withAnimation {
                        viewModel.previousSentence()
                        showTranslation = false
                    }
                }
                
                DSButton(title: "다음") {
                    withAnimation {
                        viewModel.nextSentence()
                        showTranslation = false
                    }
                }
            }
            .padding()
        }
        .navigationTitle("문장 학습")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SentenceAnalysisView: View {
    let analysis: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: DSSpacing.xxSmall) {
            Text("문장 분석")
                .font(DSTypography.body2)
                .foregroundColor(DSColors.Text.primary)
            
            Text(analysis)
                .font(DSTypography.body2)
                .foregroundColor(DSColors.Text.secondary)
        }
        .padding()
        .background(DSColors.surface)
        .cornerRadius(8)
    }
}

struct RecordingButton: View {
    @Binding var isRecording: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(isRecording ? DSColors.error : DSColors.mainBlue)
                .frame(width: 64, height: 64)
                .overlay(
                    Image(systemName: isRecording ? "stop.fill" : "mic.fill")
                        .foregroundColor(.white)
                        .font(.title2)
                )
        }
    }
}

class SentenceLearningViewModel: ObservableObject {
    @Published private(set) var currentIndex = 0
    @Published private(set) var currentSentence: Sentence?
    
    let totalSentences = 5 // 임시 값
    
    func nextSentence() {
        if currentIndex < totalSentences - 1 {
            currentIndex += 1
            // 다음 문장 로드
        }
    }
    
    func previousSentence() {
        if currentIndex > 0 {
            currentIndex -= 1
            // 이전 문장 로드
        }
    }
    
    func startRecording() {
        // 녹음 시작 로직
    }
    
    func stopRecording() {
        // 녹음 중지 및 AI 분석 요청
    }
}

// 문장 모델
struct Sentence {
    let english: String
    let korean: String
    let analysis: String
} 