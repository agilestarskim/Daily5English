import SwiftUI

struct LearningSettingsView: View {
    @Environment(LearningSettingService.self) private var learningSettingService
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading = false
    @State private var localSetting: LearningSetting = .defalt
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(spacing: 24) {
                        // 학습 난이도 섹션
                        VStack(alignment: .leading, spacing: 12) {
                            Text("학습 난이도")
                                .font(.headline)
                            
                            Picker("", selection: $localSetting.level) {
                                ForEach(Level.allCases, id: \.self) { level in
                                    Text(level.text)
                                        .tag(level)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        // 학습 카테고리 섹션
                        VStack(alignment: .leading, spacing: 12) {
                            Text("학습 카테고리")
                                .font(.headline)
                            
                            Picker("", selection: $localSetting.category) {
                                ForEach(Category.allCases, id: \.self) { category in
                                    Text(category.text)
                                        .tag(category)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        // 일일 학습량 섹션
                        VStack(alignment: .leading, spacing: 12) {
                            Text("일일 학습량")
                                .font(.headline)
                            
                            VStack {
                                Picker("", selection: $localSetting.count) {
                                    ForEach(3...10, id: \.self) { number in
                                        Text("\(number)단어")
                                            .tag(number)
                                    }
                                }
                                .pickerStyle(.wheel)
                                
                                Text("하루 3~10단어를 학습할 수 있어요")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(DSColors.surface)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    .padding()
                }
                
                // 저장 버튼
                Button(action: saveSettings) {
                    if isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("저장하기")
                            .font(.headline)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(DSColors.accent)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                .disabled(isLoading)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .onAppear {
            self.localSetting = learningSettingService.setting
        }
    }
    
    private func saveSettings() {
        isLoading = true
        
        Task {
            await learningSettingService.update(localSetting)
            await learningSettingService.fetchLearningSetting()
            isLoading = false
            dismiss()
        }
    }
} 
