//
//  ImageDetailView.swift
//  FlickrSearchEngine
//
//  Created by Mairaj, Rija - The Intersect Group on 2/19/24.
//

import SwiftUI
import WebKit

struct ImageDetailView: View {
    var viewModel: FlickrImageViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .padding()
                })
                
            }
            
            ScrollView {
                Spacer()
                
                Image(uiImage: viewModel.image ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: UIScreen.main.bounds.size.height/2)
                    .background(Color.gray.opacity(0.3))
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top, spacing: 5) {
                        Header("Title")
                        Text(viewModel.title)
                    }
                    
                    HStack(alignment: .top, spacing: 5) {
                        Header("Description")
                        Text(viewModel.description)
                        //HTMLStringView(htmlContent: viewModel.description)
                            //.frame(height: 50)
                    }
                    
                    HStack(alignment: .top, spacing: 5) {
                        Header("Author")
                        Text(viewModel.author)
                    }
                    
                    HStack(alignment: .top, spacing: 5) {
                        Header("Publishing Date")
                        Text(viewModel.publishDate)
                    }
                }
                .padding(16)
            }
        }
    }
}

fileprivate struct Header: View {
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack {
            Text("\(title):")
                .fontWeight(.bold)
            Spacer()
        }
        .frame(width: 150)
    }
}
