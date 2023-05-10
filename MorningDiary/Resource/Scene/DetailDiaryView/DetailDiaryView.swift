//
//  DetailDiaryView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DetailDiaryView: View {
  @Binding var selectedContent: DiaryContent?
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(selectedContent?.title ?? "")
          .font(.system(size: 24, weight: .bold))
        
        Spacer()
      }
      
      HStack {
        Text(selectedContent?.body ?? "")
        
        Spacer()
      }
      
      Spacer()
    }
    .padding(.horizontal)
    .toolbar {
      if (selectedContent == nil) == false {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            withAnimation {
              self.selectedContent = nil
            }
          } label: {
            Image(systemName: "chevron.backward")
          }
        }
      }
    }
  }
}
