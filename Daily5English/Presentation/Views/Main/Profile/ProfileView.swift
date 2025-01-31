//
//  ProfileView.swift
//  Production
//
//  Created by 김민성 on 12/22/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(AuthenticationService.self) private var authService
    @Environment(LearningSettingService.self) private var learningSettingService
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var showingLogoutAlert = false
    @State private var showSettingsAlert = false
    @StateObject private var viewModel = ProfileViewModel()
    
    @State private var notificationSettings = NotificationSettings.defaultSettings
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // 프로필 섹션
                    HStack {
                        Text(authService.currentUser?.email ?? "")
                            .font(DSTypography.body1Bold)
                            .foregroundColor(DSColors.Text.primary)
                        
                        Spacer()
                        
                        if authService.currentUser?.isPremium == false {
                            BadgeView(text: "PRO", color: .yellow, icon: "trophy.fill")
                        } else {
                            BadgeView(text: "PRO", color: .gray, icon: "trophy.fill", isDisabled: true)
                        }
                    }
                    .padding()
                    .background(DSColors.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    // 학습 설정 섹션
                    VStack(spacing: 12) {
                        NavigationLink {
                            LearningSettingsView()
                        } label: {
                            VStack(spacing: 12) {
                                SettingInfoRow(
                                    icon: "graduationcap.fill",
                                    title: "학습 난이도",
                                    value: learningSettingService.level.text
                                )
                                SettingInfoRow(
                                    icon: "folder.fill",
                                    title: "학습 카테고리",
                                    value: learningSettingService.category.text
                                )
                                SettingInfoRow(
                                    icon: "target",
                                    title: "일일 학습량",
                                    value: "\(learningSettingService.count)개"
                                )
                            }
                        }
                    }
                    .background(DSColors.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    // 알림 설정 섹션
                    VStack(spacing: 12) {
                        SettingToggleRow(
                            icon: "bell.fill",
                            title: "알림",
                            isOn: $viewModel.isNotificationEnabled
                        )
                        .onChange(of: viewModel.isNotificationEnabled, { oldValue, newValue in
                            if newValue {
                                Task {
                                    let isAuthorized = await NotificationManager.shared.requestAuthorization()
                                    if isAuthorized {
                                        // 알림을 켜면 디폴트 시간으로 설정
                                        let defaultLearningTime = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
                                        let defaultReviewTime = Calendar.current.date(bySettingHour: 19, minute: 0, second: 0, of: Date())!
                                        NotificationManager.shared.updateLearningNotification(at: defaultLearningTime)
                                        NotificationManager.shared.updateReviewNotification(at: defaultReviewTime)
                                        viewModel.learningStartTime = defaultLearningTime
                                        viewModel.reviewStartTime = defaultReviewTime
                                    } else {
                                        // 권한이 없으면 설정으로 이동 알림 표시
                                        viewModel.isNotificationEnabled = false
                                        showSettingsAlert = true
                                    }
                                }
                            } else {
                                // 알림을 끄면 모든 알림 삭제
                                NotificationManager.shared.removeAllNotifications()
                            }
                        })
                        
                        if viewModel.isNotificationEnabled {
                            NavigationLink {
                                NotificationSettingsView(viewModel: viewModel)
                            } label: {
                                VStack(spacing: 12) {
                                    SettingInfoRow(
                                        icon: "bell.fill",
                                        title: "학습 알림",
                                        value: viewModel.learningStartTime.formatted(date: .omitted, time: .shortened)
                                    )
                                    SettingInfoRow(
                                        icon: "bell.fill",
                                        title: "복습 알림",
                                        value: viewModel.reviewStartTime.formatted(date: .omitted, time: .shortened)
                                    )
                                }
                            }
                        }
                    }
                    .background(DSColors.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    // 일반 설정 섹션
                    VStack(spacing: 2) {
                        SettingToggleRow(
                            icon: "moon.fill",
                            title: "다크 모드",
                            isOn: .constant(colorScheme == .dark)
                        )
                    }
                    .background(DSColors.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    // 지원 섹션
                    VStack(spacing: 2) {
                        NavigationLink {
                            Text("도움말")
                        } label: {
                            SettingRow(
                                icon: "questionmark.circle",
                                title: "도움말"
                            )
                        }
                        
                        NavigationLink {
                            Text("앱 정보")
                        } label: {
                            SettingRow(
                                icon: "info.circle",
                                title: "앱 정보"
                            )
                        }
                        
                        Link(destination: URL(string: "https://apps.apple.com/app/id123456789")!) {
                            SettingRow(
                                icon: "star.fill",
                                title: "앱 평가하기"
                            )
                        }
                    }
                    .background(DSColors.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    // 로그아웃 버튼
                    Button {
                        showingLogoutAlert = true
                    } label: {
                        SettingRow(
                            icon: "rectangle.portrait.and.arrow.right.fill",
                            title: "로그아웃"
                        )
                    }
                    .background(DSColors.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding()
            }
            .background(DSColors.background.ignoresSafeArea())
            .alert("로그아웃", isPresented: $showingLogoutAlert) {
                Button("취소", role: .cancel) { }
                Button("로그아웃", role: .destructive) {
                    Task {
                        await authService.signOut()
                    }
                }
            } message: {
                Text("정말 로그아웃 하시겠습니까?")
            }
            .alert(isPresented: $showSettingsAlert) {
                Alert(
                    title: Text("알림 권한 필요"),
                    message: Text("알림을 받으려면 설정에서 권한을 허용해주세요."),
                    primaryButton: .default(Text("설정으로 이동"), action: {
                        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(appSettings)
                        }
                    }),
                    secondaryButton: .cancel(Text("취소"))
                )
            }
            .onAppear {
                Task {
                    let times = await NotificationManager.shared.getNotificationTimes()
                    if let learningTime = times.learningTime {
                        viewModel.learningStartTime = learningTime
                    }
                    if let reviewTime = times.reviewTime {
                        viewModel.reviewStartTime = reviewTime
                    }
                    
                    // 알림 권한 확인
                    let isAuthorized = await NotificationManager.shared.checkAuthorizationStatus()
                    viewModel.isNotificationEnabled = isAuthorized
                }
            }
        }
    }
}

// 설정 행 컴포넌트
struct SettingRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(DSColors.Text.secondary)
                .frame(width: 34, height: 34)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(title)
                .font(DSTypography.body1)
                .foregroundColor(DSColors.Text.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 12))
                .foregroundColor(DSColors.Text.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}

// 토글이 있는 설정 행
struct SettingToggleRow: View {
    let icon: String
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(DSColors.Text.secondary)
                .frame(width: 34, height: 34)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(title)
                .font(DSTypography.body1)
                .foregroundColor(DSColors.Text.primary)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}

// 설정 정보 행 컴포넌트
struct SettingInfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(DSColors.Text.secondary)
                .frame(width: 34, height: 34)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(title)
                .font(DSTypography.body1)
                .foregroundColor(DSColors.Text.primary)
            
            Spacer()
            
            Text(value)
                .font(DSTypography.body2)
                .foregroundColor(DSColors.Text.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}

// 배지 컴포넌트
struct BadgeView: View {
    let text: String
    let color: Color
    let icon: String
    var isDisabled: Bool = false
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(color)
            Text(text)
                .font(DSTypography.caption1)
                .foregroundColor(color)
        }
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 12).fill(color.opacity(0.1)))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(color, lineWidth: 1)
        )
        .opacity(isDisabled ? 0.5 : 1.0)
    }
}
