import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var todayProgress: Double = 0.0
    @Published var completedCount: Int = 0
    @Published var completedDates: Set<Date> = []
    @Published var currentStreak: Int = 0
    @Published var learningStatus: LearningStatus = .notStarted
    @Published var isLearningViewPresented: Bool = false
    
    private let calendar = Calendar.current
    
    func loadTodayProgress() async {
        // TODO: 서버에서 오늘의 학습 현황을 가져오는 로직 구현
        // 임시 데이터
        self.todayProgress = 0.3
        self.completedCount = 3
        self.completedDates = [Date()]
        self.currentStreak = 5
    }
    
    func startLearning() {
        isLearningViewPresented = true
        learningStatus = .inProgress
    }
}
