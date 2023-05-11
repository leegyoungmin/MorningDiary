//
//  EnvironmentStore.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct BackgroundColor: EnvironmentKey {
  static var defaultValue: Color = Color(.secondarySystemBackground)
}

struct CornerRadius: EnvironmentKey {
  static var defaultValue: CGFloat = 16
}

extension EnvironmentValues {
  var backgroundColor: Color {
    get { self[BackgroundColor.self] }
    set { self[BackgroundColor.self] = newValue }
  }
  
  var cornerRadius: CGFloat {
    get { self[CornerRadius.self] }
    set { self[CornerRadius.self] = newValue }
  }
}
