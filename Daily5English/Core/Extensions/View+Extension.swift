import SwiftUI

extension View {
    func errorAlert(error: Binding<Error?>, buttonTitle: String = "확인") -> some View {
        let localizedError = error.wrappedValue?.localizedDescription ?? ""
        return alert("오류", isPresented: .constant(error.wrappedValue != nil)) {
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: {
            Text(localizedError)
        }
    }
} 