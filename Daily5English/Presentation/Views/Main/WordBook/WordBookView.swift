import SwiftUI
import TipKit

struct WordBookView: View {
    @Environment(WordBookService.self) private var wordBook
    @StateObject private var viewModel = WordBookViewModel()
    
    @State private var learningContainerviewModel = LearningContainerViewModel()

    var body: some View {
        @Bindable var bLearningContainerviewModel = learningContainerviewModel
        NavigationStack {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: DSSpacing.medium) {
                        // 검색 바
                        SearchBar(
                            text: $viewModel.searchText,
                            count: wordBook.wordsCount
                        )
                        
                        // 팁을 보여주는 조건
                        if !viewModel.hasSeenTip {
                            TipView {
                                withAnimation(.bouncy) {
                                    viewModel.hasSeenTip = true
                                }
                            }
                            .transition(.scale)
                        }
                        
                        // 단어 목록
                        LazyVStack(spacing: DSSpacing.xSmall) {
                            // 모든 단어를 필터링하여 표시
                            ForEach(viewModel.filterWords(wordBook.words), id: \.id) { learnWord in
                                WordBookCard(
                                    learnedWord: learnWord
                                )
                            }
                            
                            if wordBook.isLoading {
                                ProgressView()
                                    .padding()
                            }
                        }
                    }
                    .padding(.horizontal, DSSpacing.Screen.horizontalPadding)
                }
                .refreshable {
                    await wordBook.refresh()
                }
                
                // 복습하기 버튼
                Button(action: {
                    learningContainerviewModel.isPresented = true
                }) {
                    Text("복습하기")
                        .font(DSTypography.body1.bold())
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(DSColors.accent)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal, DSSpacing.Screen.horizontalPadding)
                .padding(.bottom, DSSpacing.medium)
            }
            .background(DSColors.background.ignoresSafeArea())
            .fullScreenCover(isPresented: $bLearningContainerviewModel.isPresented) {
                let words = wordBook.words.shuffled().prefix(5).map(\.word)
                LearningContainerView(words: words)
                    .environment(learningContainerviewModel)
            }
        }
    }
}

// 검색바 컴포넌트
struct SearchBar: View {
    @Binding var text: String
    let count: Int
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(DSColors.Text.secondary)
            
            TextField("단어 검색 (\(count))", text: $text)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .textFieldStyle(.plain)
                .font(DSTypography.body1)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(DSColors.Text.secondary)
                }
            }
        }
        .padding(DSSpacing.small)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct StatBlock: View {
    let title: String
    let count: Int
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(DSTypography.caption1)
                    .foregroundColor(DSColors.Text.secondary)
                
                Text("\(count)")
                    .font(DSTypography.heading3)
                    .foregroundColor(DSColors.Text.primary)
            }
            Spacer()
        }
        .padding(DSSpacing.small)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// 단어 카드 컴포넌트
struct WordBookCard: View {
    let learnedWord: LearnedWord
    // 북마크 관련 코드 제거
    
    var body: some View {
        HStack(alignment: .center, spacing: DSSpacing.small) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .firstTextBaseline, spacing: DSSpacing.xSmall) {
                    Text(learnedWord.word.english)
                        .font(DSTypography.body1.bold())
                        .foregroundColor(DSColors.Text.primary)
                    
                    Text(learnedWord.word.korean)
                        .font(DSTypography.body2)
                        .foregroundColor(DSColors.Text.secondary)
                }
                
                
                Text(learnedWord.word.example.english)
                    .font(DSTypography.caption1)
                    .foregroundColor(DSColors.Text.secondary)
                    .lineLimit(1)
                
                Text(learnedWord.word.example.korean)
                    .font(DSTypography.caption1)
                    .foregroundColor(DSColors.Text.secondary)
                    .lineLimit(1)
                
                
                if let date = learnedWord.lastReviewedAt {
                    Text(date.formatted(date: .abbreviated, time: .omitted))
                        .font(DSTypography.caption2)
                        .foregroundColor(DSColors.Text.secondary)
                }
            }
            
            Spacer()
        }
        .padding(DSSpacing.small)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// 팁 뷰 컴포넌트
struct TipView: View {
    let tapClose: () -> Void

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(DSColors.warning)
                
                Text("지금까지 학습한 단어들이 저장됩니다. 틈날 때마다 복습을 통해 평생 기억하세요")
                    .font(DSTypography.body2)
                    .foregroundColor(DSColors.Text.secondary)
                
                Spacer()
                
                Button(action: tapClose) {
                    Image(systemName: "xmark")
                        .foregroundColor(DSColors.Text.secondary)
                }
            }
            .padding(DSSpacing.small)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
