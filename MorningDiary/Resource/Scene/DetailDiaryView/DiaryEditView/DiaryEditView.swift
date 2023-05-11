//
//  DiaryEditView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DiaryEditView: View {
  @State var title: String = ""
  @State var description: String = ""
  @State var images: [String] = []
  
  init(content: DiaryContent) {
    self._title = State(initialValue: content.title)
    self._description = State(initialValue: content.body)
    self._images = State(initialValue: content.images)
  }
  
  init() { }
  
  var body: some View {
    VStack {
      TextField("제목을 입력하세요", text: $title)
        .font(.system(size: 32, weight: .bold))
        .submitLabel(.next)
      
      TextEditor(text: $description)
      
      Spacer()
      
      Divider()
      
      HStack {
        Button {
          withAnimation(.easeIn(duration: 0.1)) {
            UIApplication.endEditing()
          }
          
          // TODO: - 이미지 선택창 구현하기
        } label: {
          Image(systemName: "photo.on.rectangle.angled")
        }
        
        Button {
          withAnimation(.easeIn(duration: 0.1)) {
            UIApplication.endEditing()
          }
          
          // TODO: - 지도 뷰 구현하기
        } label: {
          Image(systemName: "map")
        }

        Spacer()
      }
      .font(.title2)
      .padding(.top)
    }
    .padding()
  }
}
