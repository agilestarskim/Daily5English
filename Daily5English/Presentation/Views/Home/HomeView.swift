import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: DSSpacing.medium) {
                LearningStatusCard()
                LearningStatisticsCard()
                QuickStartButton()
            }
            .padding()
            .navigationTitle("홈")
        }
    }
}

// 서브 컴포넌트들
struct LearningStatusCard: View {
    var body: some View {
        DSCard {
            VStack(alignment: .leading, spacing: DSSpacing.small) {
                Text("오늘의 학습")
                    .font(DSTypography.heading3)
                    .foregroundColor(DSColors.Text.primary)
                // 추가 컨텐츠
            }
        }
    }
}

struct LearningStatisticsCard: View {
    var body: some View {
        DSCard {
            VStack(alignment: .leading, spacing: DSSpacing.small) {
                Text("학습 통계")
                    .font(DSTypography.heading3)
                    .foregroundColor(DSColors.Text.primary)
                // 추가 컨텐츠
            }
        }
    }
}

struct QuickStartButton: View {
    var body: some View {
        DSButton(title: "빠른 학습 시작", action: {
            // 학습 시작 액션
        })
    }
} 