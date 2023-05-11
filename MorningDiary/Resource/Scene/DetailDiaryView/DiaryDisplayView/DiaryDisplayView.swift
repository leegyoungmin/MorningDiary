//
//  DiaryDisplayView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DiaryDisplayView: View {
  @Binding var selectedContent: DiaryContent?
  @Binding var editMode: Bool
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
    .background(showMenu ? Color.black.opacity(0.1) : .white)
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
        showMenu = false
        editMode = false
      }
    }
  }
}

private extension DiaryDisplayView {
  func reset() {
    withAnimation {
      editMode = false
      showMenu = false
    }
  }
  
  var contentSection: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(content.title)
          .font(.system(size: 32, weight: .bold))

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
          reset()
        } label: {
          Image(systemName: "xmark")
        }

        Button {
          withAnimation {
            editMode = true
          }
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
        .popover(isPresented: $shareSheet) {
          ShareSheetView(text: content.title + "\n" + content.body)
        }
      }
      .font(.largeTitle)
      .padding(.horizontal, 100)
      .padding(.vertical)
      .background(Color.white)
      .cornerRadius(16)
    }
  }
}
