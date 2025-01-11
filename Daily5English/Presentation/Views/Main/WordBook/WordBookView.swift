import SwiftUI

struct WordBookView: View {
    @Environment(WordBookService.self) private var wordBook
    @StateObject private var viewModel = WordBookViewModel()

    
    var body: some View {
        NavigationStack {
            ZStack {
                DSColors.background
                    .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: DSSpacing.medium) {
                        // 검색 바
                        SearchBar(text: $viewModel.searchText)
                        
                        // 세그먼트 컨트롤
                        Picker("보기 모드", selection: $viewModel.selectedTab) {
                            Text("학습 기록").tag(WordBookTab.history)
                            Text("북마크").tag(WordBookTab.bookmarks)
                        }
                        .pickerStyle(.segmented)
                        
                        // 단어 통계
                        WordStatistics(
                            totalWords: wordBook.wordsCount,
                            bookmarkedWords: 5
                        )
                        
                        // 단어 목록
                        LazyVStack(spacing: DSSpacing.xSmall) {
                            ForEach(wordBook.words, id: \.id) { learnWord in
                                WordBookCard(
                                    learnedWord: learnWord,
                                    isBookmarked: true,
                                    onBookmarkTap: {
                                        
                                    }
                                )
                                .onAppear {
                                    // 마지막 아이템이 나타나면 다음 페이지 로드
                                    if learnWord.id == wordBook.words.last?.id {
                                        Task {
                                            await wordBook.fetchLearnedWords()
                                        }
                                    }
                                }
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
            }
        }
    }
}

// 검색바 컴포넌트
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(DSColors.Text.secondary)
            
            TextField("단어 검색", text: $text)
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

// 단어 통계 컴포넌트
struct WordStatistics: View {
    let totalWords: Int
    let bookmarkedWords: Int
    
    var body: some View {
        HStack(spacing: DSSpacing.small) {
            StatBlock(
                title: "전체 단어",
                count: totalWords,
                icon: "book.fill",
                color: DSColors.success
            )
            
            StatBlock(
                title: "북마크",
                count: bookmarkedWords,
                icon: "bookmark.fill",
                color: DSColors.accent
            )
        }
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
    let isBookmarked: Bool
    let onBookmarkTap: () -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: DSSpacing.small) {
            VStack(alignment: .leading, spacing: 4) {
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
                
                
                if let date = learnedWord.lastReviewedAt {
                    Text(date.formatted(date: .abbreviated, time: .omitted))
                        .font(DSTypography.caption2)
                        .foregroundColor(DSColors.Text.secondary)
                }
            }
            
            Spacer()
            
            Button(action: onBookmarkTap) {
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundColor(isBookmarked ? DSColors.accent : DSColors.Text.secondary)
            }
        }
        .padding(DSSpacing.small)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// 탭 열거형
enum WordBookTab {
    case history
    case bookmarks
}
