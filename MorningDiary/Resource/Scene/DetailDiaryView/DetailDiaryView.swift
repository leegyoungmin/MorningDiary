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
      if editMode == false && selectedContent != nil {
        DiaryDisplayView(
          selectedContent: _selectedContent,
          editMode: $editMode,
          showMenu: $showMenu
        )
      } else {
        DiaryEditView(selectedDiary: $selectedContent)
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
