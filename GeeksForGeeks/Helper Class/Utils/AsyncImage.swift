//
//  AsyncImage.swift
//  GeeksForGeeks
//
//  Created by vikash sahu on 12/05/22.
//

import SwiftUI

struct AsyncImage : View{
    @StateObject private var imageLoader = ImageLoader()
    var url:String
    
    init(url:String) {
        self.url = url
    }
    
    var body: some View{
        ImageView(image: imageLoader.image)
            .onAppear{
            imageLoader.load(fromUrl: url)
        }
    }
}

struct ImageView : View{
     var image : Image?
     var body: some View{
        VStack{
            image?.resizable() ?? Image("placeholder_image").resizable()
        }
    }
}
class ImageLoader:ObservableObject{
    @Published var image : Image? = nil
    func load(fromUrl url:String){
        APIService.shared.downloadImage(from: url) { uiImage in
            DispatchQueue.main.async {
                guard let image = uiImage else{return}
                self.image = Image(uiImage:image)
            }
        }
    }
}
