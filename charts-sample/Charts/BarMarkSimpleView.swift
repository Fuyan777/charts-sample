//
//  BarMarkSimpleView.swift
//  charts-sample
//
//  Created by 山田楓也 on 2023/06/21.
//

import SwiftUI
import Charts

private struct Profit: Identifiable {
    let department: String
    let profit: Double
    var id = UUID()
}

struct BarMarkSimpleView: View {
    private let data: [Profit] = [
        Profit(department: "Production", profit: 15000),
        Profit(department: "Marketing", profit: 8000),
        Profit(department: "Finance", profit: 10000)
    ]

    var body: some View {
        Chart(data) {
            BarMark(
                x: .value("Department", $0.department),
                y: .value("Profit", $0.profit)
            )
        }
        .frame(height: 400)
    }
}

struct BarMarkView_Previews: PreviewProvider {
    static var previews: some View {
        BarMarkSimpleView()
    }
}
