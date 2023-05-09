//
//  Diary.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

struct Diary {
  let title: String
  let description: String
  let images: [String]
}

extension Diary {
  static let mockDiary: [Diary] = [
    .init(title: "이것은 1번 예시입니다.", description: "이것은 1번 예시이고, 이것은 본문입니다.", images: []),
    .init(title: "이것은 2번 예시입니다.", description: "이것은 2번 예시이고, 이것은 본문입니다.", images: []),
    .init(title: "이것은 3번 예시입니다.", description: "이것은 3번 예시이고, 이것은 본문입니다.", images: []),
    .init(title: "이것은 4번 예시입니다.", description: "이것은 4번 예시이고, 이것은 본문입니다.", images: [])
  ]
}
