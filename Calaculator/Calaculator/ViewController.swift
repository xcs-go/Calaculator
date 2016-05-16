//
//  ViewController.swift
//  Calaculator
//
//  Created by 谢朝森 on 16/5/16.
//  Copyright (c) 2016年 xcs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var disPlay: UILabel!
    
    var userIsInTheMiddleOfTypingANumber:Bool = false
    @IBAction func digital(sender: UIButton) {
        let number = sender.currentTitle
        if userIsInTheMiddleOfTypingANumber {
            disPlay.text = disPlay.text! + number!
        } else {
            disPlay.text = number!
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    var numberArray:Array<Double> = Array()
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        numberArray.append(displayValue)
        println("\(numberArray)")
    }
    
    var displayValue:Double {
        get {
//             将字符串转换为double类型
            return NSNumberFormatter().numberFromString(disPlay.text!)!.doubleValue
        }
        set {
            disPlay.text = "\(newValue)"
//            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    @IBAction func operation(sender: UIButton) {
        let operate = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operate {
            case "×":
                PerformOperation(){$0 * $1 }
            case "÷":
                PerformOperation(){$1 / $0}
            case "+":
                PerformOperation(){$0 + $1}
            case "-":
                PerformOperation(){$1 - $0}
            case "√":
                PerformOperationSqrt{sqrt($0)}
        default:break
        }
    }
    
    func PerformOperation(operation:(Double, Double) -> Double) {
        if numberArray.count >= 2 {
            displayValue = operation(numberArray.removeLast(), numberArray.removeLast())
            enter()
        }
    }
    func PerformOperationSqrt(operation:Double -> Double) {
        if numberArray.count >= 1 {
            displayValue = operation(numberArray.removeLast())
            enter()
        }
    }
    
}

