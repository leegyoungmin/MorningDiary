//
//  DiaryBoardView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DiaryBoardView: View {
  @State private var mockDiaries = Diary.mockDiary
  @State private var selectedContent: DiaryContent?
  
  var body: some View {
    HStack {
      NavigationStack {
        DiaryListView(
          selectedContent: $selectedContent,
          diaries: mockDiaries
        )
        .navigationTitle("모닝 일기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
      }
      .frame(maxWidth: 450)
      
      NavigationStack {
        DetailDiaryView(selectedContent: $selectedContent)
      }
    }
  }
}

struct DiaryBoardView_Previews: PreviewProvider {
  static var previews: some View {
    DiaryBoardView()
  }
}
