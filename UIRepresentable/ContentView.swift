//
//  ContentView.swift
//  UIRepresentable
//
//  Created by Дмитрий Спичаков on 10.11.2022.
//

import SwiftUI
import UIKit

// Convert a UIView from UIKit to SwiftUI
struct ContentView: View {
    
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Text(text)
            
            //            BasicUIViewRepresentable()
            
            TextField("Type here..", text: $text)
                .frame(height: 55)
                .background(.gray)
            
            UITextFieldViewRepresentable(text: $text,
                                         placeholder: "New placeholder",
                                         placeholderColor: .blue)
                .frame(height: 55)
                .background(.gray)
            
            UITextFieldViewRepresentable(text: $text)
                .updatePlaceholder("One more placeholder")
                .frame(height: 55)
                .background(.gray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    let placeholderColor: UIColor
    
    init(text: Binding<String>, placeholder: String = "Default placeholder...", placeholderColor: UIColor = .red) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    // from UIKit to SwiftUI
    //    func makeUIView(context: Context) -> some UIView {
    
    func makeUIView(context: Context) -> UITextField {
        
        //        let textField = UITextField(frame: .zero)
        //
        //        let placeholder = NSAttributedString(
        //            string: "Type here...",
        //            attributes: [
        //                .foregroundColor: UIColor.red
        //            ])
        //
        //        textField.attributedPlaceholder = placeholder
        //        return textField
        
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    // from SwiftUI to UIKit
    
    //    func updateUIView(_ uiView: UIViewType, context: Context) {
    //
    //    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    
    
    private func getTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        
        let placeholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: placeholderColor
            ])
        
        textField.attributedPlaceholder = placeholder
        //        textField.delegate
        return textField
    }
    
    func updatePlaceholder(_ text: String) -> UITextFieldViewRepresentable {
        var viewRepresentable = self
        viewRepresentable.placeholder = text
        return viewRepresentable
    }
    
    // From UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
    
}

//struct BasicUIViewRepresentable: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> some UIView {
//        let view = UIView()
//        view.backgroundColor = .red
//        return view
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//
//    }
//}
