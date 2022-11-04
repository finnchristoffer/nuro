//
//  CreateActivityViewController+Delegate.swift
//  Nuro
//
//  Created by Gregorius Albert on 31/10/22.
//

import UIKit

extension CreateActivityViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        
        if text.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
        return true
    }
    
}

extension CreateActivityViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == Colors.Neutral.bronze {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Ketik kalimat reward singkat untuk anak saat menyelesaikan aktivitas..."
            textView.textColor = Colors.Neutral.bronze
        }
    }
    
}

extension CreateActivityViewController: CreateActivityDelegate {
    func pushViewController(dest: UIImagePickerController, type:UIImagePickerController.SourceType) {
        dest.sourceType = type
        dest.delegate = self
        present(dest, animated: true)
    }
    
    func pushSelectorAlert() {
        let alert = UIAlertController(title: "Masukkan Gambar", message: "Pilih cara memasukkan gambar", preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: "Ambil Foto",
            style: .default,
            handler: { _ in
                self.pushViewController(dest: UIImagePickerController(), type: .camera)
            }
        ))
        
        alert.addAction(UIAlertAction(
            title: "Pilih Foto",
            style: .default,
            handler: { _ in
                self.pushViewController(dest: UIImagePickerController(), type: .photoLibrary)
            }
        ))
        
        alert.addAction(UIAlertAction(
            title: "Batalkan",
            style: .cancel,
            handler: nil
        ))
        
        present(alert, animated: true)
        
    }
    
    func dismissViewController() {
        self.dismiss(animated: true)
    }
    
    func saveActivity() {
        
        ActivityLocalRepository.shared.add(
            name: createActivityView.nameTextField.text ?? "",
            desc: createActivityView.descTextArea.text ?? "",
            imageURL: Document.saveToDocument(image: createActivityView.selectImageSelector.imageView.image),
            to: category ?? Category()
        )
        delegate.reloadData()
        dismissViewController()
    }
    
}

extension CreateActivityViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
//        createActivityView.selectImageSelector.backgroundColor = UIColor(patternImage: image)
        createActivityView.selectImageSelector.imageView.image = image
        
        createActivityView.selectImageSelector.stackView.removeFromSuperview()
    }
}
