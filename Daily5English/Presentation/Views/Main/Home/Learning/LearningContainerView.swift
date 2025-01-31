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
    
    private var initialWords: [Word]?
    
    // 초기화 메서드에서 단어 리스트를 받아 저장
    init(words: [Word]? = nil) {
        self.initialWords = words
    }
    
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
                    
                    // 퀴즈세션의 상태를 이용해 결과를 보여줘야하므로 ResultVM으로 상태 주입
                    learningResultViewModel.initialize(quizSessionViewModel: quizSessionViewModel)
                    
                    // 백점이면서 오늘 처음 학습이면서 단어장에서 오픈한게 아니라면
                    if learningResultViewModel.correctRate == 100 && !learning.hasLearnToday && initialWords == nil {
                        let wordsCount = learningSessionViewModel.totalWordCount
                        let words = learningSessionViewModel.words
                        
                        Task {
                            await learning.saveLearnedWords(words: words)
                            await homeData.saveStatistics(wordsCount: wordsCount)
                            await homeData.fetchStatistics()
                            await homeData.fetchLearningDates()
                            await learning.fetchHasLearnToday()
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
            // 외부에서 단어가 주입된 경우
            if let words = initialWords {
                print(words)
                learningSessionViewModel.setWords(words)
                let quizzes = learning.createQuizzes(from: words)
                quizSessionViewModel.setQuizzses(quizzes)
                viewModel.goToLearning()
            } else if learningSessionViewModel.words.isEmpty {
                // 외부에서 단어가 주입되지 않은 경우에만 새로운 단어를 가져옴
                let words = await learning.fetchWords(setting: setting.setting)
                let quizzes = learning.createQuizzes(from: words)
                
                learningSessionViewModel.setWords(words)
                quizSessionViewModel.setQuizzses(quizzes)
                
                viewModel.goToLearning()
            }
        }
    }
}

