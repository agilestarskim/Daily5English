import SwiftUI

enum DSColors {
    // Brand Colors
    static let accent = Color("Accent") // 보라색 계열 (이전 Primary)
    static let point = Color("Point") // 민트색 계열 (이전 Secondary)
    
    // Background Colors
    static let background = Color("Background") // 메인 배경색 (흰색)
    static let surface = Color("Surface") // 카드 배경색 (살짝 회색빛)
    static let surfaceSelected = Color("SurfaceSelected") // 선택된 상태 배경 (연한 민트색)
    
    // Text Colors
    enum Text {
        static let primary = Color("TextPrimary") // 기본 텍스트 (진한 남색)
        static let secondary = Color("TextSecondary") // 부가 텍스트 (회색)
        static let disabled = Color("TextDisabled") // 비활성화 텍스트
        static let onColor = Color("TextOnColor") // 컬러 배경 위 텍스트
    }
    
    // Status Colors
    static let success = Color("Success") // 초록색
    static let warning = Color("Warning") // 노란색
    static let error = Color("Error") // 빨간색
    
    // Border & Divider
    static let border = Color("Border") // 엷은 회색
    static let divider = Color("Divider") // 구분선용 엷은 회색
} 