//
//  FullImageView.swift
//  AniHyou
//
//  Created by Axel Lopez on 4/7/22.
//

import SwiftUI
import Kingfisher

struct FullCoverView: View {
    
    var imageUrl: String?
    @Environment(\.dismiss) private var dismiss
    @State private var screenWidth = UIScreen.main.bounds.width - 100
    @State private var screenHeight = UIScreen.main.bounds.height - 180
    
    var body: some View {
        NavigationView {
            VStack {
                KFImage(URL(string: imageUrl ?? ""))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .scaleFactor(1)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
            }//:VStack
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .navigationViewStyle(.stack)
            .navigationBarTitleDisplayMode(.inline)
        }//:NavigationView
    }
}

struct FullImageView_Previews: PreviewProvider {
    static var previews: some View {
        FullCoverView(imageUrl: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx1-CXtrrkMpJ8Zq.png")
    }
}
