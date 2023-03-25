//
//  ActiveRing.swift
//  NShapeSets
//
//  Created by Shawn Roller on 3/25/23.
//

import SwiftUI

struct ActiveRing: View {
    var body: some View {
        Ring(color: Palette.activeRing, shadowColor: Palette.activeRing, width: 5)
    }
}

struct ActiveRing_Previews: PreviewProvider {
    static var previews: some View {
        ActiveRing()
    }
}
