import SwiftUI

struct OnboardingView: View {
    typealias Step = OnboardingViewModel.Step
    @Environment(AuthenticationService.self) private var authService
    @Environment(LearningSettingService.self) private var learningSettingService
    
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        @Bindable var bLearningSettingService = learningSettingService
        
        VStack(spacing: DSSpacing.large) {
            StepIndicatorView(currentStep: viewModel.currentStep)
                .padding(.top, DSSpacing.medium)
            
            // TabView를 사용한 스텝 구현
            TabView(selection: $viewModel.currentStep) {
                GuideStepView(
                    imageName: "onboarding_guide_1",
                    title: "매일매일 영어 학습",
                    description: "하루 5분으로 시작하는\n영어 단어 학습"
                )
                .padding(.horizontal, DSSpacing.medium)
                .tag(Step.guide1)
                
                GuideStepView(
                    imageName: "onboarding_guide_2",
                    title: "나만의 단어장",
                    description: "학습한 단어를 복습하고\n단어장에서 관리해보세요"
                )
                .padding(.horizontal, DSSpacing.medium)
                .tag(Step.guide2)
                
                CategoryStepView(selectedCategory: $viewModel.category)
                    .padding(.horizontal, DSSpacing.medium)
                    .tag(Step.category)
                
                DailyGoalStepView(selectedGoal: $viewModel.count)
                    .padding(.horizontal, DSSpacing.medium)
                    .tag(Step.count)
                
                LevelStepView(selectedLevel: $viewModel.level)
                    .padding(.horizontal, DSSpacing.medium)
                    .tag(Step.level)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .scrollDisabled(true)
            .animation(.smooth, value: viewModel.currentStep)
            
            Spacer()
            
            // 이전/다음 버튼
            NavigationButtonsView(
                currentStep: viewModel.currentStep,
                onPrevious: viewModel.moveToPreviousStep,
                onNext: {
                    if viewModel.currentStep == .level {
                        let userId = authService.currentUser?.id
                        let setting = viewModel.returnLearningSetting(userId: userId)
                        
                        Task {
                            await learningSettingService.update(setting)
                            authService.completeOnboarding()
                        }
                        
                    } else {
                        viewModel.moveToNextStep()
                    }
                }
            )
        }
        .padding()
    }
}
