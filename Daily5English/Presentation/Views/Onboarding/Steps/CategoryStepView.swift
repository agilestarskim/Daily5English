// 카테고리 설정 스텝 뷰

import SwiftUI

struct CategoryStepView: View {
    typealias Category = LearningSettings.LearningCategory
    @Binding var selectedCategory: Category
    
    var body: some View {
        VStack(spacing: DSSpacing.large) {
            VStack(spacing: DSSpacing.small) {
                Text("어떤 영어를 학습하고 싶으신가요?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("나에게 맞는 카테고리를 선택해주세요\n나중에 변경할 수 있어요")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(DSColors.Text.secondary)
            }
            
            VStack(spacing: DSSpacing.medium) {
                ForEach([Category.daily, .business], id: \.self) { category in
                    Button {
                        selectedCategory = category
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(category.rawValue)
                                    .font(.headline)
                                Text(category == .daily ? "일상 회화, 여행 영어" : "비즈니스 이메일, 회의")
                                    .font(.subheadline)
                                    .foregroundColor(DSColors.Text.secondary)
                            }
                            Spacer()
                            if selectedCategory == category {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(DSColors.accent)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedCategory == category ? DSColors.surfaceSelected : DSColors.surface)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}
