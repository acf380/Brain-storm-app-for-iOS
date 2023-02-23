//
//  Line.swift
//  BigBrainStorm
//
//  Created by Mateusz Zwierzchowski on 18/12/2021.
//

import Foundation
import SwiftUI

func makeLine(from: Node, to: Node) -> some View {
   return Path() { path in
       path.move(to: CGPoint(x: from.x + from.offsetX, y: from.y + from.offsetY))
       path.addLine(to: CGPoint(x: to.x + to.offsetX, y: to.y + to.offsetY))
    }
   .stroke(Color(red: 0.25, green: 0.25, blue: 0.25), lineWidth: 4)
}
