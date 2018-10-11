//
//  VolleyScoreInterfaceController.swift
//  VolleyScore WatchKit Extension
//
//  Created by Nabil Maadarani on 2018-10-11.
//  Copyright © 2018 Nabil Maadarani. All rights reserved.
//

import WatchKit
import Foundation


class VolleyScoreInterfaceController: WKInterfaceController {

    @IBOutlet weak var setTitleLabel: WKInterfaceLabel!
    @IBOutlet weak var ourScoreLabel: WKInterfaceLabel!
    @IBOutlet weak var theirScoreLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let vollleySet = context as? VolleySet else { return }
        
        setTitleLabel.setText(vollleySet.setName)
        ourScoreLabel.setText(String(vollleySet.ourScore))
        theirScoreLabel.setText(String(vollleySet.theirScore))
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
