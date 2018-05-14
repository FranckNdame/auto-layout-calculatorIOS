//
//  ViewController.swift
//  Auto Layout Calculator
//
//  Copyright © 2018 Diet Brain. All rights reserved.
//

import UIKit
var a = ""
var nextNumber : Bool = false
var solved : Bool = false



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        displayNumbers.text! = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @IBOutlet weak var displayNumbers: UILabel!
    

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        //if the user pressed any digit
        if sender.tag >= 0 && sender.tag <= 9 {
            if solved == true{
                solved = false
                if nextNumber == false {
                    displayNumbers.text! = "\(sender.tag)"
                    a = String(sender.tag)
                } else if nextNumber == true {
                    nextNumber = false
                    a = String(sender.tag)
                    print(a)
                    displayNumbers.text! = "\(sender.tag)"
                    print("test")
                }
                
            }
            else {
                if nextNumber == false {
                    displayNumbers.text! += "\(sender.tag)"
                    a += String(sender.tag)
                } else if nextNumber == true {
                    nextNumber = false
                    a += String(sender.tag)
                    print(a)
                    displayNumbers.text! = "\(sender.tag)"
                    print("test")
                }
                
            }

        }
        // cancel
        if sender.tag == 10 {
            displayNumbers.text! = ""
            a = ""
            print("result: 0")
        }
        // negation
        if sender.tag == 11 {
            let expn = NSExpression(format:a)
            print("result: - \(expn.expressionValue(with: nil, context: nil) ?? 0)")
            a = "-\(expn.expressionValue(with: nil, context: nil) ?? 0)"
            displayNumbers.text! = "-\(expn.expressionValue(with: nil, context: nil) ?? 0)"

        }
        // modulo
        if sender.tag == 12 {
//            a += "/100"
        }
        // division
        if sender.tag == 13 {
            solved = false
            nextNumber = true
            let expn = NSExpression(format:a)
            a = "\(expn.expressionValue(with: nil, context: nil) ?? 0)"
            a += "/"
            print(a)
        }
        // multiplication
        if sender.tag == 14 {
            solved = false
            nextNumber = true
            let expn = NSExpression(format:a)
            a = "\(expn.expressionValue(with: nil, context: nil) ?? 0)"
            a += "*"
            print(a)
        }
        //subtraction
        if sender.tag == 15 {
            solved = false
            nextNumber = true
            a += "-"

        }
        // addition
        if sender.tag == 16 {
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
            solved = true

        }
        // decimal point
        if sender.tag == 18 {
            a += "."
            displayNumbers.text! += "."
        }
    }
    
    

    
}

