//
//  ImagePicker.swift
//  JCDev
//
//  Created by Mia Mawby on 5/5/2023.
//

import Foundation
import UIKit
import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Binding var isPickerShowing: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

class Coordinator: NSObject, PHPickerViewControllerDelegate {
    
    var parent: ImagePicker
    
    init(_ picker: ImagePicker) {
        self.parent = picker
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        parent.isPickerShowing = false
        
        guard let itemProvider = results.first?.itemProvider else {
            return
        }
        
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let self = self,
                      error == nil,
                      let image = image as? UIImage else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.parent.selectedImage = image
                }
            }
        }
    }
    
    func pickerDidCancel(_ picker: PHPickerViewController) {
        // Does something when the picker is canceled
        print("Cancelled")
        parent.isPickerShowing = false
    }
}

