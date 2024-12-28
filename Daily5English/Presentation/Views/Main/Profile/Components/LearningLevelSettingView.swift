//
//  LearningLevelSettingView.swift
//  Production
//
//  Created by 김민성 on 12/22/24.
//

import SwiftUI

struct LearningLevelSettingView: View {
    @Binding var level: LearningSettings.Difficulty
        
    var body: some View {
        List {
            ForEach([LearningSettings.Difficulty.beginner, .intermediate, .advanced], id: \.self) { level in
                Button {
                    self.level = level
                } label: {
                    HStack {
                        Text(level.rawValue)
                        Spacer()
                        if self.level == level {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .navigationTitle("학습 난이도")
    }
}