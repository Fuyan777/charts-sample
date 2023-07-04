//
//  RuleMarkView.swift
//  charts-sample
//
//  Created by 山田楓也 on 2023/06/21.
//

import SwiftUI
import Charts

private struct Pollen: Identifiable {
    var source: String
    var startDate: Date
    var endDate: Date
    var id = UUID()

    init(startMonth: Int, numMonths: Int, source: String) {
        self.source = source
        let calendar = Calendar.autoupdatingCurrent
        self.startDate = calendar.date(from: DateComponents(year: 2020, month: startMonth, day: 1))!
        self.endDate = calendar.date(byAdding: .month, value: numMonths, to: startDate)!
    }
}

struct RuleMarkView: View {
    private let data: [Pollen] = [
        Pollen(startMonth: 1, numMonths: 9, source: "Trees"),
        Pollen(startMonth: 12, numMonths: 1, source: "Trees"),
        Pollen(startMonth: 3, numMonths: 8, source: "Grass"),
        Pollen(startMonth: 4, numMonths: 8, source: "Weeds")
    ]

    var body: some View {
        VStack {
            GroupBox("Rule Chart") {
                Chart(data) {
                    RuleMark(
                        xStart: .value("Start Date", $0.startDate),
                        xEnd: .value("End Date", $0.endDate),
                        y: .value("Pollen Source", $0.source)
                    )
                }
            }
            .frame(height: 200)
            .padding(16)
            .shadow(radius: 2)
        }
    }
}

struct RuleMarkView_Previews: PreviewProvider {
    static var previews: some View {
        RuleMarkView()
    }
}
