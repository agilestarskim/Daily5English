enum OnboardingStep: Int, CaseIterable {
    case guide1, guide2, category, dailyGoal, level
    
    var title: String {
        switch self {
        case .guide1: return "앱 사용 가이드 1"
        case .guide2: return "앱 사용 가이드 2"
        case .category: return "학습 카테고리 설정"
        case .dailyGoal: return "일일 학습량 설정"
        case .level: return "학습 난이도 설정"
        }
    }
} 