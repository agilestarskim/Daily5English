import SwiftUI

enum DSTypography {
    // Display (특별히 큰 텍스트, 예: 랜딩 페이지, 환영 화면)
    static let display1 = Font.custom("Pretendard-ExtraBold", size: 36)
    static let display2 = Font.custom("Pretendard-ExtraBold", size: 32)
    
    // Headings
    static let heading1 = Font.custom("Pretendard-Bold", size: 28)
    static let heading2 = Font.custom("Pretendard-Bold", size: 24)
    static let heading3 = Font.custom("Pretendard-SemiBold", size: 20)
    
    // Body
    static let body1 = Font.custom("Pretendard-Regular", size: 16)
    static let body1Bold = Font.custom("Pretendard-Bold", size: 16)
    static let body1Light = Font.custom("Pretendard-Light", size: 16)
    
    static let body2 = Font.custom("Pretendard-Regular", size: 14)
    static let body2Bold = Font.custom("Pretendard-Bold", size: 14)
    static let body2Light = Font.custom("Pretendard-Light", size: 14)
    
    // Others
    static let caption1 = Font.custom("Pretendard-Regular", size: 12)
    static let caption1Bold = Font.custom("Pretendard-Bold", size: 12)
    static let caption2 = Font.custom("Pretendard-Regular", size: 11)
    
    static let button = Font.custom("Pretendard-SemiBold", size: 14)
    static let label = Font.custom("Pretendard-Medium", size: 13)
    
    // Numbers & Special Text
    static let number = Font.custom("Pretendard-Light", size: 14)
    static let numberLarge = Font.custom("Pretendard-Light", size: 24)
    static let quote = Font.custom("Pretendard-Light", size: 16)
}

extension DSTypography {
    static func printLoadedFonts() {
        for family in UIFont.familyNames.sorted() {
            print("Family: \(family)")
            for font in UIFont.fontNames(forFamilyName: family).sorted() {
                print("- \(font)")
            }
        }
    }
} 