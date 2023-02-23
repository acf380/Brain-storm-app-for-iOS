//
//  Matrix.swift
//  BigBrainStorm
//
//  Created by Mateusz Zwierzchowski on 19/12/2021.
//

import Foundation
import SwiftUI

class Matrix: ObservableObject, Identifiable {
    private let nodes = Nodes()
    private let edges = Edges()
    @Published var arr: [[Bool]]

    init() {
        arr = Array(repeating: Array(repeating: false, count: nodes.n_array.count), count: nodes.n_array.count)
        var x:Int, y: Int
        for i in 0..<edges.e_array.count {
            x = edges.e_array[i].n1
            y = edges.e_array[i].n2
            arr[x][y] = true
            arr[y][x] = true
        }
    }
    
    func deleteNode(id: Int) {
        self.arr.remove(at: id)
        for i in 0..<self.arr.count {
            self.arr[i].remove(at: id)
        }
        
    }
}
