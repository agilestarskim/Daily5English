import SwiftUI

struct WordBookView: View {
    @StateObject private var viewModel = WordBookViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                DSColors.background
                    .ignoresSafeArea()
                
                VStack(spacing: DSSpacing.medium) {
                    // 검색 바
                    SearchBar(text: $viewModel.searchText)
                    
                    // 세그먼트 컨트롤
                    Picker("보기 모드", selection: $viewModel.selectedTab) {
                        Text("학습 기록").tag(WordBookTab.history)
                        Text("북마크").tag(WordBookTab.bookmarks)
                    }
                    .pickerStyle(.segmented)
                    
                    // 단어 목록
                    ScrollView {
                        LazyVStack(spacing: DSSpacing.small) {
                            ForEach(viewModel.filteredWords) { word in
                                WordBookCard(
                                    word: word,
                                    isBookmarked: viewModel.isBookmarked(word),
                                    onBookmarkTap: {
                                        viewModel.toggleBookmark(word)
                                    }
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal, DSSpacing.Screen.horizontalPadding)
                .padding(.vertical, DSSpacing.Screen.verticalPadding)
            }
            .navigationTitle("나만의 단어장")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// SearchBar 수정
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        DSCard(style: .elevated) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(DSColors.Text.secondary)
                
                TextField("단어 검색", text: $text)
                    .font(DSTypography.body1)
                
                if !text.isEmpty {
                    Button(action: { text = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(DSColors.Text.secondary)
                    }
                }
            }
        }
    }
}

// 단어 카드 컴포넌트
struct WordBookCard: View {
    let word: WordItem
    let isBookmarked: Bool
    let onBookmarkTap: () -> Void
    
    var body: some View {
        DSCard {
            VStack(alignment: .leading, spacing: DSSpacing.small) {
                HStack {
                    Text(word.english)
                        .font(DSTypography.heading3)
                        .foregroundColor(DSColors.Text.primary)
                    
                    Spacer()
                    
                    Button(action: onBookmarkTap) {
                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                            .foregroundColor(DSColors.accent)
                    }
                }
                
                Text(word.korean)
                    .font(DSTypography.body1)
                    .foregroundColor(DSColors.Text.secondary)
                
                if let example = word.example {
                    Text(example)
                        .font(DSTypography.body2)
                        .foregroundColor(DSColors.Text.secondary)
                        .padding(.top, DSSpacing.xxSmall)
                }
                
                if let date = word.lastStudied {
                    Text("학습일: \(date.formatted(date: .abbreviated, time: .omitted))")
                        .font(DSTypography.caption1)
                        .foregroundColor(DSColors.Text.secondary)
                }
            }
            .padding()
        }
    }
}

// 데이터 모델
struct WordItem: Identifiable {
    let id: UUID
    let english: String
    let korean: String
    let example: String?
    let lastStudied: Date?
}

// 탭 열거형
enum WordBookTab {
    case history
    case bookmarks
} 
