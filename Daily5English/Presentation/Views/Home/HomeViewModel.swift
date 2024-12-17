import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var todayProgress: Double = 0.3 // 더미 데이터
    @Published var dailyGoal: Int = 10
    @Published var completedDates: Set<Date> = [Date()] // 오늘 날짜만 더미로 추가
    @Published var learningStatus: LearningStatus = .notStarted
    @Published var showStatistics: Bool = false
    
    // MARK: - Private Properties
    private let calendar = Calendar.current
    
    // MARK: - Public Methods
    func startLearning() {
        // UI 테스트용 더미 상태 변경
        learningStatus = .inProgress
    }
    
    func refreshData() {
        // 더미 데이터 유지
    }
    
    func isDateCompleted(_ date: Date) -> Bool {
        completedDates.contains { calendar.isDate($0, inSameDayAs: date) }
    }
} 