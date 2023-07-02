//
//  BarAndRuleMarkView.swift
//  charts-sample
//
//  Created by 山田楓也 on 2023/06/21.
//

import SwiftUI
import Charts

struct DepartmentProfit: Identifiable {
    var department: String
    var profit: Double
    var id = UUID()
}

var departmentProfitData: [DepartmentProfit] = [
    DepartmentProfit(department: "お肉", profit: 15000),
    DepartmentProfit(department: "お寿司", profit: 8000),
    DepartmentProfit(department: "パスタ", profit: 10000)
]


struct BarAndRuleMarkView: View {
    var body: some View {
        GroupBox("Bar and Rule Chart") {
            Chart {
                ForEach(departmentProfitData) {
                    BarMark(
                        x: .value("Department", $0.department),
                        y: .value("Profit", $0.profit)
                    )
                }
                RuleMark(y: .value("Break Even Threshold", 9000))
                    .foregroundStyle(Color("red"))
            }
        }
        .frame(height: 200)
        .padding(16)
        .shadow(radius: 2)
    }
}

struct BarAndRuleMarkView_Previews: PreviewProvider {
    static var previews: some View {
        BarAndRuleMarkView()
    }
}
