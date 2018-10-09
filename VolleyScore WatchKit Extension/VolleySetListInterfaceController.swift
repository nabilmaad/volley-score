//
//  VolleySetListInterfaceController.swift
//  VolleyScore WatchKit Extension
//
//  Created by Nabil Maadarani on 2018-10-08.
//  Copyright © 2018 Nabil Maadarani. All rights reserved.
//

import WatchKit
import Foundation

struct VolleySet {
    
    let setName: String
    let ourScore: Int
    let theirScore: Int
}

class VolleySetListInterfaceController: WKInterfaceController {

    @IBOutlet weak var setsTable: WKInterfaceTable!
    
    static let numberOfSets = 3
    static let scoreKeys = ["set1.our.score", "set1.their.score",
                            "set2.our.score", "set2.their.score",
                            "set3.our.score", "set3.their.score"]
    
    // MARK: Lifecycle
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setsTable.setNumberOfRows(VolleySetListInterfaceController.numberOfSets, withRowType: "SetRow")
//        persistRandomScore()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        updateRows()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // MARK: Private
    
    private func updateRows() {
        for index in 0..<setsTable.numberOfRows {
            guard let setRowController = setsTable.rowController(at: index) as? SetRowController else { continue }
            
            setRowController.set = VolleySet(
                setName: "Set \(index + 1)",
                ourScore: UserDefaults.standard.integer(forKey: VolleySetListInterfaceController.scoreKeys[index * 2]),
                theirScore: UserDefaults.standard.integer(forKey: VolleySetListInterfaceController.scoreKeys[index * 2 + 1])
            )
        }
    }
    
    @IBAction func clearScores() {
        for key in VolleySetListInterfaceController.scoreKeys {
            UserDefaults.standard.set(0, forKey: key)
        }
        
        updateRows()
    }

    // MARK: Test
    
    private func persistRandomScore() {
        UserDefaults.standard.set(25, forKey: VolleySetListInterfaceController.scoreKeys[0])
        UserDefaults.standard.set(21, forKey: VolleySetListInterfaceController.scoreKeys[1])
        
        UserDefaults.standard.set(25, forKey: VolleySetListInterfaceController.scoreKeys[2])
        UserDefaults.standard.set(22, forKey: VolleySetListInterfaceController.scoreKeys[3])
        
        UserDefaults.standard.set(25, forKey: VolleySetListInterfaceController.scoreKeys[4])
        UserDefaults.standard.set(23, forKey: VolleySetListInterfaceController.scoreKeys[5])
    }
}
