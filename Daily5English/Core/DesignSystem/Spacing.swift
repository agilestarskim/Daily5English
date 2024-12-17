import Foundation

enum DSSpacing {
    // Base spacing
    static let xxxSmall: CGFloat = 4
    static let xxSmall: CGFloat = 8
    static let xSmall: CGFloat = 12
    static let small: CGFloat = 16
    static let medium: CGFloat = 24
    static let large: CGFloat = 32
    static let xLarge: CGFloat = 40
    static let xxLarge: CGFloat = 48
    
    // Component specific
    enum Component {
        static let cardPadding: CGFloat = 16
        static let cardSpacing: CGFloat = 12
        static let buttonHeight: CGFloat = 48
        static let inputHeight: CGFloat = 44
        static let iconSize: CGFloat = 24
    }
    
    // Screen specific
    enum Screen {
        static let horizontalPadding: CGFloat = 20
        static let verticalPadding: CGFloat = 24
    }
} 