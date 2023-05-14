//
//  DiaryEditView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DiaryEditView: View {
  @State var title: String = ""
  @State var description: String = ""
  @State var images: [String] = []
  
  @State private var showImagePicker: Bool = false
  @State private var selectedImage: [Photo] = []
  
  init(content: DiaryContent) {
    self._title = State(initialValue: content.title)
    self._description = State(initialValue: content.body)
    self._images = State(initialValue: content.images)
  }
  
  init() { }
  
  var body: some View {
    VStack(spacing: 20) {
      TextField("제목을 입력하세요", text: $title)
        .font(.system(size: 32, weight: .bold))
        .submitLabel(.next)
      
      TextEditor(text: $description)
      
      Spacer()
      
      HStack {
        ForEach(selectedImage, id: \.id) { photo in
          if let photo = photo {
            Image(uiImage: photo.image)
              .resizable()
              .scaledToFill()
              .frame(width: 80, height: 80)
              .clipShape(RoundedRectangle(cornerRadius: 12))
              .contextMenu {
                Button(role: .destructive) {
                  withAnimation {
                    selectedImage.removeAll(where: { $0.id == photo.id })
                  }
                } label: {
                  Label("삭제", systemImage: "trash")
                }
              }
            
          }
        }
        
        Spacer()
      }
      
      Divider()
      
      HStack {
        Button {
          withAnimation(.easeIn(duration: 0.1)) {
            UIApplication.endEditing()
            showImagePicker = true
          }
        } label: {
          Image(systemName: "photo.on.rectangle.angled")
        }
        .popover(isPresented: $showImagePicker) {
          ImagePicker(selectedImages: $selectedImage)
            .frame(maxWidth: 400)
        }
        
        Button {
          withAnimation(.easeIn(duration: 0.1)) {
            UIApplication.endEditing()
          }
          
          // TODO: - 지도 뷰 구현하기
        } label: {
          Image(systemName: "map")
        }

        Spacer()
      }
      .font(.title2)
    }
    .padding(.horizontal)
  }
}
