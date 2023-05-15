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
  
  var dateDescription: String {
    return createdDate.description(with: "yyyy년 MM월 dd일")
  }
}

struct DiaryContent: Identifiable, Hashable {
  let id = UUID()
  let title: String
  let body: String
  let createdDate: Date
  let images: [String]
}
