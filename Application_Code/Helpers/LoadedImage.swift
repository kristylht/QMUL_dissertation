//
//  LoadedImage.swift
//  DietFitFinal
//
//  Created by Kristy on 13/7/2023.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseStorage

struct LoadedImage: View {
    @State public var url = ""
    public var recordImage: String
    private func loadImageURL() {
            let storage = Storage.storage().reference()
            storage.child(recordImage).downloadURL { url, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.url = url!.absoluteString
                }
            }
        }
    
    var body: some View {
        HStack{
            if url != "" {
                AnimatedImage(url: URL(string:url)!)
                    .resizable()
                    .scaledToFit()
            } else {
                Loader()
            }
        }.onAppear{
            loadImageURL()
            }
    }
}

struct LoadedImage_Previews: PreviewProvider {
    static var previews: some View {
        LoadedImage(recordImage:  "3_4_Sit_Up0.jpg")
    }
}

struct Loader : UIViewRepresentable {
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loader>) {
        
    }
    
    func makeUIView(context: UIViewRepresentableContext<Loader>) -> UIActivityIndicatorView{
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
}

