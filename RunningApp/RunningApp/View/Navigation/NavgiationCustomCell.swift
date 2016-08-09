//
//  NavgiationCustomCell.swift
//  RunningApp
//
//  Created by Ben Ha on 7/25/16.
//  Copyright © 2016 Ben Ha. All rights reserved.
//

import Foundation

import UIKit

class NavigationCustomCell: UITableViewCell {

    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var directions: UILabel!
    
    override var frame: CGRect {
        get{
            return super.frame
        }
        
        set(newFrame){
            var frame = newFrame
            frame.origin.x += 20
            frame.origin.y += 10
            frame.size.height -= 2*20
            frame.size.width -= 2 * 20
            super.frame = frame
        }
    }
}
