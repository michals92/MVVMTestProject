//
//  SeasonService.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 09.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation
import ReactiveSwift

public enum MyError: Error {
    case noConnection
    case error(withMessage: String)
}


protocol SeasonsAPIServicing {
    var seasons: SignalProducer<[Season], MyError> { get }
    func create(episode: Episode, inSeason season: Season) -> SignalProducer<Episode, MyError>
    func update(episode: Episode, name: String?) -> SignalProducer<Episode, MyError>
}

class TestSeasonsService: SeasonsAPIServicing {
    
    let seasons = SignalProducer<[Season], MyError> { observer, _ in
        observer.send(value: [Season(name: "season 1", episodes: [Episode(name:"aa"), Episode(name:"ab")])])
        observer.sendCompleted()
    }
    
    func create(episode: Episode, inSeason season: Season) -> SignalProducer<Episode, MyError> {
        return SignalProducer { observer, _ in
            season.episodes.value.append(episode)
            observer.send(value: episode)
            observer.sendCompleted()
        }
    }
    
    func update(episode: Episode, name: String?) -> SignalProducer<Episode, MyError> {
        return SignalProducer { observer, _ in
            episode.name.value = name
            observer.send(value: episode)
            observer.sendCompleted()
        }
    }
}
