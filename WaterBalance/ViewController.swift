//
//  ViewController.swift
//  WaterBalance
//
//  Created by Ruslan Akberov on 24/10/2018.
//  Copyright © 2018 Ruslan Akberov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pushButtonPressed(_ sender: PushButton) {
        if sender.isAddButton {
            counterView.counter += 1
        } else {
            if counterView.counter > 0 {
                counterView.counter -= 1
            }
        }
        counterLabel.text = String(counterView.counter)
    }
    
}

