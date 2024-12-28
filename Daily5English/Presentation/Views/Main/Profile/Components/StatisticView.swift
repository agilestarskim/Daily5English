//
//  StatisticView.swift
//  Production
//
//  Created by 김민성 on 12/22/24.
//

import SwiftUI

struct StatisticView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
    }
}
#Preview {
    StatisticView(title: "학습 단어", value: "125개")
}
