//
//  CalendarAnimeView.swift
//  AniHyou
//
//  Created by Axel Lopez on 07/01/2023.
//

import SwiftUI

struct CalendarAnimeView: View {
    
    @State var weekday = Date.now.weekday
    
    var body: some View {
        VStack {
            Picker("Weekday", selection: $weekday) {
                Text("M").tag(2)
                Text("T").tag(3)
                Text("W").tag(4)
                Text("T").tag(5)
                Text("F").tag(6)
                Text("S").tag(7)
                Text("S").tag(1)
            }
            .pickerStyle(.segmented)
            .padding()
            
            Spacer()
            ScrollView(.vertical) {
                WeekAnimeListView(weekday: weekday)
            }
        }
        .navigationBarTitle("Calendar")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WeekAnimeListView: View {
    
    var weekday: Int
    @StateObject private var viewModel = CalendarViewModel()
    
    private let gridColumns = [
        GridItem(.adaptive(minimum: VListItemView.coverWidth + 15))
    ]
    
    var body: some View {
        LazyVGrid(columns: gridColumns) {
            ForEach(viewModel.weeklyAnimes, id: \.?.media?.id) {
                if let media = $0?.media {
                    NavigationLink(destination: MediaDetailsView(mediaId: media.id)) {
                        VListItemView(title: media.title?.userPreferred ?? "", imageUrl: media.coverImage?.large)
                    }
                }
            }
            
            if viewModel.hasNextPage {
                ProgressView()
                    .onAppear {
                        viewModel.getAiringAnimes(weekday: weekday)
                    }
            }
        }
        .onChange(of: weekday) { day in
            viewModel.getAiringAnimes(weekday: day, resetPage: true)
        }
    }
}

struct CalendarAnimeView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarAnimeView()
    }
}
