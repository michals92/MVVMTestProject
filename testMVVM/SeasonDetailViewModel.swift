//
//  SeasonDetailViewModel.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 12.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation
import ReactiveSwift

class SeasonDetailViewModel {
    
    fileprivate var model : Season
    fileprivate var service: SeasonsAPIServicing

    let title: MutableProperty<String> = MutableProperty("")
    fileprivate var episodes : MutableProperty<[EpisodeDetailViewModel]> = MutableProperty([])
    
    init(model: Season, seasonServices: SeasonsAPIServicing) {
        self.model = model
        self.service = seasonServices
        configure()
    }
    
    func configure() {
        title <~ model.name
        episodes <~ model.episodes.map{ episodes in
            var episodesViewModel: [EpisodeDetailViewModel] = []
            for episode in episodes {
                episodesViewModel.append(EpisodeDetailViewModel(model: episode))
            }
            return episodesViewModel
        }
    }
    
    func numberOfEpisodes() -> Int {
        return episodes.value.count
    }
    
    func getEpisode(_ indexPath: IndexPath) -> EpisodeDetailViewModel {
        return episodes.value[(indexPath as NSIndexPath).row]
    }

    func playEpisode(_ indexPath: IndexPath) {
        episodes.value[(indexPath as NSIndexPath).row].play()
        print("playing \(episodes.value[(indexPath as NSIndexPath).row].title)")
    }
    
    func stopPlayingEpisode(_ indexPath: IndexPath) {
        episodes.value[(indexPath as NSIndexPath).row].stop()
        print("stop playing \(episodes.value[(indexPath as NSIndexPath).row].title) played \(episodes.value[(indexPath as NSIndexPath).row].played)")
    }

    func setTitle(title: String) {
        self.title.value = title
        self.model.name.value = title
    }
}

extension EpisodeCreateViewModel {

    convenience init(seasonDetailViewModel: SeasonDetailViewModel) {
        self.init(season: seasonDetailViewModel.model, seasonService: TestSeasonsService())
    }
}
