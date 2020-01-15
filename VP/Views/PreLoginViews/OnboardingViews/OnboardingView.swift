//
//  OnboardingView.swift
//  VP
//
//  Created by Demir Kovacevic on 02/12/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    @State var currPage: Int = 1
    
    let config = ConfigPageControl(
        numberOfPages: 3,
        spacing: 7,
        size: 7,
        borderWidht: 1
    )
    
    @State var dragOffset = CGSize.zero
    
    var body: some View {
        VStack(alignment: .center) {
            ContentView()
                .environmentObject(SwipeObserver())
//            Image("Onboarding_first")
//                .resizable()
//                .frame(width: 300, height: 300)
//                .foregroundColor(.secondary)
//                .offset(x: self.dragOffset.width)
//                .gesture(
//                    DragGesture(minimumDistance: 30)
//                        .onChanged { (value) in
//                            self.dragOffset = value.translation
//                        }
//                    .onEnded { value in
//                        self.dragOffset = .zero
//                    }
//                )

            Spacer()
            PageControl(currentPage: $currPage, config: config)
        }
        .padding(.bottom, 45)
    }
}

struct Cards: Identifiable {
    var id: Int
    var drag: CGFloat
    var imgName: String
    var title: String
}

class SwipeObserver : ObservableObject{
    
    @Published var cards = [Cards]()
    
    init() {
        
        self.cards.append(Cards(id: 0, drag: 0, imgName: "Onboarding_first", title: "Screen1"))
        self.cards.append(Cards(id: 1, drag: 0, imgName: "Onboarding_second", title: "Screen2"))
        self.cards.append(Cards(id: 2, drag: 0, imgName: "onboarding_title_seventeen", title: "Screen3"))
        self.cards.append(Cards(id: 3, drag: 0, imgName: "Onboarding_first", title: "Screen4"))
        self.cards.append(Cards(id: 4, drag: 0, imgName: "Onboarding_second", title: "Screen5"))
        self.cards.append(Cards(id: 5, drag: 0, imgName: "onboarding_title_seventeen", title: "Screen6"))

    }
    
    func update(id : Cards, value : CGFloat){
        
        for i in 0..<self.cards.count{
            
            if self.cards[i].id == id.id{
                self.cards[i].drag = value
            }
        }
    }
}

struct ContentView : View {

    @EnvironmentObject var observer : SwipeObserver
    
    var body : some View {
        
        GeometryReader { geo in
            ZStack {
                ForEach(self.observer.cards) { card in
                    Image(card.imgName)
                        .cornerRadius(20)
                        .frame(width: geo.size.width-40, height: geo.size.height - 80, alignment: .center)
                        .gesture(DragGesture()
                            .onChanged({ (value) in
                                if value.translation.width > 0 {
                                    
                                    if value.translation.width > 30 {
                                        self.observer.update(id: card, value: value.translation.width)
                                    }
                                    else{
                                        self.observer.update(id: card, value: value.translation.width)
                                    }
                                }
                                else{
                                    
                                    if value.translation.width < -30 {
                                        self.observer.update(id: card, value: value.translation.width)
                                    }
                                    else{
                                        self.observer.update(id: card, value: value.translation.width)
                                    }
                                }
                                
                            }).onEnded({ (value) in
                                if card.drag > 0 {

                                    if card.drag > geo.size.width / 2 - 40 {
                                        self.observer.update(id: card, value: 500)
                                    }
                                    else{
                                        self.observer.update(id: card, value: 0)
                                    }
                                }
                                else{

                                    if -card.drag > geo.size.width / 2 - 40 {
                                        self.observer.update(id: card, value: -500)
                                    }
                                    else{
                                        self.observer.update(id: card, value: 0)
                                    }
                                }
                                
                            })
                    )
                        .offset(x: card.drag)
                        .animation(.spring())
                    
                }
            }
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
