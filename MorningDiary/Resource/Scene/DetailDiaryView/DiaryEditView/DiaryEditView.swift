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
  @State private var showCamera: Bool = false
  @State private var selectedImage: [Photo] = []
  
  @State private var showErrorAlert: Bool = false
  @State private var errorState: EditError? = nil {
    willSet {
      if newValue != nil {
        showErrorAlert = true
      }
    }
  }
  
  init(selectedDiary: Binding<DiaryContent?>) {
    _selectedDiary = selectedDiary
    
    if let diary = selectedDiary.wrappedValue {
      _title = State(initialValue: diary.title)
      _description = State(initialValue: diary.body)
    }
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
          withAnimation {
            UIApplication.endEditing()
            showCamera = true
          }
        } label: {
          Image(systemName: "camera")
        }
        
        Button {
          withAnimation(.easeIn(duration: 0.1)) {
            UIApplication.endEditing()
            showImagePicker = true
          }
        } label: {
          Image(systemName: "photo.on.rectangle.angled")
        }
        .popover(isPresented: $showImagePicker) {
          ImagePickerView(selectedImages: $selectedImage, isCamera: false)
            .frame(maxWidth: 400)
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
          }
        } label: {
          Image(systemName: "checkmark")
            .font(.title3)
        }
      }
    }
    .alert(isPresented: $showErrorAlert, error: errorState) { }
    .sheet(isPresented: $showCamera) {
      ImagePickerView(selectedImages: $selectedImage, isCamera: true)
    }
  }
}

private extension DiaryEditView {
  enum EditError: String, Error, LocalizedError {
    case emptyTitle = "제목 오류"
    case emptyDescription = "본문 오류"
    
    var errorDescription: String? {
      switch self {
      case .emptyTitle:
        return "제목이 비어있습니다."
        
      case .emptyDescription:
        return "본문이 비어있습니다."
      }
    }
  }
  
  func validate() -> Bool {
    guard title.trimmingCharacters(in: .whitespaces).isEmpty == false else {
      self.errorState = .emptyTitle
      return false
    }
    
    guard description.trimmingCharacters(in: .whitespaces).isEmpty == false else {
      self.errorState = .emptyDescription
      return false
    }
    
    return true
  }
  
  func resetState() {
    self.title = ""
    self.description = ""
    self.images = []
    self.selectedDiary = nil
  }
  
  func updateContent(with content: DiaryContent) {
    content.title = title
    content.body = description
    content.issuedDate = Date().description(with: "yyyy년 MM월 dd일")
    
    var imageDatas: [ImageData] = []
    
    selectedImage.enumerated().map { values in
      return (values.offset, values.element.image.pngData())
    }.forEach { offset, image in
      guard let image = image else { return }
      let imageData = ImageData(context: context)
      imageData.data = image
      
      imageDatas.append(imageData)
      imageData.addToAttachment(content)
      content.addToImageData(imageData)
    }
    
    try? context.save()
    
    resetState()
  }
  
  func saveContent() {
    guard validate() else {
      return
    }
    
    if let content = selectedDiary {
      updateContent(with: content)
      return
    }
    
    let content = DiaryContent(context: context)
    content.id = UUID()
    content.createdDate = Date().description(with: "yyyy년 MM월 dd일")
    updateContent(with: content)
  }
}
