//
//  OnboardingView.swift
//  VP
//
//  Created by Demir Kovacevic on 02/12/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var currPage: Int = 0
        
    let config = ConfigPageControl(
        numberOfPages: 3,
        spacing: 7,
        size: 7,
        borderWidht: 1
    )
    
    let congiPagingView = ConfigPagingView(
        itemCount: 3,
        pageWidth: UIScreen.main.bounds.width,
        tileWidth: UIScreen.main.bounds.width,
        tilePadding: 0
    )
    
    private var arrCards: [Card] = [
        Card(imgName: "first", strTitle: "lbl_onboarding_1"),
        Card(imgName: "onboarding_title_seventeen", strTitle: "lbl_onboarding_2"),
        Card(imgName: "onboarding_title_seven", strTitle: "lbl_onboarding_3")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            PagingView(
                currentPage: $currPage,
                config: congiPagingView
            ) {
                ForEach(arrCards, id: \.id) { item in
                    CardView(imgName: item.imgName, title: item.strTitle)
                }
            }
            Spacer()
            PageControl(currentPage: $currPage, config: config)
        }
        .padding(.bottom, 45)
        .edgesIgnoringSafeArea(.all)
    }
}

struct Card: Identifiable {
    
    let id: String = UUID().uuidString
    let imgName: String
    let strTitle: String
    
    init(
        imgName: String,
        strTitle: String
    ) {
        self.imgName = imgName
        self.strTitle = strTitle
    }
}

struct CardView: View {
    @State var imgName: String
    @State var title: String
    
    var body: some View {
        VStack(spacing: 5) {
            GeometryReader { geometry in
                Image(self.imgName)
                    .resizable()
                    .frame(height: geometry.size.width)
            }
            Text(LocalizedStringKey(stringLiteral: title))
                .font(.custom("ClanPro-Medium", size: 16))
                .multilineTextAlignment(.center)
                .padding(.leading, 24)
                .padding(.trailing, 24)
        }
    }
}

struct ConfigPageControl {
    var numberOfPages: Int = 5
    var spacing: CGFloat = 10
    var size: CGFloat = 20
    var borderWidht: CGFloat = 5
}

struct PageControl: View {
    @Binding var currentPage: Int
    var config: ConfigPageControl = ConfigPageControl()
    
    var body: some View {
        HStack(spacing: config.spacing) {
            ForEach(0 ..< config.numberOfPages) { number in
                ZStack {
                    Circle()
                        .frame(
                            width: self.config.size + self.config.borderWidht,
                            height: self.config.size + self.config.borderWidht
                    )
                        .foregroundColor(ColorHelper.darkBlue.color())
                    
                    Circle()
                        .frame(
                            width: self.config.size,
                            height: self.config.size
                    )
                        .foregroundColor(
                            number == self.currentPage ?
                                Color.white : ColorHelper.darkBlue.color()
                    ).onTapGesture {
                        self.currentPage = number
                    }
                }
            }
        }
    }
}

#if DEBUG
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
#endif

