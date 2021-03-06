//
//  User.swift
//  SwiftReferenceApp
//
//  Created by Daniel Asher on 21/08/2015.
//  Copyright (c) 2015 StoryShare. All rights reserved.
//

import SwiftyStateMachine

public enum UserState 
{
    case FullAccess
    case Trial(count: Int)
}

public class User 
{
    //public typealias Schema = GraphableStateMachineSchema<UserState, AppEvent, User> 
    public typealias Schema = GraphableStateMachineSchema<UserState, AppReadModeEvent, User> 
    
    public var machine : StateMachine<Schema>! 
    
    func hasApplicationAccess() -> Bool {
        switch machine.state {
        case .Trial(let saveCount) where saveCount > 5: return false
        default: return true
        }
    }
    
    public init() {
        machine  = StateMachine(schema: User.schema, subject: self)
    }
    
 
    //public subscript(event: AppEvent) -> Void {
        //machine.handleEvent(event)
    //}
    
    public subscript(event: AppReadModeEvent) -> Void {
        machine.handleEvent(event)
    }
    
    
}


