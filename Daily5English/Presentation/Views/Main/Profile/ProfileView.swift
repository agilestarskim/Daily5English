//
//  ProfileView.swift
//  Production
//
//  Created by 김민성 on 12/22/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    @State private var showingLogoutAlert = false
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            List {
                // 1. 프로필 정보 섹션
                Section {
                    HStack(spacing: 16) {
                        // 프로필 이미지
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                        
                        // 사용자 정보
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.userName)
                                .font(.headline)
                            Text(authViewModel.currentUser?.email ?? "")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                // 2. 학습 통계 섹션
                Section {
                    HStack {
                        StatisticView(title: "학습 단어", value: "\(viewModel.learnedWords)개")
                        Divider()
                        StatisticView(title: "연속 학습", value: "\(viewModel.streakDays)일")
                        Divider()
                        StatisticView(title: "총 학습일", value: "\(viewModel.totalLearningDays)일")
                    }
                    .padding(.vertical, 8)
                } header: {
                    Text("학습 통계")
                }
                
                // 3. 학습 설정 섹션
                Section(header: Text("학습 설정")) {
                    NavigationLink {
                        LearningLevelSettingView(level: $viewModel.learningLevel)
                    } label: {
                        SettingRow(title: "학습 난이도", value: viewModel.learningLevel.toString())
                    }
                    
                    NavigationLink {
                        CategorySettingView(category: $viewModel.category)
                    } label: {
                        SettingRow(title: "학습 카테고리", value: viewModel.category.toString())
                    }
                    
                    NavigationLink {
                        DailyGoalSettingView(dailyGoal: $viewModel.dailyGoal)
                    } label: {
                        SettingRow(title: "일일 학습량", value: "\(viewModel.dailyGoal)개")
                    }
                }
                
                // 4. 알림 설정 섹션
                Section(header: Text("알림 설정")) {
                    Toggle("학습 알림", isOn: $viewModel.isNotificationEnabled)
                    
                    if viewModel.isNotificationEnabled {
                        DatePicker("학습 시작 시간",
                                 selection: $viewModel.learningStartTime,
                                 displayedComponents: .hourAndMinute)
                        
                        DatePicker("복습 시작 시간",
                                 selection: $viewModel.reviewStartTime,
                                 displayedComponents: .hourAndMinute)
                    }
                }
                
                // 5. 앱 정보 섹션
                Section {
                    Link(destination: URL(string: "https://example.com")!) {
                        Text("공식 홈페이지")
                    }
                    
                    NavigationLink("개인정보처리방침") {
                        PrivacyPolicyView()
                    }
                    
                    Button(role: .destructive) {
                        showingLogoutAlert = true
                    } label: {
                        Text("로그아웃")
                    }
                    .alert("로그아웃", isPresented: $showingLogoutAlert) {
                        Button("취소", role: .cancel) { }
                        Button("로그아웃", role: .destructive) {
                            Task {
                                await authViewModel.signOut()
                            }
                        }
                    } message: {
                        Text("정말 로그아웃 하시겠습니까?")
                    }
                }
            }
            .navigationTitle("프로필")
            .alert("로그아웃", isPresented: $viewModel.showError) {
                Button("확인", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage)
            }
        }
        
    }
}
