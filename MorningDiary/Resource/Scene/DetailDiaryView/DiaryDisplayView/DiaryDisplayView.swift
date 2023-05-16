//
//  DiaryDisplayView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import CoreData

struct DiaryDisplayView: View {
  @Binding var selectedContent: DiaryContent?
  @Binding var editMode: Bool
  @Binding var showMenu: Bool
  @State var shareSheet: Bool = false
  let content: DiaryContent
  
  @State private var images: [ImageData] = []
  
  init(selectedContent: Binding<DiaryContent?>, editMode: Binding<Bool>, showMenu: Binding<Bool>) {
    _selectedContent = selectedContent
    _editMode = editMode
    _showMenu = showMenu
    
    if let content = selectedContent.wrappedValue {
      self.content = content
      _images = State(initialValue: content.imageData.allObjects as? [ImageData] ?? [])
    } else {
      self.content = DiaryContent()
    }
  }
  
  var body: some View {
    ZStack {
      ScrollView {
        contentSection
      }
      
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
      reset()
      
      if let content = newValue {
        self._images.wrappedValue = content.imageData.allObjects as? [ImageData] ?? []
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
    VStack(alignment: .leading, spacing: 20) {
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
      // TODO: - Grid View 사용하여서 이미지 뷰 구성하기
      
      Text(content.body)
        .font(.system(size: 24))
      
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
