//
//  DiaryDisplayView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DiaryDisplayView: View {
  @Binding var selectedContent: DiaryContent?
  @Binding var showMenu: Bool
  @State var shareSheet: Bool = false
  let content: DiaryContent
  
  var body: some View {
    ZStack {
      contentSection
      
      if showMenu {
        menuSection
          .transition(.move(edge: .bottom))
      }
    }
    .padding()
    .background(showMenu ? .gray.opacity(0.2) : .clear)
    .toolbar {
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
    .onChange(of: selectedContent) { newValue in
      withAnimation {
        showMenu.toggle()
      }
    }
  }
}

private extension DiaryDisplayView {
  var contentSection: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(content.title)
          .font(.system(size: 28, weight: .bold))
        
        Spacer()
        
        Button {
          withAnimation {
            showMenu.toggle()
          }
        } label: {
          Image(systemName: "ellipsis.circle")
            .font(.title)
        }
      }
      
      HStack {
        Text(content.body)
        
        Spacer()
      }
      
      Spacer()
    }
  }
  
  var menuSection: some View {
    VStack {
      Spacer()
      
      HStack(spacing: 100) {
        Button {
          print("Tapped Edit")
        } label: {
          Image(systemName: "pencil")
        }
        
        Button {
          withAnimation {
            shareSheet = true
          }
        } label: {
          Image(systemName: "square.and.arrow.up")
        }
      }
      .font(.largeTitle)
      .padding(.horizontal, 100)
      .padding(.vertical)
      .background(Color.white)
      .cornerRadius(16)
      .popover(isPresented: $shareSheet) {
        ShareSheetView(text: content.title + "\n" + content.body)
      }
    }
  }
}
