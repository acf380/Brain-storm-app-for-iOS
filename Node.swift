//
//  Node.swift
//  BigBrainStorm
//
//  Created by Mateusz Zwierzchowski on 18/12/2021.
//

import Foundation
import SwiftUI


public enum ChooseSchape: String, CaseIterable, Identifiable, Decodable {
    case circle, rectangle
    public var id: Self { self }
}

struct Node: Decodable, Identifiable {
    enum CodingKeys: CodingKey {
        case id, x, y, text, red, green, blue, shape, width, height
    }
    
    public var id: Int
    public var x: Double
    public var y: Double
    public var text: String
    public var red: Double
    public var green: Double
    public var blue: Double
    public var offsetX: Double = 0
    public var offsetY: Double = 0
    public var width: Double = 64
    public var height: Double = 64
    public var shape: ChooseSchape = .circle
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        x = try container.decode(Double.self, forKey: .x)
        y = try container.decode(Double.self, forKey: .y)
        text = try container.decode(String.self, forKey: .text)
        red = try container.decode(Double.self, forKey: .red)
        green = try container.decode(Double.self, forKey: .green)
        blue = try container.decode(Double.self, forKey: .blue)
        shape = try container.decode(ChooseSchape.self, forKey: .shape)
        width = try container.decode(Double.self, forKey: .width)
        height = try container.decode(Double.self, forKey: .height)
    }
    
    init(id: Int, x: Double, y: Double, text: String, red: Double, green: Double, blue: Double, shape: ChooseSchape)
    {
        
        self.id = id
        self.x = x
        self.y = y
        self.text = text
        self.red = red
        self.green = green
        self.blue = blue
        self.shape = shape
    }
}
    
extension Node {
    func circle() -> some View {
        Circle()
            .fill(Color(red: Double(red)/255.0, green: Double(green)/255.0, blue: Double(blue)/255.0))
            .frame(width: self.height, height: self.height, alignment: .center)
            .position(x: x + offsetX, y: y + offsetY)
    }
    
    func square() -> some View {
        Rectangle()
            .fill(Color(red: Double(red)/255.0, green: Double(green)/255.0, blue: Double(blue)/255.0))
            .frame(width: self.width, height: self.height, alignment: .center)
            .position(x: x + offsetX, y: y + offsetY)
    }
    
    @ViewBuilder func drawShape() -> some View {
        switch shape{
        case ChooseSchape.circle: circle(); label()
        case ChooseSchape.rectangle: square(); label()
        default: Text("Failed")
        }
        
    }
    
    func label() -> some View {
        return Text(text)
            .font(.system(size: 30))
            .bold()
            .position(x: x + offsetX, y: y + offsetY)
            .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))
    }
}
