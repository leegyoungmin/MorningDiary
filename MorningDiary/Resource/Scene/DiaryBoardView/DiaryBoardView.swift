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

struct PlainDisclosureGroup<Label: View, Content: View>: View {
  @State private var isExpended: Bool = true
  let label: () -> Label
  let content: () -> Content
  
  init(
    label: @escaping () -> Label,
    content: @escaping () -> Content
  ) {
    self.label = label
    self.content = content
  }
  
  var body: some View {
    HStack {
      label()
      Spacer()
      Image(systemName: "chevron.right")
        .rotationEffect(.degrees(isExpended ? 90 : .zero))
    }
    .contentShape(Rectangle())
    .onTapGesture {
      withAnimation {
        self.isExpended.toggle()
      }
    }
    
    if isExpended {
      content()
    }
  }
}

struct DiaryBoardView_Previews: PreviewProvider {
  static var previews: some View {
    DiaryBoardView()
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
