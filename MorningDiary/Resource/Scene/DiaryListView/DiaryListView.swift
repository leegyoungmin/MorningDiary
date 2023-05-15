//
//  DiaryListView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DiaryListView: View {
  @Environment(\.backgroundColor) var backgroundColor
  @Binding var selectedContent: DiaryContent?
  @State private var state: SwipeState = .untouched
  let diaries: [Diary]
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      ForEach(diaries) { diary in
        VStack(alignment: .leading) {
          Text(diary.dateDescription)
            .padding(.horizontal)
          
          ForEach(diary.contents) { content in
            DiaryListCell(
              selectedContent: $selectedContent,
              state: $state,
              content: content
            )
          }
        }
        .padding(.vertical)
        .background(backgroundColor)
      }
    }
    .listStyle(.plain)
    .background(backgroundColor)
  }
}

private extension DiaryListView {
  @ViewBuilder
  func DiaryListSectionHeader(with date: Date) -> some View {
    Text(date.description(with: "yyyy년 MM월 dd일"))
  }
  
  struct DiaryListCell: View {
    @Environment(\.backgroundColor) var backgroundColor
    @Environment(\.cornerRadius) var cornerRadius
    @Binding var selectedContent: DiaryContent?
    @Binding var state: SwipeState
    @State var content: DiaryContent
    
    var body: some View {
      HStack {
        VStack(alignment: .leading, spacing: 30) {
          Text(content.title)
          
          Text(content.body)
        }
        
        Spacer()
      }
      .padding()
      .foregroundColor(selectedContent?.id == content.id ? .white : .primary)
      .background(selectedContent?.id == content.id ? Color.accentColor : Color.white)
      .cornerRadius(cornerRadius)
      .padding(.horizontal)
      .padding(.vertical, 5)
      .onTapGesture {
        withAnimation {
          if selectedContent?.id == content.id {
            selectedContent = nil
            return
          }
          
          selectedContent = content
        }
      }
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
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
