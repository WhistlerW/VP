//
//  HomeView.swift
//  VP
//
//  Created by Demir Kovacevic on 03/04/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selectedCell: UUID = UUID()
    
    let dataModel: ChartDataModel
    
    @State var selectedPie: String = ""
    @State var selectedDonut: String = ""
    
    var body: some View {
        DonutChart(dataModel: ChartDataModel.init(dataModel: sample), onTap: {
            dataModel in
            if let dataModel = dataModel {
                self.selectedDonut = "Subject: \(dataModel.name)\nPointes: \(dataModel.value)"
            } else {
                self.selectedDonut = ""
            }
        })
        .frame(width: 150, height: 150, alignment: .center)
        .padding()
        Text(selectedDonut)
            .font(.footnote)
            .multilineTextAlignment(.leading)
        Spacer()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        let dataModel = ChartDataModel(dataModel: sample)
        
        HomeView(dataModel: dataModel)
    }
}
