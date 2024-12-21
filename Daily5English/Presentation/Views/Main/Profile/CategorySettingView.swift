//
//  CategorySettingView.swift
//  Production
//
//  Created by 김민성 on 12/22/24.
//

import SwiftUI

struct CategorySettingView: View {
    @Binding var category: LearningCategory
    
    var body: some View {
        List {
            ForEach([LearningCategory.daily, .business], id: \.self) { category in
                Button {
                    self.category = category
                } label: {
                    HStack {
                        Text(category.toString())
                        Spacer()
                        if self.category == category {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .navigationTitle("학습 카테고리")
    }
}
