//
//  FlickrImageView.swift
//  FlickrSearchEngine
//
//  Created by Mairaj, Rija - The Intersect Group on 2/20/24.
//

import SwiftUI

struct FlickrImageView: View {
    let viewModel: FlickrImageViewModel
    @State var flickrImage: UIImage?
    @State var showImageDetail = false
    
    var body: some View {
        Image(uiImage: flickrImage ?? UIImage())
            .resizable()
            .background(Color.gray)
            .onAppear() {
                guard let imageUrl = viewModel.imageURL else { return }
                NetworkManager.shared.downloadImage(from: imageUrl, completion: { image in
                    self.flickrImage = image
                    viewModel.image = image
                })
            }
            .onTapGesture {
                showImageDetail = true
            }
            .fullScreenCover(isPresented: $showImageDetail, content: {
                ImageDetailView(viewModel: viewModel)
            })
    }
}
