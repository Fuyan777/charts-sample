//
//  PieChartView.swift
//  charts-sample
//
//  Created by 山田楓也 on 2023/06/24.
//

import SwiftUI

struct PieChartView: View {
    @State private var endAngle1 = 0.0
    @State private var endAngle2 = 0.0
    @State private var endAngle3 = 0.0

    var body: some View {
        VStack(spacing: 100) {
            ZStack {
                ArcView(startAngle: 0, endAngle: endAngle3)
                    .fill(Color("green"))

                ArcView(startAngle: 0, endAngle: endAngle2)
                    .fill(Color("blue"))

                ArcView(startAngle: 0, endAngle: endAngle1)
                    .fill(Color("red"))

                GeometryReader { geometry in
                    ArcLabelView(geometry: geometry, title: "ちいかわ\n40%", startAngle: 0, endAngle: endAngle1, index: 1)
                    
                    ArcLabelView(geometry: geometry, title: "ボロネーゼ\n30%", startAngle: 130, endAngle: endAngle2, index: 2)
                    
                    ArcLabelView(geometry: geometry, title: "JOJO\n25%", startAngle: 240, endAngle: endAngle3, index: 3)
                }
            }
        }
        .onAppear {
            withAnimation() {
                endAngle1 = 140
            }
            
            withAnimation(Animation.default.delay(0.1)) {
                endAngle2 = 250
            }
            
            withAnimation(Animation.default.delay(0.2)) {
                endAngle3 = 360
            }
        }
        .frame(width: 240, height: 240)
    }
}

struct ArcView: Shape {
    var startAngle: Double
    var endAngle: Double
    
    var animatableData: Double {
        get{endAngle}
        set{endAngle = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle(degrees: 90)
        let adjustedStartAngle = Angle(degrees: startAngle) - rotationAdjustment
        let adjustedEndAngle = Angle(degrees: endAngle) - rotationAdjustment

        return Path { p in
            p.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.width / 2,
                startAngle: adjustedStartAngle, endAngle: adjustedEndAngle,
                clockwise: false
            )
            p.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
            p.closeSubpath()
        }
    }
}

struct ArcLabelView: View {
    let geometry: GeometryProxy
    var title: String
    var startAngle: Double
    var endAngle: Double
    var index: Int
    
    var body: some View {
        let centerX = geometry.size.width / 2
        let centerY = geometry.size.height / 2
        let radius = min(geometry.size.width, geometry.size.height) / 3.3
        
        let angle = .pi * 2 / 3.0
        let offsetAngle = -(Double.pi * 3 / 4) // 0度を上部にするためのオフセット
        
        let currentAngle = angle * Double(index) + offsetAngle

        let x = centerX + cos(currentAngle) * radius
        let y = centerY + sin(currentAngle) * radius
        
        return (
            Text(title)
                .position(x: x, y: y)
                .font(.system(.body, design: .rounded))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        )
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView()
            .frame(width: 220, height: 220)
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        // 不要なスペースや改行があれば除去
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        // スキャナーオブジェクトの生成
        let scanner = Scanner(string: hexString)

        // 先頭(0番目)が#であれば無視させる
        if (hexString.hasPrefix("#")) {
            scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        }

        var color:Int64 = 0
        // 文字列内から16進数を探索し、Int64型で color変数に格納
        scanner.scanHexInt64(&color)

        let mask:Int = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

}
