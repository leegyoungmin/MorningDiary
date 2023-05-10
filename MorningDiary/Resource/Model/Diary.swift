//
//  Diary.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation

struct Diary: Identifiable, Hashable {
  let id = UUID()
  let createdDate: Date
  let contents: [DiaryContent]
}

struct DiaryContent: Identifiable, Hashable {
  let id = UUID()
  let title: String
  let body: String
  let images: [String]
}

extension Diary {
  static let mockDiary: [Diary] = [
    .init(
      createdDate: Date().addingTimeInterval(-100000000),
      contents: [
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
      ]
    ),
    .init(
      createdDate: Date(),
      contents: [
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
      ]
    ),
    .init(
      createdDate: Date().addingTimeInterval(100000000),
      contents: [
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
        .init(title: "Example1", body: "Example", images: []),
      ]
    ),
  ]
}

extension Date {
  func description(with format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    
    return formatter.string(from: self)
  }
}
