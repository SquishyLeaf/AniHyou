//
//  OverviewStatsView.swift
//  AniHyou
//
//  Created by Axel Lopez on 02/03/2023.
//

import SwiftUI
import API

struct OverviewStatsView: View {
    
    var userId: Int
    var mediaType: MediaType
    @StateObject private var viewModel = OverviewStatsViewModel()
    @State private var scoreStatType = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.isLoading {
                ProgressView()
                Spacer()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack {
                        Divider()
                        if mediaType == .anime && viewModel.animeStats != nil {
                            mainAnimeStats
                        }
                        Divider()
                    }//:VStack
                    .padding(.horizontal)
                    .frame(height: 75)
                }//:HScrollView
                
                Text("Score distribution")
                    .font(.title3)
                    .padding(.horizontal)
                    .padding(.top)
                Picker("Score", selection: $scoreStatType) {
                    Text("Titles Count").tag(0)
                    if mediaType == .anime {
                        Text("Hours Watched").tag(1)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                VerticalBarsStatsView(stats: scoreStatType == 0 ? viewModel.scoreStatsCount : viewModel.scoreStatsTime)
                
                Text("Format distribution")
                    .font(.title3)
                    .padding(.horizontal)
                    .padding(.top)
                HorizontalBarStatsView(stats: viewModel.formatsDistribution)
                
                Text("Status distribution")
                    .font(.title3)
                    .padding(.horizontal)
                    .padding(.top)
                HorizontalBarStatsView(stats: viewModel.statusDistribution)
            }
        }
        .onAppear {
            if mediaType == .anime {
                if viewModel.animeStats == nil {
                    viewModel.getAnimeOverview(userId: userId)
                }
            } else {
                
            }
        }
    }
    
    private var mainAnimeStats: some View {
        HStack {
            MediaStatView(name: "Total Anime", value: String(viewModel.animeStats!.count))
            MediaStatView(name: "Episodes Watched", value: String(viewModel.animeStats!.episodesWatched))
            MediaStatView(name: "Days Watched", value: String(format: "%.2f", viewModel.animeStats!.minutesWatched.minutesToDays()))
            MediaStatView(name: "Mean Score", value: String(format: "%.2f", viewModel.animeStats!.meanScore), showDivider: false)
        }
    }
}

struct OverviewStatsView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewStatsView(userId: 208863, mediaType: .anime)
    }
}
