//
//  RandomObjects.swift
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

/**
 Description  This class manages an array of objects and will return a non-repeating random object from the array.
 
 Use `init(objects:)` to create an instance RandomObjects. You can also use `setObjectsArray` to replace the array managed by the instance of `RandomObjects`.
 
 The function `randomObject()` returns a random object from the array. Once all objects from the provided array of objects have been returned, the RandomObjects instance resets itself and will start repeating
 */

class RandomObjects<T> {
    var objectsArray: [T]
    var indexes: [Int]!
    var oldIndex: Int?
    
    
    //-----------------------------------------------------------------------------------------------------------
    /**
     This is the designated initializer for the RandomObjects class. Use it to create a new instance of RandomObjects
     
     - Parameter objects: An array of objects to manage
     */
    init(objects: [T]) {
        objectsArray = objects
        fillIndexesArray()
    }
    
    
    //-----------------------------------------------------------------------------------------------------------
    /**
     A private function that builds the array of indexes used to select random items
     */
    private func fillIndexesArray() {
        if indexes?.isEmpty != false
        {
            indexes = Array(0..<objectsArray.count)
        }
    }
    
    //-----------------------------------------------------------------------------------------------------------
    /**
     This function replaces the array of objects managed by the `RandomObjects` instance and resets the pool of objects to the full array contents
     
     - Parameter newArray: A new array of objects to serve as a pool for the `RandomObjects` instance to manage.
     */
    func setObjectsArray (newArray: [T]) -> Void {
        objectsArray = newArray
        indexes?.removeAll()
        fillIndexesArray()
    }
    
    //-----------------------------------------------------------------------------------------------------------
    /**
     This function returns a random object from the array it manages. Once it has returned every object in the array once, it resets itself and will start drawing random objects from the full array again.
     
     It has logic to avoid ever giving the same object twice in a row.
     - Parameter refillWhenEmpty: (default = true). If true, the RandomObjects refills the array once every object in the array has been returned once. If false, the function returns nil once the last object has been returned from the array
     
     - Returns: An object from the array of objects
     */
    
    func randomObject(refillWhenEmpty: Bool = true) -> T? {
        var randomIndex: Int
        var objectIndex: Int
        
        if refillWhenEmpty {
            fillIndexesArray()
        } else if indexes.isEmpty {
            return nil
        }
        repeat {
            randomIndex = Int(arc4random_uniform(UInt32(indexes.count)))
            objectIndex = indexes[randomIndex]
        } while objectIndex == oldIndex
        
        indexes.remove(at: randomIndex)
        
        oldIndex = objectIndex
        return objectsArray[objectIndex];
    }
    
}
