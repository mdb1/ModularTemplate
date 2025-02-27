import SwiftUI

// More info in:
// https://manu.show/2023-01-04-new-app-components/
// https://manu.show/2023-03-08-new-app-toasts/
// https://manu.show/2022-12-24-new-app-constants/
// https://www.manu.show/2023-01-03-new-app-view-modifiers/
// https://www.manu.show/2023-01-20-new-app-fonts/

public struct PrimaryButtonStyle: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
    }
}

public enum Colors {
    public static let primary = Color.blue
    public static let secondary = Color.gray
    public static let accent = Color.orange
}

public enum Typography {
    public static let title = Font.title
    public static let body = Font.body
    public static let caption = Font.caption
}

#Preview {
    Button("Hey") {}
}
