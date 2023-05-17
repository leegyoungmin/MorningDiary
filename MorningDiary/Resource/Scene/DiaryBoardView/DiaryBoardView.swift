//
//  DiaryBoardView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DiaryBoardView: View {
  // TODO: - Diary Data 읽어오기
  @State private var selectedContent: DiaryContent?
  
  @ViewBuilder
  func listItemButton(with item: String) -> some View {
    Button {
      print("Tapped")
    } label: {
      HStack {
        Label("Example", systemImage: "person.circle")
        
        Spacer()
      }
      .font(.title3)
      .foregroundColor(.white)
      .padding(12)
      .background(Color.red)
      .cornerRadius(10)
    }
    .buttonStyle(.borderless)
  }
  
  var body: some View {
    NavigationView {
      List {
        PlainDisclosureGroup {
          Text("Example")
            .font(.system(size: 32, weight: .bold))
        } content: {
          ForEach(1..<19) {
            listItemButton(with: $0.description)
          }
        }
        .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
    }
  }
}

struct PlainDisclosureGroup<Label: View, Content: View>: View {
  @State private var isExpended: Bool = false
  let label: () -> Label
  let content: () -> Content
  
  init(
    label: @escaping () -> Label,
    content: @escaping () -> Content
  ) {
    self.label = label
    self.content = content
  }
  
  var body: some View {
    HStack {
      label()
      Spacer()
      Image(systemName: "chevron.right")
        .rotationEffect(.degrees(isExpended ? 90 : .zero))
    }
    .contentShape(Rectangle())
    .onTapGesture {
      withAnimation {
        self.isExpended.toggle()
      }
    }
    
    if isExpended {
      content()
    }
  }
}

struct DiaryBoardView_Previews: PreviewProvider {
  static var previews: some View {
    DiaryBoardView()
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
