import SwiftUI

struct RecordView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: DSSpacing.medium) {
                    DailyProgressCard()
                    LearnedWordsCard()
                    LearnedSentencesCard()
                }
                .padding()
            }
            .navigationTitle("학습 기록")
        }
    }
} 