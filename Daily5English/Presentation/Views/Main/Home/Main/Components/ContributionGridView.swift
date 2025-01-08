import SwiftUI

struct ContributionGridView: View {
    let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 7)
    private let calendar = Calendar.current
    private var currentMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월"
        return formatter.string(from: Date())
    }
    
    // 이번 달의 날짜들을 가져오는 함수
    private var daysInMonth: [Date] {
        let now = Date()
        let range = calendar.range(of: .day, in: .month, for: now)!
        let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
        
        return range.compactMap { day in
            calendar.date(byAdding: .day, value: day - 1, to: firstDay)
        }
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
                ForEach(daysInMonth, id: \.self) { date in
                    let day = calendar.component(.day, from: date)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(contributionColor(for: Int.random(in: 0...5)))
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(
                            ZStack {
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.secondary.opacity(0.2), lineWidth: 0.5)
                                
                                Text("\(day)")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        )
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
