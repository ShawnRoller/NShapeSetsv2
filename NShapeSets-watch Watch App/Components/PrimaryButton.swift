import SwiftUI

struct PrimaryButton: View {
    var title: String
    var buttonColor: Color = Palette.secondaryButtonFill
    var titleColor: Color = .white
    var onButtonTap: () -> Void
    var requireHold: Bool = false
    var onHoldColor: Color = Palette.secondaryButtonFill

    @State private var progress: CGFloat = 0
    @State private var animation: Animation? = nil

    let holdDuration: TimeInterval = 1.0

    var body: some View {
        Button(action: {
            if !requireHold {
                onButtonTap()
            }
        }, label: {
            Text(title)
                .foregroundStyle(titleColor)
                .watchCtaFont()
        })
        .frame(height: 40)
        .background(buttonBackgroundColor)
        .cornerRadius(100)
        .padding([.horizontal, .bottom])
        .simultaneousGesture(
            requireHold ? LongPressGesture(minimumDuration: holdDuration)
                .onChanged { _ in
                    startHoldAnimation()
                }
                .onEnded { success in
                    if success {
                        onButtonTap()
                    }
                    stopHoldAnimation()
                } : nil
        )
        .simultaneousGesture(
            requireHold ? DragGesture(minimumDistance: 0)
                .onEnded { _ in
                    if progress > 0 {
                        stopHoldAnimation()
                    }
                } : nil
        )
    }
    
    private var buttonBackgroundColor: Color {
        buttonColor.interpolate(to: onHoldColor, progress: progress)
    }

    /// Starts the animation when the button is held
    private func startHoldAnimation() {
        animation = Animation.linear(duration: holdDuration)
        withAnimation(animation) {
            progress = 1.0
        }
    }

    /// Stops the animation and reverses progress if released early
    private func stopHoldAnimation() {
        // If released early, reverse the animation back to 0
        withAnimation(Animation.easeOut(duration: 0.3)) {
            progress = 0
        }
    }
}

extension Color {
    func interpolate(to color: Color, progress: CGFloat) -> Color {
        return Color(
            red: (1 - progress) * self.redComponent + progress * color.redComponent,
            green: (1 - progress) * self.greenComponent + progress * color.greenComponent,
            blue: (1 - progress) * self.blueComponent + progress * color.blueComponent,
            opacity: (1 - progress) * self.opacityComponent + progress * color.opacityComponent
        )
    }
    
    private var redComponent: CGFloat {
        UIColor(self).cgColor.components?[0] ?? 0
    }
    
    private var greenComponent: CGFloat {
        UIColor(self).cgColor.components?[1] ?? 0
    }
    
    private var blueComponent: CGFloat {
        UIColor(self).cgColor.components?[2] ?? 0
    }
    
    private var opacityComponent: CGFloat {
        UIColor(self).cgColor.alpha
    }
}

#Preview {
    PrimaryButton(title: "REST", buttonColor: Palette.primary, onButtonTap: {}, requireHold: true, onHoldColor: .red)
}
