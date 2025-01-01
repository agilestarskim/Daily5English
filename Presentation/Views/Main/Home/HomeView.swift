struct HomeView: View {
    @Environment(LearningService.self) private var learningService
    @State private var showLearningSession = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // 학습 현황 카드
                LearningStatusCard()
                
                Spacer()
                
                // 학습 시작 버튼
                Button(action: {
                    showLearningSession = true
                }) {
                    Text("오늘의 학습 시작하기")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal)
            }
            .padding()
            .navigationTitle("Daily 5")
            .fullScreenCover(isPresented: $showLearningSession) {
                NavigationStack {
                    LearningSessionView()
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button("닫기") {
                                    showLearningSession = false
                                }
                            }
                        }
                }
            }
        }
    }
}