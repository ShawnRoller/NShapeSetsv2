//
//  RestSelector.swift
//  NShapeSets
//
//  Created by Shawn Roller on 3/25/23.
//

import SwiftUI

struct RestSelector: View {
    @Binding var restValue: Int
    
    var body: some View {
        ValueSelector(value: $restValue, title: "rest", step: 5.0, range: 5...180, isTime: true)
    }
}

struct RestSelector_Previews: PreviewProvider {
    static var previews: some View {
        RestSelector(restValue: .constant(50))
    }
}
