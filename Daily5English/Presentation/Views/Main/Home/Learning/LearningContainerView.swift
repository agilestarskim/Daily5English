import SwiftUI

struct LearningContainerView: View {
    @Environment(LearningService.self) private var learning
    @Environment(LearningSettingService.self) private var setting
    @Environment(HomeDataService.self) private var homeData
    @Environment(WordBookService.self) private var wordBook
    
    @Environment(LearningContainerViewModel.self) private var viewModel
    
    @State private var learningSessionViewModel = LearningSessionViewModel()
    @State private var quizSessionViewModel = QuizSessionViewModel()
    @State private var learningResultViewModel = LearningResultViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.currentStep {
                case .ready:
                    ProgressView()
                    
                case .learning:
                    LearningSessionView()
                        .environment(learningSessionViewModel)
                    
                case .quiz:
                    QuizSessionView()
                        .environment(quizSessionViewModel)
                    
                case .result:
                    LearningResultView(restart: {
                        let words = learningSessionViewModel.words
                        let quizzes = learning.createQuizzes(from: words)
                        
                        learningSessionViewModel.reset()
                        quizSessionViewModel.reset(with: quizzes)
                        
                        viewModel.goToLearning()
                    })
                    .environment(learningResultViewModel)
                }
            }
            .onChange(of: viewModel.currentStep) {
                if viewModel.currentStep == .result {
                    learningResultViewModel.initialize(quizSessionViewModel: quizSessionViewModel)
                    
                    if learningResultViewModel.correctRate == 100 {
                        let wordsCount = learningSessionViewModel.totalWordCount
                        let words = learningSessionViewModel.words
                        
                        Task {
                            await learning.saveLearnedWords(words: words)
                            await learning.fetchHasLearnToday()
                            await homeData.saveStatistics(wordsCount: wordsCount)
                            await homeData.fetchStatistics()
                            await homeData.fetchLearningDates()
                            await wordBook.refresh()
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if viewModel.currentStep != .result {
                        Button("그만하기") {
                            viewModel.close()
                        }
                    }                    
                }
            }
        }
        .task {
            // 서비스에서 words와 quizzes를 생성한다.
            let words = await learning.fetchWords(setting: setting.setting)
            let quizzes = learning.createQuizzes(from: words)
            
            // 각 뷰모델에 주입한다.
            learningSessionViewModel.setWords(words)
            quizSessionViewModel.setQuizzses(quizzes)
            
            // 학습을 시작한다.
            viewModel.goToLearning()
        }
    }
}

