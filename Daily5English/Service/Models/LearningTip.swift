struct LearningTip {
    let message: String
    let source: String
    
    static let defaults: Self = LearningTip(
        message: "하루에 새로 학습하는 단어를 7개로 제한하면 90% 이상의 기억 유지율을 보인다는 연구가 있어요",
        source: "Applied Language Studies, 2022"
    )    
}
