//
//  Application + Extensions.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import UIKit

extension UIApplication {
  static func endEditing() {
    UIApplication.shared.sendAction(
      #selector(UIResponder.resignFirstResponder),
      to: nil,
      from: nil,
      for: nil
    )
  }
}
