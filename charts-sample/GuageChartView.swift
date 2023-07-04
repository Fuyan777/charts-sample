//
//  GuageChartView.swift
//  charts-sample
//
//  Created by fuya.yamada on 2023/06/30.
//

import SwiftUI

struct MeterView: View {
    @State private var point: Double = 0 //max: 14
    private let lineWidth: CGFloat = 40.0

    var body: some View {
        ZStack {
            ArcView(startAngle: -130, endAngle: -70)
                .fill(Color.blue)
            ArcView(startAngle: -70, endAngle: 0)
                .fill(Color.green)
            ArcView(startAngle: 0, endAngle: 70)
                .fill(Color.orange)
            ArcView(startAngle: 70, endAngle: 130)
                .fill(Color.red)
            
            // 円弧非表示
            ArcView(startAngle: 130, endAngle: 230)
                .fill(Color.white)
                .frame(width: 210, height: 210)
            
            Circle()
                .fill(Color.white)
                .frame(width: 130, height: 130)
            
            MeterArrow(arrowPoint: point)
                .stroke(Color.black, style: StrokeStyle(lineWidth: 8, lineCap: .round))
            Circle()
                .frame(width: 18, height: 18)
            
            GeometryReader { geometry in
                MeterMemoryTextView(geometry: geometry)
            }
        }
        .frame(width: 200, height: 200)
        .padding()
        .onAppear {
            withAnimation(.easeIn.speed(0.5)) {
                point = 14
            }
            
            withAnimation(.easeIn.speed(0.2).delay(1.0)) {
                point = 3
            }
        }
    }
}

struct MeterArrow: Shape {
    var arrowPoint: Double
    
    var animatableData: Double {
        get { arrowPoint }
        set { arrowPoint = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let centerX = rect.width / 2
        let centerY = rect.height / 2
        let radius = min(rect.width, rect.height) / 2.5
        
        let angle = .pi / Double(10) // 半円をn等分
        let offsetAngle = Double.pi * 4 / 5 // 0度を上部にするために角度調整
        
        let currentAngle = angle * arrowPoint + offsetAngle
        let x = centerX + cos(currentAngle) * radius
        let y = centerY + sin(currentAngle) * radius
        
        return Path { path in
            path.move(to: CGPoint(x: rect.width/2 , y: rect.height/2))
            path.addLine(to: CGPoint(x: x, y: y))
        }
    }
}

struct MeterMemoryTextView: View {
    var geometry: GeometryProxy
    @State var labels: [String] = ["0%", "25%", "50%", "75%", "100%"]
    
    var body: some View {
        let centerX = geometry.size.width / 2
        let centerY = geometry.size.height / 2
        let radius = min(geometry.size.width, geometry.size.height) / 2
        
        let angle = 2 * Double.pi / Double(5) // 五角形の場合、頂点数は5
        let offsetAngle = -(Double.pi * -12.5 / 18) // 0度を上部にするためのオフセット
        
        return (
            ZStack {
                ForEach(0..<labels.count) { index in
                    let currentAngle = angle * Double(index) + offsetAngle
                    let x = centerX + cos(currentAngle) * (radius + 30)
                    let y = centerY + sin(currentAngle) * (radius + 15)
                    
                    Text(labels[index])
                        .position(x: x, y: y)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.bold)
                }
            }
        )
    }
}

struct GaugeView_Previews: PreviewProvider {
    static var previews: some View {
        MeterView()
    }
}

