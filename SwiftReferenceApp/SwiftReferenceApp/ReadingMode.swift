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
    
    public var appTextview: AppTextView!
    
    public var rMachine : StateMachine<rSchema>!
    
    
    static let initialTransition = AppReadModeTransition( oldState: .start, event: .begin(focus: 0..<0), newState: .idle) 
    
    public var rTransition = Variable(initialTransition) 
    
    public var appReadingModeState : Observable<AppReadModeState>
    public var appReadingModeEvent: Observable<AppReadModeEvent>
    
    public let disposeBag = DisposeBag()
    
    public required init() 
    {
        
        appReadingModeEvent    = self.rTransition.map { t in return t.event }
        appReadingModeState    = self.rTransition.map { t in return t.newState }
        
        // Create machine.
        rMachine = StateMachine(schema: ReadingMode.schema, subject: self)
               
    }

    func handleEvent(event: AppReadModeEvent) { 
        rMachine.handleEvent(event) 
    }
    public var state : AppReadModeState {
        return rMachine.state
    }
    
    
}