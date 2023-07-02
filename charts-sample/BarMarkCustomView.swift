//
//  BarMarkCustomView.swift
//  charts-sample
//
//  Created by 山田楓也 on 2023/06/21.
//

import SwiftUI
import Charts

struct BarMarkCustomView: View {
    var stackedBarData: [ToyShape] = [
        .init(color: "Green", type: "Cube", count: 2),
        .init(color: "Green", type: "Sphere", count: 0),
        .init(color: "Green", type: "Pyramid", count: 1),
        .init(color: "Purple", type: "Cube", count: 1),
        .init(color: "Purple", type: "Sphere", count: 1),
        .init(color: "Purple", type: "Pyramid", count: 1),
        .init(color: "Pink", type: "Cube", count: 1),
        .init(color: "Pink", type: "Sphere", count: 2),
        .init(color: "Pink", type: "Pyramid", count: 0),
        .init(color: "Yellow", type: "Cube", count: 1),
        .init(color: "Yellow", type: "Sphere", count: 1),
        .init(color: "Yellow", type: "Pyramid", count: 2)
    ]
    
    var body: some View {
        GroupBox("Bar Chart") {
            Chart {
                ForEach(stackedBarData) { shape in
                    BarMark(
                        x: .value("Shape Type", shape.type),
                        y: .value("Total Count", shape.count)
                    )
                    .foregroundStyle(by: .value("Shape Color", shape.color))
                }
            }
        }
        .chartForegroundStyleScale([
            "Green": .green, "Purple": .purple, "Pink": .pink, "Yellow": .yellow
        ])
        .frame(height: 500)
        .shadow(radius: 2)
        .padding(16)

    }
}

struct ToyShape: Identifiable {
    var color: String
    var type: String
    var count: Double
    var id = UUID()
}

struct BarMarkCustomView_Previews: PreviewProvider {
    static var previews: some View {
        BarMarkCustomView()
    }
}
