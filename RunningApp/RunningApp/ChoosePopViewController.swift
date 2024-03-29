//
//  ChoosePopViewController.swift
//  RunningApp
//
//  Created by Ben Ha on 8/1/16.
//  Copyright © 2016 Ben Ha. All rights reserved.
//

import UIKit
import GMStepper

protocol ChoosePopViewDelegate {
    func minDistanceForPopup(view: ChoosePopViewController) -> Double
    func didSelectDistance(view: ChoosePopViewController, distance: Double)
}

class ChoosePopViewController: UIViewController {

    @IBOutlet weak var stepper: GMStepper!
    
    var delegate: ChoosePopViewDelegate!
    var minimumValue:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.minimumValue = delegate.minDistanceForPopup(self)
        stepper.maximumValue = 10000000
    
        print(stepper.minimumValue)
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        stepper.addTarget(self, action: #selector(ChoosePopViewController.stepperValueChanged), forControlEvents: .ValueChanged)
        // Do any additional setup after loading the view.
    }
    
    func stepperValueChanged(stepper: GMStepper) {
        print(stepper.value, terminator: "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopUp(sender: AnyObject) {
        self.delegate.didSelectDistance(self, distance: stepper!.value)
        self.removeAnimate()
        //self.view.removeFromSuperview()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    
    
    
    
    

    


}
