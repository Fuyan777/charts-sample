//
//  PathView.swift
//  charts-sample
//
//  Created by 山田楓也 on 2023/06/25.
//

import SwiftUI

struct PathView: View {
    var body: some View {
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
            path.closeSubpath()  // パスを閉じる
        }
        .stroke(lineWidth: 4)
        .frame(width: 200, height: 200)
    }
}

struct PathView_Previews: PreviewProvider {
    static var previews: some View {
        PathView()
    }
}
