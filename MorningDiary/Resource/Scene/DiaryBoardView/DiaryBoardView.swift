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
    GeometryReader { proxy in
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
        .frame(width: proxy.size.width / 3, height: proxy.size.height)
        
        NavigationView {
          DetailDiaryView(selectedContent: $selectedContent)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .frame(width: proxy.size.width * (2 / 3), height: proxy.size.height)
      }
    }
  }
}

struct DiaryBoardView_Previews: PreviewProvider {
  static var previews: some View {
    DiaryBoardView()
  }
}
