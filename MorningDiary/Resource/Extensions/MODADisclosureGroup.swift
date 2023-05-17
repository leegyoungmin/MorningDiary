//
//  PlainDisclosureGroup.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct MODADisclosureGroup<Label: View, Content: View>: View {
  @State private var isExpended: Bool = true
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
