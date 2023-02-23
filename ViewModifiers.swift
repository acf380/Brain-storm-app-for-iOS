//
//  ViewModifiers.swift
//  BigBrainStorm
//
//  Created by Mateusz Zwierzchowski on 14/02/2022.
//

import Foundation
import SwiftUI


struct DeleteButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .frame(width: 120, height: 50)
            .foregroundColor(.white)
            .background(
                ZStack {
                    Color(#colorLiteral(red: 0.7608050108, green: 0.1, blue: 0.1, alpha: 1))
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(.white)
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)), Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .padding(2)
                        .blur(radius: 2)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 10, x: 15, y: 15)
            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 10, x: -15, y: -15)
    }
}


struct AddButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .frame(width: 65, height: 40)
            .foregroundColor(.white)
            .background(
                ZStack {
                    Color(#colorLiteral(red: 0.0, green: 0.0, blue: 0.7, alpha: 1))
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(.white)
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.3139835298, blue: 1, alpha: 1)), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .padding(2)
                        .blur(radius: 2)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 10, x: 15, y: 15)
            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 10, x: -15, y: -15)
    }
}


struct SaveButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .frame(width: 65, height: 40)
            .foregroundColor(.white)
            .background(
                ZStack {
                    Color(#colorLiteral(red: 0.5, green: 0.9, blue: 0.5, alpha: 1))
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(.white)
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.9797762036, blue: 0, alpha: 1)), Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .padding(2)
                        .blur(radius: 2)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 10, x: 15, y: 15)
            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 10, x: -15, y: -15)
        
    }
}


struct ONButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.body)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            .background(Color.green)
            .foregroundColor(Color.white)
            .cornerRadius(20)
    }
}


struct OFFButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.body)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            .background(Color.red)
            .foregroundColor(Color.white)
            .cornerRadius(20)
    }
}


extension View {
    func deleteStyle() -> some View {
        modifier(DeleteButtonModifier())
    }
    
    func addStyle() -> some View {
        modifier(AddButtonModifier())
    }
    
    func saveStyle() -> some View {
        modifier(SaveButtonModifier())
    }
    
    func ONStyle() -> some View {
        modifier(ONButtonModifier())
    }
    
    func OFFStyle() -> some View {
        modifier(OFFButtonModifier())
    }
}
