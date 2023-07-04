//
//  MultiPieChartView.swift
//  charts-sample
//
//  Created by 山田楓也 on 2023/07/02.
//

import SwiftUI

struct MultiPieData: Identifiable {
    var id = UUID()
    var endAngle1: Double
    var endAngle2: Double
    var endAngle3: Double
    var frameSize: CGFloat
}

struct MultiPieChartView: View {
    @State var data: [MultiPieData] = [
        MultiPieData(endAngle1: 0, endAngle2: 0, endAngle3: 3, frameSize: 300),
        MultiPieData(endAngle1: 0, endAngle2: 0, endAngle3: 4, frameSize: 250),
        MultiPieData(endAngle1: 0, endAngle2: 0, endAngle3: 1, frameSize: 200),
        MultiPieData(endAngle1: 0, endAngle2: 60, endAngle3: 40, frameSize: 150),
        MultiPieData(endAngle1: 0, endAngle2: 60, endAngle3: 30, frameSize: 100),
        MultiPieData(endAngle1: 0, endAngle2: 60, endAngle3: 20, frameSize: 50)
    ]

    var body: some View {
        ZStack {
            ForEach($data) { pieData in
                SinglePieChartView(data: pieData)
            }
        }
    }
}

struct SinglePieChartView: View {
    @Binding var data: MultiPieData
    
    var body: some View {
        ZStack {
            ArcView(startAngle: 0, endAngle: data.endAngle3)
                .fill(Color("red"))
            
            ArcView(startAngle: 0, endAngle: data.endAngle2)
                .fill(Color("blue"))
            
            ArcView(startAngle: 0, endAngle: data.endAngle1)
                .fill(Color("green"))
            
            Circle()
                .fill(Color.white)
                .frame(width: data.frameSize - 30)
        }
        .frame(width: data.frameSize, height: data.frameSize)
        .onAppear {
            withAnimation() {
                data.endAngle1 = 140 + CGFloat.random(in: 0...40)
            }
            
            withAnimation(Animation.default.delay(0.1)) {
                data.endAngle2 = 250 + CGFloat.random(in: 0...30)
            }
            
            withAnimation(Animation.default.delay(0.2)) {
                data.endAngle3 = 360
            }
        }
    }
}

struct MultiPieChartView_Previews: PreviewProvider {
    static var previews: some View {
        MultiPieChartView()
    }
}
