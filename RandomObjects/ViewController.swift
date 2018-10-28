//
//  ViewController.swift
//  RandomObjects
//
//  Created by Duncan Champney on 3/28/16.
//  Copyright © 2016 Duncan Champney.
//  Licensed under the MIT software license:

/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import UIKit

class ViewController: UIViewController {
    
    var arrayOfNumberStrings: [String]!
    var aRandomGenerator:RandomObjects<String>!
    
    let count = 20
    
    func doInitSetup() {
        arrayOfNumberStrings  = [String]()
        arrayOfNumberStrings.reserveCapacity(count)
        
        let aFormatter = NumberFormatter()
        aFormatter.numberStyle = .spellOut
        for aNumber in 1...count {
            if let aString = aFormatter.string(from: NSNumber(value: aNumber)) {
                arrayOfNumberStrings.append(aString)
            }
        }
        aRandomGenerator = RandomObjects.init(objects: arrayOfNumberStrings)
    }
    
    override init(nibName nibNameOrNil: String?,
                  bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
        doInitSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doInitSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var randomResults = [String]()
        var numObjectsGenerated: Int = 0;
        let total = 100
        let start = Date().timeIntervalSinceReferenceDate
        for _ in 1...total {
            guard let aNumberString: String = aRandomGenerator.randomObject(refillWhenEmpty: true) else {
                break
            }
            numObjectsGenerated += 1
            randomResults.append(aNumberString)
        }
        print(randomResults)
        let duration = Date().timeIntervalSinceReferenceDate - start
        let message = String(format: "Generated %d random strings in %.3f seconds", numObjectsGenerated, duration)
        print(message)
    }
}

