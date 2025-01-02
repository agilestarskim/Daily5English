import SwiftUI


struct HomeView: View {
    @Environment(LearningService.self) private var learning
    @State private var viewModel = LearningContainerViewModel()
    
    var body: some View {
        @Bindable var bViewModel = viewModel
        NavigationStack {
            VStack(spacing: 20) {
                // 학습 현황 카드
                LearningStatusCard()
                
                Spacer()
                
                // 학습 시작 버튼
                Button(action: {
                    viewModel.isPresented = true
                }) {
                    Text("오늘의 학습 시작하기")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(DSColors.accent)
                        .foregroundColor(DSColors.Text.onColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal)
            }
            .padding()
            .fullScreenCover(isPresented: $bViewModel.isPresented) {
                LearningContainerView()
                    .environment(viewModel)
            }
        }
    }
}

struct LearningStatusCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("오늘의 학습")
                .font(.headline)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("학습 예정")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("5 단어")
                        .font(.title2)
                        .bold()
                }
                Spacer()
                CircularProgressView(progress: 3)
            }
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
} 
