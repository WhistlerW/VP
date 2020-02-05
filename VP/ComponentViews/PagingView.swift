//
//  PagingView.swift
//  VP
//
//  Created by Demir Kovacevic on 15/01/2020.
//  Copyright © 2020 Demir Kovacevic. All rights reserved.
//

import SwiftUI

struct ConfigPagingView {
    
    var itemCount: Int
    var pageWidth: CGFloat
    var tileWidth: CGFloat
    var tilePadding: CGFloat
    
    init(
        itemCount: Int = 0,
        pageWidth: CGFloat = 0,
        tileWidth: CGFloat = 100,
        tilePadding: CGFloat = 5
    ) {
        self.itemCount = itemCount
        self.pageWidth = pageWidth
        self.tileWidth = tileWidth
        self.tilePadding = tilePadding
    }
}

struct PagingView: View {
    
    private struct Config {
        let tileRemain : CGFloat
        let contentWidth : CGFloat
        let leadingOffset : CGFloat
        let stackOffset : CGFloat
        let scrollDampingFactor: CGFloat = 0
        
        init(config: ConfigPagingView) {
            self.tileRemain = (config.pageWidth-config.tileWidth-2*config.tilePadding)/2
            self.contentWidth = (config.tileWidth+config.tilePadding)*CGFloat(config.itemCount)
            self.leadingOffset = self.tileRemain+config.tilePadding
            let dWidth = self.contentWidth/2 - config.pageWidth/2
            self.stackOffset = dWidth - config.tilePadding/2
        }
    }
    
    @EnvironmentObject private var rootViewType: RootViewsType
    
    @Binding var currentPage : Int
    @State var currentScrollOffset: CGFloat = 0
    @State private var dragOffset : CGFloat = 0
    
    let items: [AnyView]
    let config: ConfigPagingView
    
    private let intConfig: Config
    
    init<A: View>(
        currentPage:Binding<Int>,
        config: ConfigPagingView,
        @ViewBuilder content: () -> A
    ) {
        self.items = [AnyView(content())]
        self._currentPage = currentPage
        self.config = config
        self.intConfig = Config(config: config)
    }
    
    func offsetForPageIndex(_ index: Int) -> CGFloat {
        let activePageOffset = CGFloat(index)*(config.tileWidth+config.tilePadding)
        return self.intConfig.leadingOffset - activePageOffset
    }
    
    func indexPageForOffset(_ offset : CGFloat) -> Int {
        guard config.itemCount > 0 else { return 0 }
        let offset = self.logicalScrollOffset(trueOffset: offset)
        let floatIndex = offset / (config.tileWidth+config.tilePadding)
        var computedIndex = Int(round(floatIndex))
        computedIndex = max(computedIndex, 0)
        return min(computedIndex, config.itemCount-1)
    }
    
    func computeCurrentScrollOffset() -> CGFloat {
        return self.offsetForPageIndex(self.currentPage) + self.dragOffset
    }
    
    func logicalScrollOffset(trueOffset: CGFloat) -> CGFloat {
        return (trueOffset-intConfig.leadingOffset) * -1.0
    }
    
    
    var body: some View {
        HStack(
            alignment: .center,
            spacing: self.config.tilePadding
        )  {
            ForEach(0..<self.items.count) { index in
                self.items[index]
                    .offset(x: self.currentScrollOffset, y: 0)
                    .frame(width: self.config.tileWidth)
            }
            Text(String(currentPage))
        }
        .onAppear {
            self.currentScrollOffset = self.offsetForPageIndex(self.currentPage)
        }
        .offset(x: self.intConfig.stackOffset, y: 0)
        .frame(width: self.intConfig.contentWidth)
        .simultaneousGesture(
            DragGesture(
                minimumDistance: 1,
                coordinateSpace: .local
            )
                .onChanged { value in
                    self.dragOffset = value.translation.width
                    self.currentScrollOffset = self.computeCurrentScrollOffset()
            }
            .onEnded { value in
                let velocityDiff = (value.predictedEndTranslation.width - self.dragOffset)*self.intConfig.scrollDampingFactor
                let newPageIndex = self.indexPageForOffset(self.currentScrollOffset + velocityDiff)
                self.dragOffset = 0
                withAnimation(.linear){
                    if self.currentPage > self.items.count {
                        self.rootViewType.typeRootView = .registrationLogin
                        self.rootViewType.tabState = .register
                    }
                    self.currentPage = newPageIndex
                    self.currentScrollOffset = self.computeCurrentScrollOffset()
                }
            }
        )
    }
}
