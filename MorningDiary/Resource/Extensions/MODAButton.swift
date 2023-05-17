//
//  MODAButton.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct MODAButton<Label: View>: View {
  let action: () -> Void
  let label: () -> Label
  
  init(_ action: @escaping () -> Void, label: @escaping () -> Label) {
    self.action = action
    self.label = label
  }
  
  var body: some View {
    HStack {
      label()
      
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .contentShape(RoundedRectangle(cornerRadius: 10))
    .onTapGesture {
      withAnimation {
        action()
      }
    }
  }
}
