//
//  VolleyScoreInterfaceController.swift
//  VolleyScore WatchKit Extension
//
//  Created by Nabil Maadarani on 2018-10-11.
//  Copyright © 2018 Nabil Maadarani. All rights reserved.
//

import WatchKit
import Foundation

enum ScoreBorderColor {
    
    static let selected = #colorLiteral(red: 0.9931221604, green: 0.4783460498, blue: 0, alpha: 1)
    static let unSelected = #colorLiteral(red: 0.7233634591, green: 0.7233806252, blue: 0.7233713269, alpha: 1)
}

class VolleyScoreInterfaceController: WKInterfaceController {

    @IBOutlet weak var setTitleLabel: WKInterfaceLabel!
   
    @IBOutlet weak var ourScoreLabel: WKInterfaceLabel!
    @IBOutlet weak var ourScoreGroup: WKInterfaceGroup!
    
    @IBOutlet weak var theirScoreLabel: WKInterfaceLabel!
    @IBOutlet weak var theirScoreGroup: WKInterfaceGroup!
    
    var selectedTeam: Team = .us {
        didSet {
            switch selectedTeam {
            case .us:
                ourScoreGroup.setBackgroundColor(ScoreBorderColor.selected)
                theirScoreGroup.setBackgroundColor(ScoreBorderColor.unSelected)
            case .them:
                ourScoreGroup.setBackgroundColor(ScoreBorderColor.unSelected)
                theirScoreGroup.setBackgroundColor(ScoreBorderColor.selected)
            }
        }
    }
    
    var setNumber = 0
    var ourScore: Int!
    var theirScore: Int!
    
    var totalCrownDelta = 0.0
    
    // MARK: Lifecycle
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let volleySet = context as? VolleySet else { return }
        
        setNumber = volleySet.number
        setTitleLabel.setText(volleySet.name)
        updateOurScore(to: volleySet.ourScore)
        updateTheirScore(to: volleySet.theirScore)
        
        selectedTeam = .us
    }
    
    override func willActivate() {
        super.willActivate()
        
        crownSequencer.delegate = self
        crownSequencer.focus()
    }
    
    // MARK: Score tapping
    
    @IBAction func ourScoreTapped() {
        selectedTeam = .us
    }
    
    @IBAction func theirScoreTapped() {
        selectedTeam = .them
    }
    
    // MARK: Private
    
    private func updateOurScore(to score: Int) {
        ourScore = score
        ourScoreLabel.setText(String(score))
    }
    
    private func updateTheirScore(to score: Int) {
        theirScore = score
        theirScoreLabel.setText(String(score))
    }
}

// MARK: WKCrownDelegate

extension VolleyScoreInterfaceController: WKCrownDelegate {
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        totalCrownDelta += rotationalDelta
        
        let deltaNeededToChangeScoreByOne = 1.0/50.0
        if abs(totalCrownDelta) > deltaNeededToChangeScoreByOne {
            let scoreDelta = totalCrownDelta > 0 ? 1 : -1
            totalCrownDelta = 0
            switch selectedTeam {
            case .us:
                updateOurScore(to: max(0, ourScore + scoreDelta))
            case .them:
                updateTheirScore(to: max(0, theirScore + scoreDelta))
            }
        }
    }
    
    func crownDidBecomeIdle(_ crownSequencer: WKCrownSequencer?) {
        UserDefaults.standard.set(ourScore, forKey: VolleySet.key(setNumber: setNumber, team: .us))
        UserDefaults.standard.set(theirScore, forKey: VolleySet.key(setNumber: setNumber, team: .them))
    }
}
