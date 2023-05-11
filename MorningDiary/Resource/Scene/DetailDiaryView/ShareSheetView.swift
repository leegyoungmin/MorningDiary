//
//  ShareSheetView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct ShareSheetView: UIViewControllerRepresentable {
  let text: String
  
  func makeUIViewController(context: Context) -> UIActivityViewController {
    let controller = UIActivityViewController(activityItems: [text], applicationActivities: nil)
    return controller
  }
  
  func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) { }
}
