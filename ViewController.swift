//
//  ViewController.swift
//  Calculatrix
//
//  Created by Leo Neves on 4/10/15.
//  Copyright (c) 2015 Leo Neves. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    var infixstring: String = ""
    var posfix = true;
    var userIsInTheMiddleOfTypingANumber = false;
    
    @IBAction func appendDigit(sender: UIButton) {
        
        var digit = sender.currentTitle!
        let espace: String = ""
        
        if digit == "." && display.text!.rangeOfString(".") != nil {
            return;
        }
        
       
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + espace
            display.text = display.text! + digit
            
        } else {
            display.text = display.text! + espace
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
        appendToHistoryLabel(digit)

    }
    
    @IBAction func operate(sender: UIButton!) {
        var operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        switch operation {
        case "x": operation2 { $0 * $1 }
        case "-": operation2 { $1 - $0 }
        case "/": operation2 { $1 / $0 }
        case "+": operation2 { $0 + $1 }
        case "SQRT": operation1 { sqrt($0) }
        case "SIN": operation1 { sin($0) }
        case "COS": operation1 { cos($0) }
        case "PI": operation1 { $0 * M_PI }
        default: break
        }
        appendToHistoryLabel(" " + operation + " ")

    }
    
    func operation2(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func operation1(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func appendToHistoryLabel(text: String) {
        historyLabel.text = historyLabel.text! + " " + text;
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
    }
    
    @IBAction func clear(sender: UIButton) {
        operandStack.removeAll(keepCapacity: false)
        display.text = ""
        historyLabel.text = ""
    }
    
    var displayValue: Double {
        get {
             return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            
        }
        
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    
    @IBAction func Fix(sender: UISwitch) {
        posfix = !posfix
        if (posfix) {
            println("posfixa ");
        }
        else {
              println("infixa ");
        }
        
    }
    
    
    /*func Convert (){
    
        var s = Array<Double>()
        s = operandStack;
        var inputplus = String()
        var input : Array<String> = inputplus.componentsSeparatedByString("/")
        var c : Int = 0
        inputplus[1]
        while( c < input.count) { // not end of postfix expression
            if ( input[c]=="x" ||input[c]=="x" || input[c]=="-" || input[c]=="+") {
                s.push(input[c])
            }
            else {
                s.append(NSNumberFormatter().numberFromString(input[c])!.doubleValue)
            }
            if( e is an operand )
            s.push( e );
            else {
                op2 = s.pop();
                op1 = s.pop();
                value = result of applying operator ‘e’ to op1 and op2;
                s.push( value ); 
            }
            
            c++
        } 
        finalresult = s.pop();
        
        
        
    }*/
    
}


