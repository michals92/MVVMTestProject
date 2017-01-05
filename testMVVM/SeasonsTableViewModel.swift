//
//  SeasonsTableViewModel.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 09.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation
import ReactiveSwift

class SeasonsTableViewModel {

    let seasonsServices : SeasonsAPIServicing
    let seasons: MutableProperty<[SeasonDetailViewModel]> = MutableProperty([])
    
    init(seasonsServices: SeasonsAPIServicing) {
        self.seasonsServices = seasonsServices
    }

    @discardableResult
    func load() -> SignalProducer<[SeasonDetailViewModel], MyError>  {

        return SignalProducer { observer, _ in
            var seasonsViewModel: [SeasonDetailViewModel] = []

            self.seasonsServices.seasons.start { seasons in
                if let seasonsValue = seasons.value {
                    for season in seasonsValue {
                        seasonsViewModel.append(SeasonDetailViewModel(model: season, seasonServices: self.seasonsServices))
                    }
                    self.seasons.value = seasonsViewModel
                    observer.send(value: seasonsViewModel)
                    observer.sendCompleted()
                }
            }
        }
    }

    func seasonForIndexPath(_ indexPath: IndexPath) -> SeasonDetailViewModel {

        return seasons.value[indexPath.row]
    }
    
    func numberOfSeasons() -> Int {
        return seasons.value.count
    }
}
