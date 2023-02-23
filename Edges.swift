//
//  Edges.swift
//  BigBrainStorm
//
//  Created by Mateusz Zwierzchowski on 19/12/2021.
//

import Foundation
import SwiftUI

class Edges {
    public let e_array: [Edge]

    init() {
        do {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let dataPathP = documentsDirectory.appendingPathComponent("BrainStormSaves")
            let dataPath = dataPathP.appendingPathComponent("asdfY.json")
            
            let data = try Data(contentsOf: dataPath)
            e_array = try JSONDecoder().decode([Edge].self, from: data)
            
        } catch {
            let url = Bundle.main.url(forResource: "edges", withExtension: "json")!
            let data = try! Data(contentsOf: url)
            e_array = try! JSONDecoder().decode([Edge].self, from: data)
        }
    }
}
