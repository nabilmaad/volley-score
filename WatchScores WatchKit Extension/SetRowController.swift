 //
//  SetRowController.swift
//  VolleyScore WatchKit Extension
//
//  Created by Nabil Maadarani on 2018-10-09.
//  Copyright © 2018 Nabil Maadarani. All rights reserved.
//

import WatchKit

class SetRowController: NSObject {

    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    
    @IBOutlet weak var ourScoreLabel: WKInterfaceLabel!
    @IBOutlet weak var theirScoreLabel: WKInterfaceLabel!
    
    var set: VolleySet? {
        didSet {
            guard let set = set else { return }
            
            titleLabel.setText(set.name)
            
            ourScoreLabel.setText(String(set.ourScore))
            theirScoreLabel.setText(String(set.theirScore))
        }
    }
 }
