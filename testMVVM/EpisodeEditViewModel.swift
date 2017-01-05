//
//  EpisodeEditViewModel.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 19.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import Foundation
import ReactiveSwift

class EpisodeEditViewModel {

    enum EpisodeEditViewModelError: Error {
        case NothingToUpdate
    }

    fileprivate var model: Episode
    fileprivate let service: SeasonsAPIServicing!

    var newTitle: String? {
        didSet {
            isSomethingToUpdate.value = true
        }
    }

    let isSomethingToUpdate = MutableProperty(false)

    init(id: String, service: SeasonsAPIServicing) {
        model = Episode(withId: id)
        self.service = service
    }

    init(model: Episode, service: SeasonsAPIServicing) {
        self.model = model
        self.service = service
    }

    func save() -> SignalProducer<Episode, EpisodeEditViewModelError> {

        return SignalProducer { [unowned self] observer, _ in
            if !self.isSomethingToUpdate.value {
                observer.send(error: .NothingToUpdate)
            }

            self.service.update(episode: self.model, name: self.newTitle).start { createObserver in
                if let episode = createObserver.value {
                    observer.send(value: episode)
                }
            }
        }
    }
}
