//
//  ViewController.swift
//  Shamaz
//
//  Created by Michael Gresham on 16/04/2020.
//  Copyright © 2020 Michael Gresham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Global variables and UI Outlets

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var reflectButton: UIButton!
    @IBOutlet weak var dreamButton: UIButton!
    @IBOutlet weak var numberOfPlayersLabel: UILabel!

    // Two arrays, one for past and one for future, start of the questions
    let pastPreText = ["What were you doing", "Where were you", "What was your favourite sport", "Where did you work", "What was your favourite book", "What were you wearing", "What were you eating", "What was your car"]
    let futurePreText = ["What will you be doing", "Where will you be", "Where do you want to work", "Where will you live", "Will you be in a relationship", "What will you drive"]

    var numberOfPlayers: Int?

    enum Timeframe: CaseIterable {
        case hours, days, weeks, months, years
    }

    // MARK: Button Actions

    @IBAction func reflectButtonPressed(_ sender: Any) {
        let question = generateQuestion(isTheFuture: false)
        questionLabel.text = question
    }

    @IBAction func dreamButtonPressed(_ sender: Any) {
        let question = generateQuestion(isTheFuture: true)
        questionLabel.text = question
    }

    @IBAction func minusButtonPressed(_ sender: Any) {
        //Allows users to descrease the number of players to a minumum of 2
        if numberOfPlayers! > 2 {
            numberOfPlayers! -= 1
            updateNumberOfPlayers(numberOfPlayers: numberOfPlayers!)
        } else {
            //Display alert if user tries to decrease number of players below 2
            self.troubleAlert(title: "Oops...", message: "Minimum number of players is 2")
        }
    }
    @IBAction func plusButtonPressed(_ sender: Any) {
        //Allows user to increase the number of players to a maximum of 20
        if numberOfPlayers! < 20 {
            numberOfPlayers! += 1
            updateNumberOfPlayers(numberOfPlayers: numberOfPlayers!)
        } else {
            //Display alert if user tries to increase number of players above 20
            self.troubleAlert(title: "Oops...", message: "Maximum number of players is 20")
        }
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        let rand = Int.random(in: 1 ..< numberOfPlayers!)
        let nextPlayer = "Next player is sat \(rand) seats to your right"
        questionLabel.text = nextPlayer

    }

    // MARK: Setup

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        config()
    }

    func config() {
        //Align text in buttons to center
        reflectButton.titleLabel?.textAlignment = .center
        dreamButton.titleLabel?.textAlignment = .center

        numberOfPlayers = 10
        updateNumberOfPlayers(numberOfPlayers: numberOfPlayers!)
    }

    // MARK: Helper Functions

    func generateQuestion(isTheFuture: Bool?) -> String {
        var question: String?
        if isTheFuture == false {
            //Generate past question
            let rand = Int.random(in: 0 ..< pastPreText.count)
            question = ("\(pastPreText[rand]) \(randomTimeFrame()) ago?")
        } else {
            //Generate future question
            let rand = Int.random(in: 0 ..< futurePreText.count)
            question = ("\(futurePreText[rand]) \(randomTimeFrame()) from now?")
        }
        return question!
    }

    func randomTimeFrame() -> String {
        //Function to generate random time frame e.g. 3 months or 1 year
        var newTimeFrame: String?
        let randomTime = Timeframe.allCases.randomElement()

        switch randomTime {
        case .hours:
            //Pick a random number of hours from 1 to 12
            let rand = Int.random(in: 1 ... 12)
            newTimeFrame = "\(rand) hour"
            if rand != 1 {
                //If more than 1, make it plural 'hours'
                newTimeFrame! += "s"
            }
            return newTimeFrame!
        case .days:
            //Pick a random number of days from 1 to 6 (7 being a week)
            let rand = Int.random(in: 1 ..< 7)
            newTimeFrame = "\(rand) day"
            if rand != 1 {
                //If more than 1, make it plural 'days'
                newTimeFrame! += "s"
            }
            return newTimeFrame!
        case .weeks:
            //Pick a random number of weeks from 1 to 3 (4 being a month)
            let rand = Int.random(in: 1 ..< 4)
            newTimeFrame = "\(rand) week"
            if rand != 1 {
                //If more than 1 , make it plural 'weeks'
                newTimeFrame! += "s"
            }
            return newTimeFrame!
        case .months:
            //Pick a random number of months from 1 to 11 (12 being a year)
            let rand = Int.random(in: 1 ..< 12)
            newTimeFrame = "\(rand) month"
            if rand != 1 {
                //If more than 1, make it plural 'years'
                newTimeFrame! += "s"
            }
            return newTimeFrame!
        case .years:
            //Pick a random number of years, 10 being the maximum
            let rand = Int.random(in: 1 ... 10)
            newTimeFrame = "\(rand) year"
            if rand != 1 {
                //If more than 1, make it plural 'years'
                newTimeFrame! += "s"
            }
            return newTimeFrame!
        default:
            return ""
        }
    }

    func updateNumberOfPlayers(numberOfPlayers: Int) {
        self.numberOfPlayersLabel.text = String(numberOfPlayers)
    }

    func troubleAlert(title: String, message: String) {
        //Display alert to user
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Got It", style: .cancel)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}
