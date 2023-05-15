//
//  DetailDiaryView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DetailDiaryView: View {
  @Binding var selectedContent: DiaryContent?
  @State private var editMode: Bool = false
  @State private var showMenu: Bool = false
  
  func resetState(value: DiaryContent?) {
    withAnimation {
      showMenu = false
      editMode = false
    }
  }
  
  var body: some View {
    ZStack {
      if let content = selectedContent {
        if editMode == false {
          DiaryDisplayView(
            selectedContent: _selectedContent,
            editMode: $editMode,
            showMenu: $showMenu,
            content: content
          )
        } else {
          DiaryEditView(content: content)
        }
      } else {
        // TODO: - EditMode View 구현 (기본으로 작성할 수 있는 공간)
        DiaryEditView()
      }
    }
    .onChange(of: selectedContent, perform: resetState)
    .transition(.opacity.animation(.easeIn))
  }
}

struct DetailDiaryView_Previews: PreviewProvider {
  static var previews: some View {
    DiaryBoardView()
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
