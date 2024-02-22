//
//  SearchScreen.swift
//  FlickrSearchEngine
//
//  Created by Mairaj, Rija - The Intersect Group on 2/19/24.
//

import SwiftUI

struct SearchScreen: View {
    @ObservedObject var viewModel = SearchScreenViewModel()
    @State var showImageDetail = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationView {
                VStack {
                    if viewModel.apiInProgress {
                        createProgressView()
                    }
                    
                    if !viewModel.flickrImageList.isEmpty {
                        createImageGridView()
                    } else {
                        createErrorView()
                    }
                }
                .navigationTitle("Search flickr")
                .navigationBarTitleDisplayMode(.inline)
            }
            .searchable(text: $viewModel.searchText)
            .disableAutocorrection(true)
            .onChange(of: viewModel.searchText) { _ in
                let text = viewModel.trimSearchText(viewModel.searchText)
                viewModel.searchText = text
                viewModel.getFlickerImagesForSearchedText()
            }
            .onAppear() {
                viewModel.getFlickerImagesForSearchedText()
            }
        }
    }
    
    func createProgressView() -> some View {
        HStack() {
            Text("Updating search.....")
                .font(.subheadline)
            ProgressView()
        }
        .frame(maxWidth: .infinity)
    }
    
    func createImageGridView() -> some View {
        VStack {
            Spacer(minLength: 50)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 150), spacing: 5)], spacing: 5) {
                    ForEach(viewModel.flickrImageList, id: \.self) { item in
                        let flickrImageVM = FlickrImageViewModel(flickrImageData: item)
                        FlickrImageView(viewModel: flickrImageVM)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    func createErrorView() -> some View {
        VStack {
            Spacer()
            Text(viewModel.errorState?.getCopy() ?? "")
            Spacer()
        }
    }
}
