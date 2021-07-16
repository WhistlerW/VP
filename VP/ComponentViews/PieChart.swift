//
//  PieChart.swift
//  VP
//
//  Created by Demir Kovacevic on 19/02/2021.
//  Copyright © 2021 Demir Kovacevic. All rights reserved.
//

import Foundation
import SwiftUI

struct PieChartView: Shape {
    
    let startAngle: Angle
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: (rect.origin.x + rect.width) / 2, y: (rect.origin.y + rect.height) / 2)
        let radius = min(center.x, center.y)
        let path = Path { path in
            path.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: true
            )
            path.addLine(to: center)
        }
        
        return path
    }

}

struct InnerCircle: Shape {
    
    let ratio: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: (rect.origin.x + rect.width) / 2, y: (rect.origin.y + rect.height) / 2)
        let radius = min(center.x, center.y) * ratio
        let path = Path { path in
            path.addArc(
                center: center,
                radius: radius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 360),
                clockwise: true
            )
            path.addLine(to: center)
        }
        
        return path
    }
}

struct DonutChart: View {
    
    @State private var selectedCell: UUID = UUID()
    
    let dataModel: ChartDataModel
    let onTap: (ChartViewModel?) -> ()
    
    var body: some View {
        ZStack {
            PieChart(dataModel: dataModel, onTap: onTap)
            InnerCircle(ratio: 2 / 3).foregroundColor(.white)
        }
    }
    
}

struct PieChart: View {
    
    @State private var selectedCell: UUID = UUID()
    
    let dataModel: ChartDataModel
    let onTap: (ChartViewModel?) -> ()
    
    var body: some View {
        ZStack {
            ForEach(dataModel.chartViewModel) { dataSet in
                PieChartView(startAngle: self.dataModel.angle(for: dataSet.value), endAngle: self.dataModel.startingAngle)
                    .foregroundColor(dataSet.color)
                    .onTapGesture {
                        withAnimation {
                            if self.selectedCell == dataSet.id {
                                self.onTap(nil)
                                self.selectedCell = UUID()
                            } else {
                                self.selectedCell = dataSet.id
                                self.onTap(dataSet)
                            }
                        }
                    }.scaleEffect((self.selectedCell == dataSet.id) ? 1.05 : 1.0)
            }
        }
    }
}

struct ChartViewModel: Identifiable {
    let id = UUID()
    let color: Color
    let value: CGFloat
    let name: String
}

final class ChartDataModel: ObservableObject {
    
    var chartViewModel: [ChartViewModel]
    var startingAngle = Angle(degrees: .zero)
    
    private var lastBarEndAngle = Angle(degrees: .zero)
    
    init(dataModel: [ChartViewModel]) {
        chartViewModel = dataModel
    }
    
    var totalValue: CGFloat {
        chartViewModel.reduce(.zero) { (result, data) -> CGFloat in
            result + data.value
        }
    }
    
    func angle(for value: CGFloat) -> Angle {
        if startingAngle != lastBarEndAngle {
            startingAngle = lastBarEndAngle
        }
        lastBarEndAngle += Angle(degrees: Double(value / totalValue) * 360)
        debugPrint(lastBarEndAngle.degrees)
        return lastBarEndAngle
    }
}

let sample = [
    ChartViewModel(color: Color.red, value: 123, name: "Math"),
    ChartViewModel(color: Color.yellow, value: 233, name: "Physics"),
    ChartViewModel(color: Color.pink, value: 73, name: "Chemistry"),
    ChartViewModel(color: Color.blue, value: 731, name: "Litrature"),
    ChartViewModel(color: Color.green, value: 51, name: "Art")
]
