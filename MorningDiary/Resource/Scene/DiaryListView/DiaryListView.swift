//
//  DiaryListView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DiaryListView: View {
  @Environment(\.backgroundColor) var backgroundColor
  @FetchRequest(
    entity: DiaryContent.entity(),
    sortDescriptors: []
  ) var contents: FetchedResults<DiaryContent>
  
  @Binding var selectedContent: DiaryContent?
  @State private var state: SwipeState = .untouched
  
  var diaries: [String: [DiaryContent]] {
    get {
      return group(contents)
    }
  }
  
  func group(_ result: FetchedResults<DiaryContent>) -> [String: [DiaryContent]] {
    let result = Dictionary(grouping: result) { $0.issuedDate }
    return result
  }
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      ForEach(diaries.sorted(by: { $0.key > $1.key }), id: \.key) { key, values in
        VStack(alignment: .leading) {
          Text(key) // SECTION HEADER
            .padding(.horizontal)
          
          ForEach(values, id: \.id) { content in // DIARY LIST CELLS
            DiaryListCell(
              selectedContent: $selectedContent,
              state: $state,
              content: content
            )
          }
        }
      }
    }
    .listStyle(.plain)
    .background(backgroundColor)
  }
}

private extension DiaryListView {
  struct DiaryListCell: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.backgroundColor) var backgroundColor
    @Environment(\.cornerRadius) var cornerRadius

    @Binding var selectedContent: DiaryContent?
    @Binding var state: SwipeState
    
    let content: DiaryContent

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
        Button {
          withAnimation {
            context.delete(content)
            try? context.save()
          }
        } label: {
          Image(systemName: "trash")
            .foregroundColor(selectedContent?.id == content.id ? .gray : .red)
        }
        .disabled(selectedContent?.id == content.id)
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
