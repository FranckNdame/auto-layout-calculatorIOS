//
//  ViewController.swift
//  Auto Layout Calculator
//
//  Copyright © 2018 Diet Brain. All rights reserved.
//

import UIKit
import AVFoundation

// track the operations
var a = ""
// check if the next number of the operation is added
var nextNumber : Bool = false
// check if the operation is solved
var solved : Bool = false
var audioPlayer : AVAudioPlayer!



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // make the UILabel empty on launch
        displayNumbers.text! = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @IBOutlet weak var displayNumbers: UILabel!
    

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        //if the user pressed any digit (0 - 9)
        if sender.tag >= 0 && sender.tag <= 9 {
            // play a keyboard sound
            playSound("numberSound")
            // if the operation has been solved
            if solved == true{
                // reset solved to false and restart
                solved = false
                if nextNumber == false {
                    displayNumbers.text! = "\(sender.tag)"
                    a = String(sender.tag)
                } else if nextNumber == true {
                    nextNumber = false
                    a = String(sender.tag)
                    displayNumbers.text! = "\(sender.tag)"

                }
                
            }
            // if the operation has not been solved
            else
            {
                // if the user is still inserting a value
                if nextNumber == false {
                    // concatenate the values as strings
                    displayNumbers.text! += "\(sender.tag)"
                    a += String(sender.tag)
                    // if the user is done inserting a value
                } else if nextNumber == true {
                    // reset nextNumber to false
                    nextNumber = false
                    a += String(sender.tag)
                    // overwrite the previous UILabel value
                    displayNumbers.text! = "\(sender.tag)"
                }
            }

        }
        else {
            // if the user pressed a non-digit, play operatorSound
            playSound("operatorSound")
            
            // cancel
            if sender.tag == 10 {
                // reset everything to 0
                displayNumbers.text! = ""
                a = ""
                print("reset: 0")
            }
            // negation
            if sender.tag == 11 {
                // convert String to Int and negate its value
                let expn = NSExpression(format:a)
                print("result: - \(expn.expressionValue(with: nil, context: nil) ?? 0)")
                a = "-\(expn.expressionValue(with: nil, context: nil) ?? 0)"
                displayNumbers.text! = "-\(expn.expressionValue(with: nil, context: nil) ?? 0)"
                
            }
            // modulo
            if sender.tag == 12 {
                let expn = NSExpression(format:a)
                a = "\(expn.expressionValue(with: nil, context: nil) ?? 0.0)"
                a += "/100"
                print(a)
            }
            
            // division
            if sender.tag == 13 {
                // check status
                solved = false
                nextNumber = true
                // get result of a as a string
                let expn = NSExpression(format:a)
                a = "\(expn.expressionValue(with: nil, context: nil) ?? 0)"
                // concatenate ÷ to a
                a += "/"
                print(a)
            }
            // multiplication
            if sender.tag == 14 {
                // check status
                solved = false
                nextNumber = true
                // get result of a as a string
                let expn = NSExpression(format:a)
                a = "\(expn.expressionValue(with: nil, context: nil) ?? 0)"
                // concatenate * to a
                a += "*"
                print(a)
            }
            //subtraction
            if sender.tag == 15 {
                // check status
                solved = false
                nextNumber = true
                a += "-"
                
            }
            // addition
            if sender.tag == 16 {
                // check status
                solved = false
                nextNumber = true
                print(a)
                a += "+"
            }
            // display result
            if sender.tag == 17 {
                print(a)
                let expn = NSExpression(format:a)
                print("result: \(expn.expressionValue(with: nil, context: nil) ?? 0)")
                displayNumbers.text! = "\(expn.expressionValue(with: nil, context: nil) ?? 0)"
                // set solved to true
                solved = true
                
            }
            // decimal point
            if sender.tag == 18 {
                a += "."
                displayNumbers.text! += "."
            }
            
        }

    }
    
    // add a playSound method
    func playSound(_ soundFile: String) {
        let soundURL = Bundle.main.url(forResource: soundFile, withExtension: "mp3")!
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: soundURL)
        }
        catch {
            print(error)
        }
        audioPlayer.play()
    }
    
    

    
}

