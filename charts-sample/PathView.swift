//
//  PathView.swift
//  charts-sample
//
//  Created by 山田楓也 on 2023/06/25.
//

import SwiftUI

struct PathView: View {
    var body: some View {
        Polygon(sides: 3, scale: 0.4)
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))       // 開始位置
            path.addLine(to: CGPoint(x: 100, y: 0))  // 直線描画
            path.addArc(
                center: CGPoint(x: 100, y: 100),
                radius: 100,
                startAngle: .degrees(-90),
                endAngle: .degrees(0),
                clockwise: false
            )
//            path.closeSubpath()  // パスを閉じる
        }
        .stroke(lineWidth: 4)
        .frame(width: 200, height: 200)
    }
}

struct Polygon: Shape {
    let sides: Int
    let scale: CGFloat

    func path(in rect: CGRect) -> Path {
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0 * Double(scale)
        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        var path = Path()

        for i in 0..<sides {
            let angle = (Double(i) * (360.0 / Double(sides))) * Double.pi / 180
            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
            if i == 0 {
                path.move(to: pt) // move to the first point
            } else {
                path.addLine(to: pt) // draw a line to this point
            }
        }
        path.closeSubpath()
        return path
    }
}

struct PathView_Previews: PreviewProvider {
    static var previews: some View {
        PathView()
    }
}
