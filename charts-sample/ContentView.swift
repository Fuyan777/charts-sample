//
//  ContentView.swift
//  charts-sample
//
//  Created by 山田楓也 on 2023/06/21.
//

import SwiftUI
import Charts

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            Text("Fuyaのやる気")
                .font(.system(.title, design: .rounded))
                .fontWeight(.bold)
                .padding(.bottom, 50)

            VStack(spacing: 80) {
//                PieChartView()
//                RadarChartView()
                GaugeView()
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
