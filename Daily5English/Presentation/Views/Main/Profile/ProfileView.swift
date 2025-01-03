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
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // 프로필 섹션
                    NavigationLink {
                        Text("프로필 수정")
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 48, height: 48)
                                .foregroundColor(DSColors.Text.secondary)
                                .background(Circle().fill(.white))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(authService.currentUser?.nickname ?? "")
                                    .font(DSTypography.body1Bold)
                                    .foregroundColor(DSColors.Text.primary)
                                Text(authService.currentUser?.email ?? "")
                                    .font(DSTypography.caption1)
                                    .foregroundColor(DSColors.Text.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(DSColors.Text.secondary)
                        }
                        .padding()
                        .background(DSColors.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    
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
