//
//  ReadingMode.swift
//  SwiftReferenceApp
//
//  Created by GEORGE QUENTIN on 27/10/2016.
//  Copyright © 2016 StoryShare. All rights reserved.
//

import Foundation
import SwiftyStateMachine
import RxSwift
import UIKit

public class ReadingMode 
{
    public static let rSharedInstance = ReadingMode()
    
    public var rMachine : StateMachine<rSchema>!
    
    public required init() 
    {
            
        // Create machine.
        rMachine = StateMachine(schema: ReadingMode.schema, subject: self)
               
    }

    
}