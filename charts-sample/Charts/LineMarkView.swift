//
//  LineMarkView.swift
//  charts-sample
//
//  Created by 山田楓也 on 2023/06/25.
//

import SwiftUI
import Charts

private struct MonthlyHoursOfSunshine: Identifiable {
    var date: Date
    var hoursOfSunshine: Double
    var id = UUID()

    init(month: Int, hoursOfSunshine: Double) {
        let calendar = Calendar.autoupdatingCurrent
        self.date = calendar.date(from: DateComponents(year: 2020, month: month))!
        self.hoursOfSunshine = hoursOfSunshine
    }
}

private struct CityMonthlyHoursOfSunshine: Identifiable {
    var city: String
    var date: Date
    var hoursOfSunshine: Double
    var id = UUID()

    init(city: String, month: Int, hoursOfSunshine: Double) {
        let calendar = Calendar.autoupdatingCurrent
        self.city = city
        self.date = calendar.date(from: DateComponents(year: 2020, month: month))!
        self.hoursOfSunshine = hoursOfSunshine
    }
}

struct LineMarkView: View {
    private let data: [MonthlyHoursOfSunshine] = [
        MonthlyHoursOfSunshine(month: 1, hoursOfSunshine: 74),
        MonthlyHoursOfSunshine(month: 2, hoursOfSunshine: 99),
        MonthlyHoursOfSunshine(month: 3, hoursOfSunshine: 62),
        MonthlyHoursOfSunshine(month: 4, hoursOfSunshine: 62),
        MonthlyHoursOfSunshine(month: 5, hoursOfSunshine: 30),
        MonthlyHoursOfSunshine(month: 6, hoursOfSunshine: 54),
        MonthlyHoursOfSunshine(month: 7, hoursOfSunshine: 34),
        MonthlyHoursOfSunshine(month: 8, hoursOfSunshine: 43),
    ]
    
    private let cityData: [CityMonthlyHoursOfSunshine] = [
        CityMonthlyHoursOfSunshine(city: "Seattle", month: 1, hoursOfSunshine: 34),
        CityMonthlyHoursOfSunshine(city: "Seattle", month: 2, hoursOfSunshine: 31),
        CityMonthlyHoursOfSunshine(city: "Seattle", month: 5, hoursOfSunshine: 66),
        CityMonthlyHoursOfSunshine(city: "Seattle", month: 7, hoursOfSunshine: 83),
        CityMonthlyHoursOfSunshine(city: "Seattle", month: 12, hoursOfSunshine: 92),
        
        CityMonthlyHoursOfSunshine(city: "Cupertino", month: 1, hoursOfSunshine: 196),
        CityMonthlyHoursOfSunshine(city: "Cupertino", month: 2, hoursOfSunshine: 106),
        CityMonthlyHoursOfSunshine(city: "Cupertino", month: 3, hoursOfSunshine: 90),
        CityMonthlyHoursOfSunshine(city: "Cupertino", month: 7, hoursOfSunshine: 96),
        CityMonthlyHoursOfSunshine(city: "Cupertino", month: 9, hoursOfSunshine: 100),
        CityMonthlyHoursOfSunshine(city: "Cupertino", month: 12, hoursOfSunshine: 199)
    ]
    
    var body: some View {
        GroupBox("Line Chart") {
            Chart(data) {
                LineMark(
                    x: .value("Month", $0.date),
                    y: .value("Hours of Sunshine", $0.hoursOfSunshine)
                )
            }
        }
        .frame(height: 200)
        .padding(16)
        .shadow(radius: 2)
        
        GroupBox("Line Chart - custom") {
            Chart(cityData) {
                LineMark(
                    x: .value("Month", $0.date),
                    y: .value("Hours of Sunshine", $0.hoursOfSunshine)
                )
                .foregroundStyle(by: .value("City", $0.city))
            }
        }
        .frame(height: 200)
        .padding(16)
        .shadow(radius: 2)
    }
}

struct LineMarkView_Previews: PreviewProvider {
    static var previews: some View {
        LineMarkView()
    }
}
