//
//  VolleySetListInterfaceController.swift
//  VolleyScore WatchKit Extension
//
//  Created by Nabil Maadarani on 2018-10-08.
//  Copyright © 2018 Nabil Maadarani. All rights reserved.
//

import WatchKit
import Foundation

enum Team: String {
    
    case us, them
}

struct VolleySet {
    
    let number: Int
    let ourScore: Int
    let theirScore: Int
    
    var name: String {
        return "Set \(self.number)"
    }
    
    static func key(setNumber: Int, team: Team) -> String {
        return "set\(setNumber).\(team.rawValue).score"
    }
}

class VolleySetListInterfaceController: WKInterfaceController {

    @IBOutlet weak var setsTable: WKInterfaceTable!
    
    static let numberOfSets = 3
    
    var volleySets: [VolleySet] = []
    
    // MARK: Lifecycle
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setsTable.setNumberOfRows(VolleySetListInterfaceController.numberOfSets, withRowType: "SetRow")
    }
    
    override func willActivate() {
        super.willActivate()
        
        updateRows()
    }
    
    // MARK: Row selection
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let volleySet = volleySets[rowIndex]
        pushController(withName: "VolleyScoreInterfaceController", context: volleySet)
    }
    
    // MARK: Private
    
    private func updateRows() {
        volleySets.removeAll()
        for index in 0..<setsTable.numberOfRows {
            guard let setRowController = setsTable.rowController(at: index) as? SetRowController else { continue }
            
            let setNumber = index + 1
            let volleySet = VolleySet(
                number: setNumber,
                ourScore: UserDefaults.standard.integer(forKey: VolleySet.key(setNumber: setNumber, team: .us)),
                theirScore: UserDefaults.standard.integer(forKey: VolleySet.key(setNumber: setNumber, team: .them))
            )
            setRowController.set = volleySet
            volleySets.append(volleySet)
        }
    }
    
    @IBAction func clearScores() {
        for index in 0..<setsTable.numberOfRows {
            UserDefaults.standard.set(0, forKey: VolleySet.key(setNumber: index + 1, team: .us))
            UserDefaults.standard.set(0, forKey: VolleySet.key(setNumber: index + 1, team: .them))
        }
        
        updateRows()
    }

    // MARK: Test
    
    private func persistRandomScore() {
        UserDefaults.standard.set(25, forKey: VolleySet.key(setNumber: 1, team: .us))
        UserDefaults.standard.set(21, forKey: VolleySet.key(setNumber: 1, team: .them))
        
        UserDefaults.standard.set(25, forKey: VolleySet.key(setNumber: 2, team: .us))
        UserDefaults.standard.set(22, forKey: VolleySet.key(setNumber: 2, team: .them))
        
        UserDefaults.standard.set(25, forKey: VolleySet.key(setNumber: 3, team: .us))
        UserDefaults.standard.set(23, forKey: VolleySet.key(setNumber: 3, team: .them))
    }
}
