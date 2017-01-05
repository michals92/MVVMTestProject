//
//  EpisodeCreateViewController.swift
//  MVVMTestProject
//
//  Created by Martin Pinka on 18.09.16.
//  Copyright © 2016 Martin Pinka. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa

class EpisodeCreateViewController: UIViewController {

    var viewModel: EpisodeCreateViewModel!

    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.name <~ nameTextField.reactive.continuousTextValues
    }

    @IBAction func save() {
        _ = viewModel.save().start { [unowned self] event in
            if let error = event.error {
                print(error)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
