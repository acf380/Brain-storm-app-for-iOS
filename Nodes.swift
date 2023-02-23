//
//  Nodes.swift
//  BigBrainStorm
//
//  Created by Mateusz Zwierzchowski on 19/12/2021.
//

import Foundation

class Nodes: ObservableObject {
   @Published var n_array = [Node]()

    init() {
        do {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let dataPathP = documentsDirectory.appendingPathComponent("BrainStormSaves")
            let dataPath = dataPathP.appendingPathComponent("asdfX.json")

            let data = try Data(contentsOf: dataPath)
            n_array = try JSONDecoder().decode([Node].self, from: data)

        } catch {
            let url = Bundle.main.url(forResource: "nodes", withExtension: "json")!
            let data = try! Data(contentsOf: url)
            n_array = try! JSONDecoder().decode([Node].self, from: data)
        }
    }

    func deleteNode(id: Int) -> Int{
        self.n_array.remove(at: id)

        var idc = id
        if idc == self.n_array.count
        {
            idc = idc - 1

            for x in (idc+1)..<self.n_array.count
            {
                self.n_array[x].id -= 1
            }
        }
        else
        {
            for x in idc..<self.n_array.count
            {
                self.n_array[x].id -= 1
            }
        }
        return idc
    }
}
