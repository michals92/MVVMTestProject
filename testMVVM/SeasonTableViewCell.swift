//
//  SeasonTableViewCell.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 15.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa
import ReactiveSwift

class ObservingTableViewCell: UITableViewCell {

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension ObservingTableViewCell {

    func configure(_ viewModel: SeasonDetailViewModel) {

        if let label = textLabel {
            label.reactive.text <~ viewModel.title
        }
    }
}

extension ObservingTableViewCell {

    func configure(_ viewModel: EpisodeDetailViewModel) {
        if let label = textLabel {
            label.reactive.text <~ viewModel.title
        }
    }
}
