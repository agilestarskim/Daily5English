import SwiftUI


struct HomeView: View {
    @Environment(LearningService.self) private var learning
    @State private var viewModel = LearningContainerViewModel()
    @State private var hasStudiedToday: Bool = false
    
    var body: some View {
        @Bindable var bViewModel = viewModel
        NavigationStack {
            VStack(spacing: 0) {  // 스크롤뷰와 버튼을 담을 VStack
                ScrollView {
                    VStack(spacing: 20) {
                        // 1. 학습 팁 카드
                        LearningTipCard()
                        
                        // 2. 학습 상태 메시지
                        LearningStatusMessage(hasStudied: hasStudiedToday)
                        
                        // 3. 학습 현황 블록
                        LearningStatusBlocks()
                        
                        // 4. 학습 캘린더
                        LearningCalendarView()
                    }
                    .padding()
                }
                
                // 5. 학습 시작 버튼 (스크롤뷰 밖)
                StartLearningButton(isPresented: $bViewModel.isPresented)
                    .padding()
            }
            .fullScreenCover(isPresented: $bViewModel.isPresented) {
                LearningContainerView()
                    .environment(viewModel)
            }
        }
    }
}

// 1. 학습 팁 카드 컴포넌트
struct LearningTipCard: View {
    @State private var tip: LearningTip = LearningTip.random
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(.yellow)
                Text("오늘의 학습 팁")
                    .font(.headline)
            }
            
            Text(tip.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let source = tip.source {
                Text(source)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

// 2. 학습 현황 블록 컴포넌트
struct LearningStatusBlocks: View {
    var body: some View {
        HStack(spacing: 12) {
            StatusBlock(
                title: "오늘 목표",
                value: "5",
                unit: "단어",
                icon: "target"
            )
            
            StatusBlock(
                title: "연속 학습",
                value: "7",
                unit: "일",
                icon: "flame.fill"
            )
            
            StatusBlock(
                title: "총 학습",
                value: "152",
                unit: "단어",
                icon: "book.fill"
            )
        }
    }
}

struct StatusBlock: View {
    let title: String
    let value: String
    let unit: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(DSColors.accent)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack(alignment: .lastTextBaseline, spacing: 2) {
                Text(value)
                    .font(.title2)
                    .bold()
                Text(unit)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// 3. 학습 캘린더 뷰
struct LearningCalendarView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("학습 기록")
                .font(.headline)
            
            ContributionGridView()
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

// 시작 버튼 컴포넌트
struct StartLearningButton: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        Button(action: {
            isPresented = true
        }) {
            Text("오늘의 학습 시작하기")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(DSColors.accent)
                .foregroundColor(DSColors.Text.onColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
} 
