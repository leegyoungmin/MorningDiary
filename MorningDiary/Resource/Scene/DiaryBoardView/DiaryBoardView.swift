//
//  DiaryBoardView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DiaryBoardView: View {
  // TODO: - Diary Data 읽어오기
  @State private var selectedContent: SectionItem?
  
  var body: some View {
    NavigationView {
      DiaryListView(selectedItem: $selectedContent)
    }
  }
}

struct DiaryBoardView_Previews: PreviewProvider {
  static var previews: some View {
    DiaryBoardView()
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
