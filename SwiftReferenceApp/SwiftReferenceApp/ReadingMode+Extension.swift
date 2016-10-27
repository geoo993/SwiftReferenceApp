//
//  ReadingMode+Extension.swift
//  SwiftReferenceApp
//
//  Created by GEORGE QUENTIN on 27/10/2016.
//  Copyright © 2016 StoryShare. All rights reserved.
//

import Foundation



extension ReadingMode 
{

    func handleEvent(event: AppReadModeEvent) { 
        rMachine.handleEvent(event) 
    }
    
    public func set(user: User) -> Bool 
    {
        self.user = user
        
        rMachine.addDidTransitionCallback { oldState, event, newState, app in 
            self.user[event] 
        }
        return true
    }
    
    public var state : AppReadModeState {
        return rMachine.state
    }
    
}
