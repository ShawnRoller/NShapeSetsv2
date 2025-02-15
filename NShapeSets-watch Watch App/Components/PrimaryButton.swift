import SwiftUI
import WatchKit

struct PrimaryButton: View {
    var title: String
    var buttonColor: Color = Palette.secondaryButtonFill
    var titleColor: Color = .white
    var onButtonTap: () -> Void
    var requireHold: Bool = false
    
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGFloat = 0
    @State private var isHolding = false
    
    let holdDuration: TimeInterval = 0.5
    
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
        .background(buttonColor)
        .cornerRadius(100)
        .padding([.horizontal, .bottom])
        .scaleEffect(scale)
        .offset(x: offset)
        .simultaneousGesture(
            requireHold ? LongPressGesture(minimumDuration: holdDuration)
                .onChanged { _ in
                    startHoldAnimation()
                }
                .onEnded { success in
                    if success {
                        triggerSuccess()
                    }
                } : nil
        )
        .simultaneousGesture(
            requireHold ? DragGesture(minimumDistance: 0)
                .onEnded { _ in
                    if isHolding {
                        cancelHoldAnimation()
                    }
                } : nil
        )
    }
    
    private func startHoldAnimation() {
        isHolding = true
        
        // Start shrinking animation
        withAnimation(.easeInOut(duration: holdDuration)) {
            scale = 0.8
        }
        
        // Initial haptic feedback
        WKInterfaceDevice.current().play(.start)
        
        // Schedule periodic haptic feedback
        Timer.scheduledTimer(withTimeInterval: holdDuration/3, repeats: false) { _ in
            if isHolding {
                WKInterfaceDevice.current().play(.click)
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: holdDuration/1.5, repeats: false) { _ in
            if isHolding {
                WKInterfaceDevice.current().play(.click)
            }
        }
    }
    
    private func triggerSuccess() {
        isHolding = false
        
        // Pop animation
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
            scale = 1.15
        }
        
        // Return to normal size
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
                scale = 1.0
            }
        }
        
        // Success haptic
        WKInterfaceDevice.current().play(.success)
        
        onButtonTap()
    }
    
    private func cancelHoldAnimation() {
        isHolding = false
        
        // Reset scale with spring animation
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
            scale = 1.0
        }
        
        // Shake animation
        withAnimation(.spring(response: 0.1, dampingFraction: 0.3, blendDuration: 0)) {
            offset = 8
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.spring(response: 0.1, dampingFraction: 0.3, blendDuration: 0)) {
                offset = -8
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.spring(response: 0.1, dampingFraction: 0.3, blendDuration: 0)) {
                offset = 0
            }
        }
        
        // Error haptic
        WKInterfaceDevice.current().play(.failure)
    }
}

#Preview {
    PrimaryButton(title: "REST", buttonColor: Palette.primary, onButtonTap: {}, requireHold: true)
}
