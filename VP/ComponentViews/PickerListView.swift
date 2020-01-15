//
//  PickerListView.swift
//  VP
//
//  Created by Demir Kovacevic on 13/01/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import SwiftUI

struct PickerListView: View {
    @Binding var pickedValue: String
    @Binding var showPicker: Bool

    @State private var countriesJSON: JsonFileReader<CountriesDataModel>? = {
        do {
            return try JsonFileReader<CountriesDataModel>()
        } catch let err {
            debugPrint("Failed to parse data: \(err)")
            return nil
        }
    }()

    var body: some View {
        List(countriesJSON?.data.countries ?? [], id: \.dialCode) { item in
            Text(item.name)
                .onTapGesture {
                    self.pickedValue = item.name
                    self.showPicker = false 
            }
        }
    }
}
