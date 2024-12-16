import SwiftUI

struct LearningSettingsView: View {
    @State private var selectedLevel = 0
    @State private var selectedCategories = Set<String>()
    @State private var dailyWordCount = 5
    
    let levels = ["초급", "중급", "고급"]
    let categories = ["일상", "비즈니스", "여행", "문화", "IT"]
    
    var body: some View {
        List {
            Section("난이도") {
                Picker("학습 레벨", selection: $selectedLevel) {
                    ForEach(0..<levels.count, id: \.self) { index in
                        Text(levels[index])
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section("관심 카테고리") {
                ForEach(categories, id: \.self) { category in
                    Toggle(category, isOn: Binding(
                        get: { selectedCategories.contains(category) },
                        set: { isSelected in
                            if isSelected {
                                selectedCategories.insert(category)
                            } else {
                                selectedCategories.remove(category)
                            }
                        }
                    ))
                }
            }
            
            Section("학습 설정") {
                Stepper("일일 학습 단어: \(dailyWordCount)개", 
                       value: $dailyWordCount, 
                       in: 1...20)
            }
        }
        .navigationTitle("학습 설정")
    }
} 