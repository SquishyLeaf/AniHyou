//
//  MediaListItem.swift
//  AniHyou
//
//  Created by Axel Lopez on 18/6/22.
//

import SwiftUI

private let coverWidth: CGFloat = 73
private let coverHeight: CGFloat = 110

struct MediaListItemView: View {
    
    var item: UserMediaListQuery.Data.Page.MediaList
    @ObservedObject var viewModel: MediaListViewModel
    @State var progress: Int?
    
    var body: some View {
        HStack {
            MediaCoverView(imageUrl: item.media?.coverImage?.large, width: coverWidth, height: coverHeight, cancelOnDisappear: true)
            
            VStack(alignment: .leading) {
                Text(item.media?.title?.userPreferred ?? "")
                    .lineLimit(2)
                
                Spacer()
                
                Text("\(item.progress ?? 0)/\(totalProgress ?? 0)")
                ProgressView(value: Float(item.progress ?? 0), total: Float(totalProgress ?? Int.max))
            }
        }
        .frame(height: coverHeight)
        .padding(.top, 8)
        .padding(.bottom, 8)
        .onChange(of: viewModel.updatedEntryId) { id in
            //since the property change in the object cannot be observed
            //and the apollo object is inmutable
            //it is neccesary to update it manually with an aux variable
            if id == item.id {
                progress = viewModel.updatedProgress ?? 0
            }
        }
        .onAppear {
            if progress == nil {
                progress = item.progress
            }
        }
    }
    
    var totalProgress: Int? {
        if item.media?.type == .anime {
            return item.media?.episodes
        } else {
            return item.media?.chapters
        }
    }
}

struct MediaListItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        MediaListItemView(item: UserMediaListQuery.Data.Page.MediaList(id: 1, mediaId: 1), viewModel: MediaListViewModel())
            .previewLayout(.sizeThatFits)
    }
}
