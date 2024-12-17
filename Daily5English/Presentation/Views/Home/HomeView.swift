import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                DSColors.background
                    .ignoresSafeArea()
                
                VStack(spacing: DSSpacing.medium) {
                    DailyProgressView(
                        progress: viewModel.todayProgress,
                        totalCount: viewModel.dailyGoal
                    )
                    
                    LearningCalendarView(
                        completedDates: viewModel.completedDates
                    )
                    .onTapGesture {
                        viewModel.showStatistics = true
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, DSSpacing.Screen.horizontalPadding)
                .padding(.vertical, DSSpacing.Screen.verticalPadding)
                
                VStack {
                    Spacer()
                    LearningActionButton(status: viewModel.learningStatus) {
                        viewModel.startLearning()
                    }
                    .padding(.bottom, DSSpacing.large)
                }
            }
            .navigationTitle("홈")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $viewModel.showStatistics) {
                StatisticsView()
            }
        }
    }
}

struct DailyProgressView: View {
    let progress: Double
    let totalCount: Int
    
    var body: some View {
        DSCard(style: .elevated) {
            VStack(spacing: DSSpacing.small) {
                Text("오늘의 목표 \(totalCount)개 중 \(Int(progress * Double(totalCount)))개 완료")
                    .font(DSTypography.body1)
                    .foregroundColor(DSColors.Text.primary)
                
                DSGauge(
                    value: progress,
                    style: .linear,
                    size: .medium,
                    showLabel: true,
                    tint: DSColors.point
                )
            }
        }
    }
}

struct LearningCalendarView: View {
    let completedDates: Set<Date>
    
    var body: some View {
        DSCard(style: .elevated) {
            VStack(alignment: .leading, spacing: DSSpacing.small) {
                Text("학습 캘린더")
                    .font(DSTypography.heading3)
                    .foregroundColor(DSColors.Text.primary)
                
                Text("캘린더 뷰")
                    .font(DSTypography.body1)
                    .foregroundColor(DSColors.Text.secondary)
            }
        }
    }
}

struct LearningActionButton: View {
    let status: LearningStatus
    let action: () -> Void
    
    var buttonTitle: String {
        switch status {
        case .notStarted:
            return "암기 시작"
        case .inProgress:
            return "다시 시작"
        case .completed:
            return "복습 시작"
        }
    }
    
    var body: some View {
        DSButton(
            title: buttonTitle,
            style: .primary,
            size: .large,
            action: action
        )
        .padding(.horizontal, DSSpacing.Screen.horizontalPadding)
    }
}

struct StatisticsView: View {
    var body: some View {
        VStack(spacing: DSSpacing.medium) {
            Text("학습 통계")
                .font(DSTypography.heading2)
                .foregroundColor(DSColors.Text.primary)
        }
        .padding(.horizontal, DSSpacing.Screen.horizontalPadding)
        .padding(.vertical, DSSpacing.Screen.verticalPadding)
    }
} 
