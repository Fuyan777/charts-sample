//
//  GuageChartView.swift
//  charts-sample
//
//  Created by fuya.yamada on 2023/06/30.
//

import SwiftUI

struct GaugeView: View {
    @State var point: Double = 0 //max: 14
    
    var lineWidth: CGFloat = 40.0
    
    var body: some View {
        ZStack {
            ArcView(startAngle: -130, endAngle: 0)
                .fill(Color.green)
            ArcView(startAngle: 0, endAngle: 80)
                .fill(Color.orange)
            ArcView(startAngle: 80, endAngle: 130)
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
        }
        .frame(width: 200, height: 200)
        .padding()
        .onAppear {
            withAnimation(Animation.default.speed(0.3)) {
                point = 14
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
        let radius = min(rect.width, rect.height) / 2
        
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

struct GaugeView_Previews: PreviewProvider {
    static var previews: some View {
        GaugeView()
    }
}

