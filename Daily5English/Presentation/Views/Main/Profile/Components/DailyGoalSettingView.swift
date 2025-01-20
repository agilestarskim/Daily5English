//
//  DailyGoalSettingView.swift
//  Production
//
//  Created by 김민성 on 12/22/24.
//

import SwiftUI

struct DailyGoalSettingView: View {
    @Binding var dailyGoal: Int
    
    var body: some View {
        List {
            ForEach(3...7, id: \.self) { number in
                Button {
                    dailyGoal = number
                } label: {
                    HStack {
                        Text("\(number)개")
                        Spacer()
                        if dailyGoal == number {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .navigationTitle("일일 학습량")
    }
}
