//
//  DetailDiaryView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DetailDiaryView: View {
  @Binding var selectedContent: DiaryContent?
  @State private var showMenu: Bool = false
  
  var body: some View {
    if let content = selectedContent {
      DiaryDisplayView(
        selectedContent: _selectedContent,
        showMenu: $showMenu,
        content: content
      )
      .transition(.opacity.animation(.easeIn))
    }
  }
}

struct DetailDiaryView_Previews: PreviewProvider {
  static var previews: some View {
    DiaryBoardView()
  }
}
