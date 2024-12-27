import SwiftUI

struct HomeView: View {
    @Environment(UserSettingsManager.self) private var userSettingsManager
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                DSColors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: DSSpacing.large) {
                        // 1. 오늘의 학습 현황
                        DSCard(style: .elevated) {
                            DailyProgressView(
                                progress: viewModel.todayProgress,
                                completedCount: viewModel.completedCount,
                                totalCount: userSettingsManager.dailyGoal
                            )
                        }
                        
                        // 2. 이번달 학습 캘린더
                        DSCard(style: .elevated) {
                            MonthlyCalendarView(
                                completedDates: viewModel.completedDates,
                                streakCount: viewModel.currentStreak
                            )
                        }
                        
                        // 3. 광고 영역
                        BannerAdView()
                            .frame(height: 50)
                    }
                    .padding(.horizontal, DSSpacing.Screen.horizontalPadding)
                    .padding(.bottom, 80)
                }
                
                // 학습 시작 버튼 영역
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(DSColors.background)
                        .blur(radius: 20)
                        .frame(height: 80)
                        .overlay {
                            LearningActionButton(status: viewModel.learningStatus) {
                                viewModel.startLearning()
                            }
                            .padding(.horizontal, DSSpacing.Screen.horizontalPadding)
                            .padding(.vertical, DSSpacing.medium)
                        }
                }
            }
            .navigationTitle("홈")
            .navigationBarTitleDisplayMode(.large)
            .fullScreenCover(isPresented: $viewModel.isLearningViewPresented) {
                LearningView()
            }
            .task {
                await viewModel.loadTodayProgress()
            }
        }
    }
}

// 일일 학습 현황 뷰
struct DailyProgressView: View {
    let progress: Double
    let completedCount: Int
    let totalCount: Int
    
    var body: some View {
        VStack(spacing: DSSpacing.medium) {
            HStack {
                Text("오늘의 학습")
                    .font(DSTypography.heading3)
                    .foregroundColor(DSColors.Text.primary)
                Spacer()
                Text("\(completedCount)/\(totalCount)")
                    .font(DSTypography.body1)
                    .foregroundColor(DSColors.Text.secondary)
            }
            
            DSGauge(
                value: progress,
                style: .linear,
                size: .medium,
                showLabel: true,
                tint: DSColors.point
            )
        }
        .padding(DSSpacing.medium)
    }
}

// 월간 캘린더 뷰
struct MonthlyCalendarView: View {
    let completedDates: Set<Date>
    let streakCount: Int
    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    // 날짜 셀을 위한 구조체
    private struct DayCell: Identifiable {
        let id: String  // 고유 식별자
        let date: Date?
        let isCompleted: Bool
        
        init(index: Int, date: Date?, isCompleted: Bool) {
            self.id = "\(index)-\(date?.timeIntervalSince1970 ?? 0)"
            self.date = date
            self.isCompleted = isCompleted
        }
    }
    
    var body: some View {
        VStack(spacing: DSSpacing.medium) {
            HStack {
                Text("학습 캘린더")
                    .font(DSTypography.heading3)
                    .foregroundColor(DSColors.Text.primary)
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .foregroundColor(DSColors.point)
                    Text("\(streakCount)일")
                        .font(DSTypography.body2)
                        .foregroundColor(DSColors.Text.secondary)
                }
            }
            
            // 요일 헤더
            HStack {
                ForEach(["일", "월", "화", "수", "목", "금", "토"], id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .foregroundColor(DSColors.Text.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(getDayCells()) { cell in
                    if let _ = cell.date {
                        Circle()
                            .fill(cell.isCompleted ? DSColors.point : DSColors.surface)
                            .frame(width: 32, height: 32)
                    } else {
                        Circle()
                            .fill(.clear)
                            .frame(width: 32, height: 32)
                    }
                }
            }
        }
        .padding(DSSpacing.medium)
    }
    
    private func getDayCells() -> [DayCell] {
        let today = Date()
        let calendar = Calendar.current
        
        // 현재 달의 시작일과 마지막 날 구하기
        guard let monthInterval = calendar.dateInterval(of: .month, for: today),
              let firstWeekday = calendar.dateComponents([.weekday], from: monthInterval.start).weekday else {
            return []
        }
        
        let daysInMonth = calendar.range(of: .day, in: .month, for: today)?.count ?? 0
        let offsetDays = firstWeekday - 1  // 1일이 시작하는 요일까지의 빈 셀
        
        var cells: [DayCell] = []
        
        // 빈 셀 추가
        for i in 0..<offsetDays {
            cells.append(DayCell(index: i, date: nil, isCompleted: false))
        }
        
        // 날짜 셀 추가
        for day in 1...daysInMonth {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: monthInterval.start) {
                let isCompleted = completedDates.contains { calendar.isDate($0, inSameDayAs: date) }
                cells.append(DayCell(index: offsetDays + day - 1, date: date, isCompleted: isCompleted))
            }
        }
        
        return cells
    }
}

// 광고 뷰
struct BannerAdView: View {
    var body: some View {
        Color.gray.opacity(0.2) // 실제 광고로 교체 예정
            .overlay(
                Text("Advertisement")
                    .foregroundColor(.gray)
            )
    }
}

// 학습 시작 버튼
struct LearningActionButton: View {
    let status: LearningStatus
    let action: () -> Void
    
    var buttonTitle: String {
        switch status {
        case .notStarted: return "학습 시작하기"
        case .inProgress: return "학습 이어하기"
        case .completed: return "복습하기"
        }
    }
    
    var body: some View {
        Button(action: action) {
            Text(buttonTitle)
                .font(DSTypography.button)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(DSColors.accent)
                .cornerRadius(12)
        }
    }
} 
