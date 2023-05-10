//
//  DiaryListView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DiaryListView: View {
  @Environment(\.backgroundColor) var backgroundColor
  @Binding var selectedContent: DiaryContent?
  @State var toggleState: ToggleState = .unSelected
  @State var state: SwipeState = .untouched
  let diaries: [Diary]
  
  var body: some View {
    ScrollView {
      ForEach(diaries) { diary in
        VStack(alignment: .leading) {
          Text(diary.dateDescription)
            .padding(.horizontal)
          
          ForEach(diary.contents) { content in
            DiaryListCell(toggleState: $toggleState, state: $state, content: content)
          }
        }
        .padding(.top)
      }
    }
    .background(backgroundColor)
    .scrollContentBackground(.hidden)
    .background(.clear)
  }
}

private extension DiaryListView {
  @ViewBuilder
  func DiaryListSectionHeader(with date: Date) -> some View {
    Text(date.description(with: "yyyy년 MM월 dd일"))
  }
  
  struct DiaryListCell: View {
    @Environment(\.backgroundColor) var backgroundColor
    @Binding var toggleState: ToggleState
    @Binding var state: SwipeState
    let content: DiaryContent
    let id = UUID()
    
    var body: some View {
      HStack {
        VStack(alignment: .leading) {
          Text(content.title)
          
          Text(content.body)
        }
        
        Spacer()
      }
      .padding()
      .addToggleAction(state: $toggleState)
      .cornerRadius(12)
      .padding(.horizontal)
      .addSwipeAction(
        backgroundColor: backgroundColor,
        state: $state,
        edge: .trailing
      ) {
        Image(systemName: "trash")
          .foregroundColor(.red)
      }
    }
  }
}

struct DiaryListView_Previews: PreviewProvider {
  static var previews: some View {
    DiaryBoardView()
  }
}
