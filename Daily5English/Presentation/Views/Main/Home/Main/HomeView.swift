import SwiftUI


struct HomeView: View {
    @Environment(AuthenticationService.self) private var auth
    @Environment(LearningService.self) private var learning
    @Environment(LearningSettingService.self) private var setting
    @Environment(HomeDataService.self) private var homeData
    
    @State private var viewModel = LearningContainerViewModel()
    @State private var hasStudiedToday: Bool = false
    
    var body: some View {
        @Bindable var bViewModel = viewModel
        NavigationStack {
            VStack(spacing: 0) {  // 스크롤뷰와 버튼을 담을 VStack
                ScrollView {
                    VStack(spacing: 20) {
                        // 1. 학습 팁 카드
                        LearningTipCard(
                            message: homeData.tip.message,
                            source: homeData.tip.source
                        )
                        
                        // 2. 학습 상태 메시지
                        LearningStatusMessage(hasStudied: learning.hasLearnToday)
                        
                        // 3. 학습 현황 블록
                        LearningStatusBlocks(
                            count: setting.count,
                            totalCount: homeData.stat.totalWordsCount,
                            streak: homeData.stat.streakDays,
                            totalDays: homeData.stat.totalLearningDays
                        )
                        
                        // 4. 학습 캘린더
                        LearningCalendarView()
                    }
                    .padding()
                }
                
                // 5. 학습 시작 버튼 (스크롤뷰 밖)
                StartLearningButton(
                    isPresented: $bViewModel.isPresented,
                    hasStudiedToday: learning.hasLearnToday
                )
                .padding(.horizontal)
                .padding(.bottom)
            }
            .fullScreenCover(isPresented: $bViewModel.isPresented) {
                LearningContainerView()
                    .environment(viewModel)
            }
            .onAppear {
                homeData.refreshTip()
            }
        }
    }
}

// 1. 학습 팁 카드 컴포넌트
struct LearningTipCard: View {
    
    let message: String
    let source: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(.yellow)
                Text("오늘의 학습 팁")
                    .font(.headline)
                Spacer()
            }
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            
            Text(source)
                .font(.caption2)
                .foregroundColor(.secondary)
            
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

// 2. 학습 현황 블록 컴포넌트
struct LearningStatusBlocks: View {
    
    let count: Int
    let totalCount: Int
    let streak: Int
    let totalDays: Int
    
    var body: some View {
        HStack(spacing: 6) {
            StatusBlock(
                title: "오늘 목표",
                value: String(count),
                unit: "단어",
                icon: "target",
                color: .accent
            )
            
            // 2. 총 학습 단어
            StatusBlock(
                title: "총 학습",
                value: String(totalCount),
                unit: "단어",
                icon: "book.fill",
                color: .success
            )
            
            // 3. 연속 학습
            StatusBlock(
                title: "연속 학습",
                value: String(streak),
                unit: "일",
                icon: "flame.fill",
                color: .error
            )
            
            // 4. 총 학습일
            StatusBlock(
                title: "총 학습일",
                value: String(totalDays),
                unit: "일",
                icon: "calendar",
                color: .warning
            )
        }
    }
}

struct StatusBlock: View {
    let title: String
    let value: String
    let unit: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
            
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
    let hasStudiedToday: Bool
    
    var body: some View {
        Button(action: {
            isPresented = true
        }) {
            Text(hasStudiedToday ? "복습하기" : "오늘의 학습 시작하기")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(DSColors.accent)
                .foregroundColor(DSColors.Text.onColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
} 
