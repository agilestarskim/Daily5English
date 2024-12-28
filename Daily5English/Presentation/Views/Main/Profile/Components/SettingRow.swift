//
//  SettingRow.swift
//  Production
//
//  Created by 김민성 on 12/22/24.
//

import SwiftUI

struct SettingRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    SettingRow(title: "Title", value: "Value")
}
