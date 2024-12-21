import SwiftUI

struct ProfileViewTest: View {
    var body: some View {
        NavigationStack {
            ZStack {
                DSColors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: DSSpacing.medium) {
                        ProfileHeaderView()
                        LearningStatsView()
                        
                        VStack(spacing: DSSpacing.small) {
                            LearningSettingsSection()
                            NotificationSettingsSection()
                            AccountSettingsSection()
                        }
                    }
                    .padding(.horizontal, DSSpacing.Screen.horizontalPadding)
                    .padding(.vertical, DSSpacing.Screen.verticalPadding)
                }
            }
            .navigationTitle("프로필")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ProfileHeaderView: View {
    var body: some View {
        DSCard(style: .elevated) {
            VStack(spacing: DSSpacing.small) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(DSColors.accent)
                
                Text("사용자")
                    .font(DSTypography.heading3)
                    .foregroundColor(DSColors.Text.primary)
                
                Text("user@example.com")
                    .font(DSTypography.body2)
                    .foregroundColor(DSColors.Text.secondary)
            }
            .padding(DSSpacing.Component.cardPadding)
        }
    }
}

// 학습 통계
struct LearningStatsView: View {
    var body: some View {
        DSCard(style: .elevated) {
            VStack(alignment: .leading, spacing: DSSpacing.small) {
                Text("학습 통계")
                    .font(DSTypography.heading3)
                    .foregroundColor(DSColors.Text.primary)
                
                HStack(spacing: DSSpacing.medium) {
                    StatItemView(title: "학습 단어", value: "326개")
                    StatItemView(title: "정답률", value: "85%")
                    StatItemView(title: "연속 학습", value: "7일")
                }
            }
            .padding(DSSpacing.Component.cardPadding)
        }
    }
}

// 통계 아이템
struct StatItemView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: DSSpacing.xxSmall) {
            Text(title)
                .font(DSTypography.caption1)
                .foregroundColor(DSColors.Text.secondary)
            
            Text(value)
                .font(DSTypography.heading3)
                .foregroundColor(DSColors.accent)
        }
        .frame(maxWidth: .infinity)
    }
}

// 학습 설정 섹션
struct LearningSettingsSection: View {
    var body: some View {
        DSCard(style: .elevated) {
            VStack(alignment: .leading, spacing: DSSpacing.small) {
                Text("학습 설정")
                    .font(DSTypography.heading3)
                    .foregroundColor(DSColors.Text.primary)
                
                SettingsRow(icon: "speedometer", title: "난이도 설정", value: "중급")
                SettingsRow(icon: "folder", title: "카테고리 설정", value: "전체")
                SettingsRow(icon: "number", title: "일일 학습량", value: "10개")
            }
            .padding(DSSpacing.Component.cardPadding)
        }
    }
}

// 알림 설정 섹션
struct NotificationSettingsSection: View {
    var body: some View {
        DSCard(style: .elevated) {
            VStack(alignment: .leading, spacing: DSSpacing.small) {
                Text("알림 설정")
                    .font(DSTypography.heading3)
                    .foregroundColor(DSColors.Text.primary)
                
                SettingsRow(icon: "bell", title: "학습 알림", value: "ON")
                SettingsRow(icon: "clock", title: "알림 시간", value: "오전 9:00")
            }
            .padding(DSSpacing.Component.cardPadding)
        }
    }
}

// 계정 설정 섹션
struct AccountSettingsSection: View {
    var body: some View {
        DSCard(style: .elevated) {
            VStack(alignment: .leading, spacing: DSSpacing.small) {
                Text("계정 관리")
                    .font(DSTypography.heading3)
                    .foregroundColor(DSColors.Text.primary)
                
                Button(action: {}) {
                    SettingsRow(icon: "person", title: "프로필 수정", value: "")
                }
                
                Button(action: {}) {
                    SettingsRow(icon: "arrow.right.square", title: "로그아웃", value: "")
                        .foregroundColor(.red)
                }
            }
            .padding(DSSpacing.Component.cardPadding)
        }
    }
}

// 설정 행 컴포넌트
struct SettingsRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 24)
                .foregroundColor(DSColors.Text.secondary)
            
            Text(title)
                .font(DSTypography.body1)
                .foregroundColor(DSColors.Text.primary)
            
            Spacer()
            
            if !value.isEmpty {
                Text(value)
                    .font(DSTypography.body2)
                    .foregroundColor(DSColors.Text.secondary)
            }
            
            Image(systemName: "chevron.right")
                .font(DSTypography.caption1)
                .foregroundColor(DSColors.Text.secondary)
        }
    }
} 
