//
//  DiaryListView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DiaryListView: View {
  let diaries: [Diary]
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      ForEach(diaries, id: \.id) { diary in
        VStack(alignment: .leading) {
          Text(diary.createdDate.description)
          
          ForEach(diary.contents, id: \.id) { content in
            HStack {
              VStack(alignment: .leading) {
                Text(content.title)
                Text(content.body)
              }
              
              Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
          }
        }
        .padding()
      }
    }
    .background(
      Color.gray
        .opacity(0.3)
        .edgesIgnoringSafeArea(.all)
    )
  }
}

struct DiaryListView_Previews: PreviewProvider {
  static var previews: some View {
    DiaryListView(diaries: Diary.mockDiary)
  }
}
