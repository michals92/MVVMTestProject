//
//  Model.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 12.09.16.
//  Copyright © 2016 The Funtasty. All rights reserved.
//

import Foundation
import ReactiveSwift

class Season {

    var name: MutableProperty<String>
    var episodes: MutableProperty<[Episode]>

    init(name: String, episodes: [Episode]) {
        self.name = MutableProperty(name)
        self.episodes = MutableProperty(episodes)
    }
}

class Episode {

    var id: String?
    var name: MutableProperty<String?>
    var played: Bool = false

    init(name: String) {
        self.name = MutableProperty(name)
    }

    init(withId id: String) {
        self.id = id
        self.name = MutableProperty(nil)
    }

}
