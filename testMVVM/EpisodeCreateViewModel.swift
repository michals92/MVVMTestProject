//
//  EpisodeCreateViewModel.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 18.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import Foundation
import ReactiveSwift

class EpisodeCreateViewModel {

    enum EpisodeError: Error {
       case WrongName
    }

    fileprivate var seasonService: SeasonsAPIServicing
    fileprivate var season : Season

    var name: MutableProperty<String?> = MutableProperty(nil)

    init(season: Season, seasonService: SeasonsAPIServicing) {
        self.season = season
        self.seasonService = seasonService
    }

    func save() -> SignalProducer<Void, EpisodeError> {
        return SignalProducer { [unowned self] observer, _ in
            guard let name = self.name.value, name != "" else {
                observer.send(error: .WrongName)
                return
            }

            self.seasonService.create(episode: Episode(name: name), inSeason: self.season).start { createObserver in
                if let _ = createObserver.value {
                    observer.send(value: Void())
                }
            }
        }
    }
}
