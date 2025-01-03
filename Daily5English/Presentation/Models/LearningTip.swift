struct LearningTip {
    let content: String
    let source: String?
    
    static var random: LearningTip {
        let tips = [
            LearningTip(
                content: "하루 5분 단어 학습으로 1년 후에는 1,800개 이상의 단어를 습득할 수 있습니다.",
                source: "Language Learning Research, 2023"
            ),
            LearningTip(
                content: "규칙적인 복습은 장기 기억력을 78% 향상시킵니다.",
                source: "Cognitive Science Journal, 2022"
            ),
            // 더 많은 팁들 추가...
        ]
        return tips.randomElement()!
    }
} 