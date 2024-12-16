import SwiftUI

struct AccountSettingsView: View {
    @State private var nickname = ""
    @State private var email = ""
    
    var body: some View {
        List {
            Section("프로필") {
                DSTextField(placeholder: "닉네임", text: $nickname)
                DSTextField(placeholder: "이메일", text: $email)
            }
            
            Section {
                Button("로그아웃") {
                    // 로그아웃 처리
                }
                .foregroundColor(.red)
                
                Button("회원탈퇴") {
                    // 회원탈퇴 처리
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle("계정 관리")
    }
} 