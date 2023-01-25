//
//  CustomSlider.swift
//  NShapeSets
//
//  Created by Shawn Roller on 1/24/23.
//

import SwiftUI

struct CustomSlider: UIViewRepresentable {
    
    final class Coordinator: NSObject {
        // The class property value is a binding: It’s a reference to the SwiftUISlider
        // value, which receives a reference to a @State variable value in ContentView.
        var value: Binding<Double>
        
        // Create the binding when you initialize the Coordinator
        init(value: Binding<Double>) {
            self.value = value
        }
        
        // Create a valueChanged(_:) action
        @objc func valueChanged(_ sender: UISlider) {
            self.value.wrappedValue = Double(sender.value)
        }
    }
    
    // TODO: convert to use Palette.accentColor1 once UIColor supports Color conversion
    var thumbColor: UIColor? = UIColor(Palette.setsSliderKnob)
    var minTrackColor: UIColor? = UIColor(Palette.setsSliderFill)
    var maxTrackColor: UIColor? = UIColor(Palette.setsSliderBackground)
    var range: ClosedRange<Double>? = 1...100
    var step: Double? = 1
    
    @Binding var value: Double
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.thumbTintColor = thumbColor
        slider.minimumTrackTintColor = minTrackColor
        slider.maximumTrackTintColor = maxTrackColor
        slider.value = Float(value)
        slider.maximumValue = Float(range?.upperBound ?? 100)
        slider.minimumValue = Float(range?.lowerBound ?? 1)
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        // Coordinating data between UIView and SwiftUI view
        uiView.value = Float(self.value)
    }
    
    func makeCoordinator() -> CustomSlider.Coordinator {
        Coordinator(value: $value)
    }
}

struct CustomSlider_Previews: PreviewProvider {
    static var previews: some View {
        CustomSlider(value: .constant(50))
    }
}

