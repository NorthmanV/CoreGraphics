//
//  ViewController.swift
//  WaterBalance
//
//  Created by Ruslan Akberov on 24/10/2018.
//  Copyright © 2018 Ruslan Akberov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var weekdaysStackView: UIStackView!
    @IBOutlet weak var medalView: MedalView!
    
    var isGraphViewShowing = false
    
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
        if isGraphViewShowing {
            containerViewTap(nil)
        }
        checkTotal()
    }
    
    @IBAction func containerViewTap(_ sender: UITapGestureRecognizer?) {
        if isGraphViewShowing  {
            UIView.transition(from: graphView, to: counterView, duration: 1.0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else {
            setupGraphDisplay()
            UIView.transition(from: counterView, to: graphView, duration: 1.0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
    }
    
    func setupGraphDisplay() {
        
        // set max label
        graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter
        graphView.setNeedsDisplay()
        maxLabel.text = "\(graphView.graphPoints.max()!)"
        
        // set average label
        let average = graphView.graphPoints.reduce(0, +) / graphView.graphPoints.count
        averageLabel.text = "Average: \(average)"
        
        // set weekdays labels depending on current day
        let today = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("E")
        let maxDayIndex = weekdaysStackView.arrangedSubviews.count - 1
        for i in 0...maxDayIndex {
            if let date = calendar.date(byAdding: .day, value: -i, to: today), let label = weekdaysStackView.arrangedSubviews[maxDayIndex - i] as? UILabel {
                label.text = String(formatter.string(from: date).prefix(1))
            }
        }
    }
    
    func checkTotal() {
        if counterView.counter >= 8 {
            medalView.showMedal(true)
        } else {
            medalView.showMedal(false)
        }
    }
    
}

