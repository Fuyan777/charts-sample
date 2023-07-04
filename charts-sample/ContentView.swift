//
//  ContentView.swift
//  charts-sample
//
//  Created by 山田楓也 on 2023/06/21.
//

import SwiftUI
import Charts

struct ContentView: View {
    enum ChartMode {
        case pie
        case radar
        case meter
        case multiPie
        
        var title: String {
            switch self {
            case .pie: return "Fuyaの脳内"
            case .radar: return "Fuyaのステータス"
            case .meter: return "Fuyaやる気メーター"
            case .multiPie: return "多重ドーナッツグラフ"
            }
        }
    }

    @State var chartMode: ChartMode = .multiPie

    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            Text(chartMode.title)
                .font(.system(.title, design: .rounded))
                .fontWeight(.bold)
                .padding(.bottom, 40)

            VStack(spacing: 80) {
                switch chartMode {
                case .pie:
                    PieChartView()
                case .radar:
                    RadarChartView()
                case .meter:
                    MeterView()
                case .multiPie:
                    MultiPieChartView()
                }
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(chartMode: .pie)
        ContentView(chartMode: .radar)
        ContentView(chartMode: .meter)
        ContentView(chartMode: .multiPie)
    }
}
