//
//  DiaryEditView.swift
//  MorningDiary
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct DiaryEditView: View {
  @Environment(\.managedObjectContext) var context
  @Binding var selectedDiary: DiaryContent?
  @State var title: String = ""
  @State var description: String = ""
  @State var images: [String] = []
  
  @State private var showImagePicker: Bool = false
  @State private var selectedImage: [Photo] = []
  
  init(selectedDiary: Binding<DiaryContent?>) {
    _selectedDiary = selectedDiary
    
    if let diary = selectedDiary.wrappedValue {
      _title = State(initialValue: diary.title)
      _description = State(initialValue: diary.body)
    }
  }
  
  func updateContent(with content: DiaryContent) {
    content.title = title
    content.body = description
    content.issuedDate = Date().description(with: "yyyy년 MM월 dd일")
    try? context.save()
  }
  
  func saveContent() {
    if let content = selectedDiary {
      updateContent(with: content)
      return
    }
    
    let content = DiaryContent(context: context)
    content.id = UUID()
    content.createdDate = Date().description(with: "yyyy년 MM월 dd일")
    updateContent(with: content)
  }
  
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
              .transition(.opacity.animation(.easeIn))
              .frame(width: 80, height: 80)
              .clipShape(RoundedRectangle(cornerRadius: 12))
              .contextMenu {
                Button(role: .destructive) {
                  selectedImage.removeAll(where: { $0.id == photo.id })
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
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          withAnimation {
            saveContent()
            selectedDiary = nil
          }
        } label: {
          Image(systemName: "checkmark")
            .font(.title3)
        }
      }
    }
  }
}
