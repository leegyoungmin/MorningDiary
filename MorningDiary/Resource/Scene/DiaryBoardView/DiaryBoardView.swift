//
//  DiaryBoardView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DiaryBoardView: View {
  @State private var mockDiaries = Diary.mockDiary
  var body: some View {
    HStack(alignment: .center, spacing: .zero) {
      
      listSection
        .frame(maxWidth: 450)
      
      detailDiarySection
        .padding()
    }
    .ignoresSafeArea(.keyboard)
  }
}

private extension DiaryBoardView {
  var listSection: some View {
    VStack {
      HStack(alignment: .center) {
        Spacer()
        
        Text("모닝 일기")
        
        Spacer()
      }
      
      DiaryListView(diaries: mockDiaries)
      
    }
  }
  
  var detailDiarySection: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .center) {
        Spacer()
        
        Button {
          print("Tapped Save")
        } label: {
          Image(systemName: "checkmark")
        }
        .font(.system(size: 28, weight: .light))
      }
      
      TextField("제목을 입력하세요.", text: .constant(""))
        .font(.system(size: 34, weight: .black))
      
      TextEditor(text: .constant(""))
      
      HStack {
        Button {
          print("Tapped")
        } label: {
          Image(systemName: "photo.on.rectangle.angled")
            .font(.title2)
        }
        
        Spacer()
      }
    }
  }
}

struct DiaryBoardView_Previews: PreviewProvider {
  static var previews: some View {
    DiaryBoardView()
  }
}
