import SwiftUI

@Observable
final class LearningResultViewModel {
    private var quizViewModel: QuizSessionViewModel?
    
    func initialize(quizSessionViewModel: QuizSessionViewModel) {
        self.quizViewModel = quizSessionViewModel
    }
    
    // MARK: - Display Properties
    var resultImage: String {
        switch correctRate {
        case 100:
            return "star.circle.fill"
        case 80...:
            return "hand.thumbsup.circle.fill"
        default:
            return "heart.circle.fill"
        }
    }
    
    var resultColor: Color {
        switch correctRate {
        case 100:
            return .yellow
        case 80...:
            return DSColors.accent
        default:
            return DSColors.point
        }
    }
    
    var resultTitle: String {
        switch correctRate {
        case 100:
            return "완벽해요! 🎉"
        case 80...:
            return "잘했어요! 👏"
        case 60...:
            return "좋아요! 💪"
        default:
            return "힘내세요! 💝"
        }
    }
    
    var resultMessage: String {
        switch correctRate {
        case 100:
            return "모든 문제를 맞히셨네요!\n오늘의 학습을 완벽하게 마치셨습니다."
        case 80...:
            return "거의 다 맞히셨어요!\n조금만 더 노력하면 완벽할 거예요."
        case 60...:
            return "무척 잘하셨어요!\n틀린 문제들을 복습하면 더 좋을 거예요."
        default:
            return "괜찮아요! 실수는 누구나 하는 거예요.\n다음에는 더 잘할 수 있을 거예요."
        }
    }
    
    // MARK: - Stats Properties
    var correctRate: Int {
        quizViewModel?.correctRate ?? 0
    }
    
    var totalWordCount: Int {
        quizViewModel?.totalQuizCount ?? 0
    }
    
    var correctCount: Int {
        quizViewModel?.correctCount ?? 0
    }
    
    var shouldShowRetry: Bool {
        correctRate < 100
    }
} 
