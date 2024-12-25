import SwiftUI

struct OnboardingView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(UserSettingsManager.self) private var userSettingsManager
    
    @StateObject private var viewModel =  OnboardingViewModel()
    
    var body: some View {
        @Bindable var bUserSettingsManager = userSettingsManager
        VStack(spacing: DSSpacing.large) {
            // 진행 상태 표시
            StepIndicatorView(currentStep: viewModel.currentStep)
            
            // 현재 단계에 따른 컨텐츠
            ScrollView {
                VStack(spacing: DSSpacing.large) {
                    switch viewModel.currentStep {
                    case .guide1:
                        GuideStepView(
                            imageName: "onboarding_guide_1",
                            title: "매일매일 영어 학습",
                            description: "하루 5분으로 시작하는\n영어 단어 학습"
                        )
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                    case .guide2:
                        GuideStepView(
                            imageName: "onboarding_guide_2",
                            title: "나만의 단어장",
                            description: "학습한 단어를 복습하고\n단어장에서 관리해보세요"
                        )
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                    case .category:
                        CategoryStepView(selectedCategory: $bUserSettingsManager.category)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                    case .dailyGoal:
                        DailyGoalStepView(selectedGoal: $bUserSettingsManager.dailyGoal)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                    case .level:
                        LevelStepView(selectedLevel: $bUserSettingsManager.learningLevel)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                    }
                }
                .padding(.horizontal, DSSpacing.medium)
                .animation(.smooth, value: viewModel.currentStep)
            }
            
            Spacer()
            
            // 이전/다음 버튼
            NavigationButtonsView(
                currentStep: viewModel.currentStep,
                onPrevious: viewModel.moveToPreviousStep,
                onNext: {
                    if viewModel.currentStep == .level {
                        Task {
                            await userSettingsManager.saveUserSettings(userId: authManager.currentUser?.id)
                        }
                        
                        authManager.completeOnboarding()
                    } else {
                        viewModel.moveToNextStep()
                    }
                }
            )
        }
        .padding()
    }
}
