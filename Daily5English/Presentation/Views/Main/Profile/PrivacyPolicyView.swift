//
//  PrivacyPolicyView.swift
//  Production
//
//  Created by 김민성 on 12/22/24.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            Text("개인정보처리방침 내용")
                .padding()
        }
        .navigationTitle("개인정보처리방침")
    }
}

#Preview {
    PrivacyPolicyView()
}
