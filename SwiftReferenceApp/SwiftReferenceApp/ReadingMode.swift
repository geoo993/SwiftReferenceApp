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

public class ReadingMode 
{
    public static let rSharedInstance = ReadingMode()
    
    public var user: User!
    
    public var rMachine : StateMachine<rSchema>!
    
    static let initialTransition = AppReadModeTransition( oldState: .InitialState, event: .Begin, newState: .ReadingState, userState: .Trial(count: 0) ) 
    
    public var rTransition = Variable(initialTransition) 

    private var _hsmTransitionState = 
        Variable((AppReadModeState.InitialState, AppReadModeEvent.Begin, AppReadModeState.ReadingState, UserState.Trial(count: 0))) 
    
    public var appReadingModeState : Observable<AppReadModeState>
    public var appReadingModeEvent: Observable<AppReadModeEvent>
    public var userReadingModeState : Observable<UserState>
    
    public let disposeBag = DisposeBag()
    
    public required init() 
    {
        user = User()
      
        appReadingModeEvent    = self.rTransition.map { t in return t.event }
        appReadingModeState    = self.rTransition.map { t in return t.newState }
        userReadingModeState   = self.rTransition.map { t in return t.userState }
        
        // Create machine.
        rMachine = StateMachine(schema: ReadingMode.schema, subject: self)
        
        rMachine.addDidTransitionCallback { oldState, event, newState, trace in 
            let appTransition = AppReadModeTransition( oldState: oldState, event:event, newState: newState, userState: self.user.machine.state ) 
            self.rTransition.value = appTransition
            //            self._hsmTransitionState.next(hsmState)
        }
    }

}