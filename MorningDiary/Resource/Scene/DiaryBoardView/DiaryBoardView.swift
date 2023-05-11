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
    HStack(spacing: .zero) {
      NavigationView {
        DiaryListView(
          selectedContent: $selectedContent,
          diaries: mockDiaries
        )
        .navigationTitle("모닝 일기")
        .navigationBarTitleDisplayMode(.inline)
      }
      .navigationViewStyle(.stack)
      .frame(maxWidth: 450)
      
      NavigationView {
        DetailDiaryView(selectedContent: $selectedContent)
          .navigationBarTitleDisplayMode(.inline)
      }
      .navigationViewStyle(.stack)
    }
  }
}

struct DiaryBoardView_Previews: PreviewProvider {
  static var previews: some View {
    DiaryBoardView()
  }
}
