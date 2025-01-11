import SwiftUI

struct ContributionGridView: View {
    @Environment(HomeDataService.self) private var homeData
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 7)
    private let calendar = Calendar.current
    private var currentMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월"
        return formatter.string(from: Date())
    }
    
    // 이번 달의 날짜들을 가져오는 함수
    private var daysInMonth: [Date?] {
        let now = Date()
        let range = calendar.range(of: .day, in: .month, for: now)!
        let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
        
        // 첫째 날의 요일을 구합니다 (1은 일요일, 2는 월요일, ...)
        let firstWeekday = calendar.component(.weekday, from: firstDay)
        
        // 첫째 날 이전의 빈 셀을 위한 nil 배열
        let prefixDays = Array(repeating: nil as Date?, count: firstWeekday - 1)
        
        // 실제 날짜 배열
        let dates = range.compactMap { day -> Date? in
            calendar.date(byAdding: .day, value: day - 1, to: firstDay)
        }
        
        return prefixDays + dates
    }
    
    private func hasLearned(on date: Date) -> Bool {
        homeData.learningDates.contains { calendar.isDate($0, inSameDayAs: date) }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 16) {
                Text("\(currentMonth)의 학습 기록")
                    .font(.headline)
                
                HStack(spacing: 8) {
                    Circle()
                        .fill(DSColors.accent)
                        .frame(width: 8, height: 8)
                    Text("학습완료")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            // 요일 헤더
            HStack(spacing: 4) {
                ForEach(["일", "월", "화", "수", "목", "금", "토"], id: \.self) { day in
                    Text(day)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(Array(daysInMonth.enumerated()), id: \.offset) { _, date in
                    if let date = date {
                        let day = calendar.component(.day, from: date)
                        let hasLearned = hasLearned(on: date)
                        RoundedRectangle(cornerRadius: 4)
                            .fill(contributionColor(for: hasLearned ? 4 : 0))
                            .aspectRatio(1, contentMode: .fit)
                            .overlay(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.secondary.opacity(0.2), lineWidth: 0.5)
                                    
                                    Text("\(day)")
                                        .font(.caption2)
                                        .foregroundColor(hasLearned ? DSColors.Text.onColor : .secondary)
                                }
                            )
                    } else {
                        // 빈 셀
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.clear)
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
        }
    }
    
    private func contributionColor(for level: Int) -> Color {
        switch level {
        case 0: return Color.gray.opacity(0.1)
        case 1: return DSColors.accent.opacity(0.2)
        case 2: return DSColors.accent.opacity(0.4)
        case 3: return DSColors.accent.opacity(0.6)
        case 4: return DSColors.accent.opacity(0.8)
        default: return DSColors.accent
        }
    }
} 
