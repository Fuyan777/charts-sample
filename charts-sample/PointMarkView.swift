//
//  PointMarkView.swift
//  charts-sample
//
//  Created by 山田楓也 on 2023/06/25.
//

import SwiftUI
import Charts

struct Insect: Identifiable {
    let name: String
    let family: String
    let wingLength: Double
    let wingWidth: Double
    let weight: Double
    var id = UUID()
}

struct PointMarkView: View {
    var data: [Insect] = [
        Insect(name: "Hepialidae", family: "Lepidoptera", wingLength: 61, wingWidth: 52, weight: 22),
        Insect(name: "Danaidae", family: "Lepidoptera", wingLength: 60, wingWidth: 48, weight: 24),
        Insect(name: "Riodinidae", family: "Lepidoptera", wingLength: 53, wingWidth: 43, weight: 18),
        Insect(name: "Nymphalidae", family: "Lepidoptera", wingLength: 55, wingWidth: 47, weight: 19),
        Insect(name: "Saturniidae", family: "Lepidoptera", wingLength: 64, wingWidth: 57, weight: 26),
        
        Insect(name: "Formicidae", family: "Hymenoptera", wingLength: 0, wingWidth: 0, weight: 0),
        Insect(name: "Apidae", family: "Hymenoptera", wingLength: 15, wingWidth: 18, weight: 4),
        Insect(name: "Formicidae", family: "Hymenoptera", wingLength: 10, wingWidth: 7, weight: 0),
        Insect(name: "Apidae", family: "Hymenoptera", wingLength: 15, wingWidth: 18, weight: 4),
        
        Insect(name: "Curculionidae", family: "Diptera", wingLength: 30, wingWidth: 31, weight: 3),
        Insect(name: "Curculionidae", family: "Diptera", wingLength: 27, wingWidth: 17, weight: 3),
        Insect(name: "Curculionidae", family: "Diptera", wingLength: 39, wingWidth: 30, weight: 3),
        Insect(name: "Curculionidae", family: "Diptera", wingLength: 35, wingWidth: 34, weight: 3),
    ]
    
    var body: some View {
        GroupBox("Point Chart") {
            Chart(data) {
                PointMark(
                    x: .value("Wing Length", $0.wingLength),
                    y: .value("Wing Width", $0.wingWidth)
                )
//                .foregroundStyle(by: .value("Family", $0.family))
            }
        }
        .frame(height: 200)
        .padding(16)
        .shadow(radius: 2)
    }
}

struct PointMarkView_Previews: PreviewProvider {
    static var previews: some View {
        PointMarkView()
    }
}
