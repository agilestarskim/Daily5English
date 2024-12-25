import SwiftUI

struct GuideStepView: View {
    let imageName: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: DSSpacing.medium) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.1))
                .frame(height: 240)
                .overlay(
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                )
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(DSColors.Text.secondary)
        }
    }
}
