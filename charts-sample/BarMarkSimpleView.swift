//
//  BarMarkSimpleView.swift
//  charts-sample
//
//  Created by 山田楓也 on 2023/06/21.
//

import SwiftUI
import Charts

struct BarMarkSimpleView: View {
    var data: [ToyShapeSimple] = [
        .init(type: "Cube", count: 5),
        .init(type: "Sphere", count: 4),
        .init(type: "Pyramid", count: 4)
    ]
    
    struct Profit: Identifiable {
        let department: String
        let profit: Double
        var id = UUID()
    }


    let data1: [Profit] = [
        Profit(department: "Production", profit: 15000),
        Profit(department: "Marketing", profit: 8000),
        Profit(department: "Finance", profit: 10000)
    ]


    var body: some View {
        Chart(data1) {
            BarMark(
                x: .value("Department", $0.department),
                y: .value("Profit", $0.profit)
            )
        }
        .frame(height: 400)
        
//        VStack(spacing: 30) {
//            GroupBox("Bar Chart") {
//                Chart {
//                    ForEach(data) { shape in
//                        BarMark(
//                            x: .value("Total Count", shape.count),
//                            y: .value("Shape Type", shape.type)
//                        )
//                        .foregroundStyle(by: .value("sss", shape.type))
//                    }
//                }
//            }
//            .shadow(radius: 2)
//            .frame(height: 200)
//            .padding(16)
//        }
    }
}

struct YellowGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .padding(.top, 30)
            .padding(20)
            .background(Color(hue: 0.10, saturation: 0.10, brightness: 0.98))
            .cornerRadius(20)
            .overlay(
                configuration.label.padding(10),
                alignment: .topLeading
            )
    }
}

struct ToyShapeSimple: Identifiable {
    var type: String
    var count: Double
    var id = UUID()
}

struct BarMarkView_Previews: PreviewProvider {
    static var previews: some View {
        BarMarkSimpleView()
    }
}
