//
//  RadarChartView.swift
//  charts-sample
//
//  Created by 山田楓也 on 2023/06/21.
//

import SwiftUI
import Foundation

struct RadarChartView: View {
    @State var scoreValues: [Double] = [70, 70, 40, 80, 40]
    @State var labels: [String] = ["スピード", "スタミナ", "パワー", "根性", "賢さ"]
    @State var drawFraction: CGFloat = 0

    private let scaleValues: [Double] = [0.2, 0.4, 0.6, 0.8]

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                // Background of radar charts
                Group {
                    InnerLinesView(sides: scoreValues.count, geometry: geometry, labels: labels)
                    
                    ForEach(scaleValues, id: \.self) { scaleValue in
                        PolygonShape(sides: scoreValues.count)
                            .stroke(Color.gray, lineWidth: 1)
                            .scaleEffect(x: scaleValue, y: scaleValue)
                    }
                    
                    PolygonShape(sides: scoreValues.count)
                        .stroke(Color.gray, lineWidth: 1)
                }
                
                // スコア値に基づいた頂点を計算して描画
                Group {
                    // strokeとfillはどちらもViewを返すため、backgroundで再度Viewを設定する
                    PolygonScoreShape(scores: scoreValues, sides: scoreValues.count)
                        .stroke(Color.yellow, lineWidth: 3)
                        .background(
                            PolygonScoreShape(scores: scoreValues, sides: scoreValues.count)
                                .fill(Color.yellow.opacity(0.5))
                        )
                }
            }
        }
        .frame(width: 240, height: 240)
    }
}

// 多角形のシェイプを定義する
struct PolygonShape: Shape {
    let sides: Int

    func path(in rect: CGRect) -> Path {
        let centerX = rect.width / 2
        let centerY = rect.height / 2
        let radius = min(rect.width, rect.height) / 2
        
        let angle = .pi * 2 / Double(sides)
        let offsetAngle = -(Double.pi / 2) // 0度を上部にするために角度調整
        
        return Path { path in
            for index in 0..<sides {
                let currentAngle = angle * Double(index) + offsetAngle
                let x = centerX + cos(currentAngle) * radius
                let y = centerY + sin(currentAngle) * radius
                
                if index == 0 {
                    path.move(to: CGPoint(x: x, y: y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            
            path.closeSubpath()
        }
    }
}

struct PolygonScoreShape: Shape {
    var scores: [Double]
    let sides: Int

    func path(in rect: CGRect) -> Path {
        let centerX = rect.width / 2
        let centerY = rect.height / 2
        let radius = min(rect.width, rect.height) / 2
        
        let angle = .pi * 2 / Double(scores.count)
        let offsetAngle = -(Double.pi / 2) // 0度を上部にするためのオフセット

        return Path { path in
            for (index, score) in scores.enumerated() {
                let currentAngle = angle * Double(index) + offsetAngle
                let value = score / 100 // スコアを0〜1の範囲に変換
                let adjustedRadius = radius * CGFloat(value)
                
                let x = centerX + cos(currentAngle) * adjustedRadius
                let y = centerY + sin(currentAngle) * adjustedRadius
                
                if index == 0 {
                    path.move(to: CGPoint(x: x, y: y))
                } else {
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            
            path.closeSubpath()
        }
    }
}

struct InnerLinesView: View {
    let sides: Int
    let geometry: GeometryProxy
    let labels: [String]
    
    var body: some View {
        let centerX = geometry.size.width / 2
        let centerY = geometry.size.height / 2
        let radius = min(geometry.size.width, geometry.size.height) / 2

        let angle = 2 * Double.pi / Double(sides) // 五角形の場合、頂点数は5
        let offsetAngle = -(Double.pi / 2) // 0度を上部にするためのオフセット

        return (
            ZStack {
                Path { path in
                    for index in 0..<sides {
                        let currentAngle = angle * Double(index) + offsetAngle
                        let x = centerX + cos(currentAngle) * radius
                        let y = centerY + sin(currentAngle) * radius
                        
                        path.move(to: CGPoint(x: x, y: y))
                        path.addLine(to: CGPoint(x: centerX, y: centerY))
                    }
                }
                .stroke(Color.gray, lineWidth: 2)
                
                ForEach(0..<labels.count) { index in
                    let currentAngle = angle * Double(index) + offsetAngle
                    let x = centerX + cos(currentAngle) * (radius + 40)
                    let y = centerY + sin(currentAngle) * (radius + 20)
                    
                    Text(labels[index])
                        .position(x: x, y: y)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.bold)
                }
            }
        )
    }
}

struct RadarChartView_Previews: PreviewProvider {
    static var previews: some View {
        RadarChartView()
    }
}
