import SwiftUI

struct DSGauge: View {
    enum Style {
        case linear
        case circular
    }
    
    enum Size {
        case small
        case medium
        case large
        
        var height: CGFloat {
            switch self {
            case .small: return 4
            case .medium: return 8
            case .large: return 12
            }
        }
    }
    
    let value: Double // 0.0 ~ 1.0
    let style: Style
    let size: Size
    let showLabel: Bool
    let tint: Color?
    
    init(
        value: Double,
        style: Style = .linear,
        size: Size = .medium,
        showLabel: Bool = false,
        tint: Color? = nil
    ) {
        self.value = max(0, min(1, value))
        self.style = style
        self.size = size
        self.showLabel = showLabel
        self.tint = tint
    }
    
    var body: some View {
        Group {
            switch style {
            case .linear:
                linearGauge
            case .circular:
                circularGauge
            }
        }
    }
    
    private var linearGauge: some View {
        VStack(alignment: .leading, spacing: 8) {
            if showLabel {
                Text("\(Int(value * 100))%")
                    .font(DSTypography.caption1Bold)
                    .foregroundColor(DSColors.Text.primary)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background
                    RoundedRectangle(cornerRadius: size.height / 2)
                        .fill(DSColors.surface)
                    
                    // Progress
                    RoundedRectangle(cornerRadius: size.height / 2)
                        .fill(tint ?? DSColors.accent)
                        .frame(width: geometry.size.width * value)
                }
            }
            .frame(height: size.height)
        }
    }
    
    private var circularGauge: some View {
        ZStack {
            // Background Circle
            Circle()
                .stroke(
                    DSColors.surface,
                    lineWidth: size.height
                )
            
            // Progress Circle
            Circle()
                .trim(from: 0, to: value)
                .stroke(
                    tint ?? DSColors.accent,
                    style: StrokeStyle(
                        lineWidth: size.height,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
            
            if showLabel {
                Text("\(Int(value * 100))%")
                    .font(DSTypography.body2Bold)
                    .foregroundColor(DSColors.Text.primary)
            }
        }
    }
}

// MARK: - Preview
struct DSGauge_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 32) {
            // Linear gauges
            VStack(alignment: .leading, spacing: 16) {
                Text("Linear Gauges")
                    .font(DSTypography.heading3)
                
                DSGauge(value: 0.7, style: .linear, size: .large, showLabel: true)
                DSGauge(value: 0.5, style: .linear, size: .medium)
                DSGauge(value: 0.3, style: .linear, size: .small)
                DSGauge(value: 0.6, style: .linear, size: .medium, tint: DSColors.point)
            }
            
            // Circular gauges
            VStack(alignment: .leading, spacing: 16) {
                Text("Circular Gauges")
                    .font(DSTypography.heading3)
                
                HStack(spacing: 24) {
                    DSGauge(value: 0.7, style: .circular, showLabel: true)
                        .frame(width: 80, height: 80)
                    
                    DSGauge(value: 0.4, style: .circular, tint: DSColors.point)
                        .frame(width: 60, height: 60)
                    
                    DSGauge(value: 0.9, style: .circular, tint: DSColors.success)
                        .frame(width: 40, height: 40)
                }
            }
        }
        .padding()
    }
} 