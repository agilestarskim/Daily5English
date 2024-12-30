enum LearningStatus {
    case notStarted
    case inProgress(LearningSession)
    case completed
} 