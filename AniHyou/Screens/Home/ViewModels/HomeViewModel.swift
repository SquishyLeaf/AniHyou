//
//  AnimesViewModel.swift
//  AniHyou
//
//  Created by Axel Lopez on 9/6/22.
//

import Foundation
import API

class HomeViewModel: ObservableObject {
    private let now = Date.now
    @Published var nowAnimeSeason = AnimeSeason(year: 2022, season: .spring)
    var nextAnimeSeason = AnimeSeason(year: 2022, season: .summer)
    
    init() {
        nowAnimeSeason = now.getCurrentAnimeSeason()
        nextAnimeSeason = now.getNextAnimeSeason()
    }
    
    // MARK: Airing animes
    @Published var airingAnimes = [AiringAnimesQuery.Data.Page.AiringSchedule?]()
    
    func getAiringAnimes(page: Int = 1) {
        let todayTimestamp = Int(Date.now.timeIntervalSince1970)
        
        Network.shared.apollo.fetch(query: AiringAnimesQuery(page: .some(page), perPage: .some(10), sort: .some([.case(.time)]), airingAtGreater: .some(todayTimestamp), airingAtLesser: .none)) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                if let page = graphQLResult.data?.page {
                    if let schedules = page.airingSchedules {
                        self?.airingAnimes = schedules
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: Season animes
    @Published var seasonAnimes = [SeasonalAnimeQuery.Data.Page.Medium?]()
    
    func getSeasonAnimes(page: Int = 1) {
        Network.shared.apollo.fetch(query: SeasonalAnimeQuery(page: .some(page), perPage: .some(10), season: .some(.case(nowAnimeSeason.season)), seasonYear: .some(nowAnimeSeason.year), sort: .some([.case(.popularityDesc)]))) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                if let page = graphQLResult.data?.page {
                    if let animes = page.media {
                        self?.seasonAnimes = animes
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: Trending animes
    @Published var trendingAnimes = [MediaSortedQuery.Data.Page.Medium?]()
    
    func getTrendingAnimes(page: Int = 1) {
        Network.shared.apollo.fetch(query: MediaSortedQuery(page: .some(page), perPage: .some(10), type: .some(.case(.anime)), sort: .some([.case(.trendingDesc)]))) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                if let page = graphQLResult.data?.page {
                    if let animes = page.media {
                        self?.trendingAnimes = animes
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: next season
    @Published var nextSeasonAnimes = [SeasonalAnimeQuery.Data.Page.Medium?]()
    
    func getNextSeasonAnimes(page: Int = 1) {
        Network.shared.apollo.fetch(query: SeasonalAnimeQuery(page: .some(page), perPage: .some(10), season: .some(.case(nextAnimeSeason.season)), seasonYear: .some(nextAnimeSeason.year), sort: .some([.case(.popularityDesc)]))) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                if let page = graphQLResult.data?.page {
                    if let animes = page.media {
                        self?.nextSeasonAnimes = animes
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: Trending manga
    @Published var trendingManga = [MediaSortedQuery.Data.Page.Medium?]()
    
    func getTrendingManga(page: Int = 1) {
        Network.shared.apollo.fetch(query: MediaSortedQuery(page: .some(page), perPage: .some(10), type: .some(.case(.manga)), sort: .some([.case(.trendingDesc)]))) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                if let page = graphQLResult.data?.page {
                    if let media = page.media {
                        self?.trendingManga = media
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
