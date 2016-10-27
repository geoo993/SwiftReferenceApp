
//
//  ReadingMode+Schema.swift
//  SwiftReferenceApp
//
//  Created by GEORGE QUENTIN on 27/10/2016.
//  Copyright © 2016 StoryShare. All rights reserved.
//

import Foundation
import SwiftyStateMachine

extension ReadingMode 
{    
    
    public typealias rSchema = GraphableStateMachineSchema<AppReadModeState, AppReadModeEvent, ReadingMode> 
    
    static var schema = rSchema(initialState: .InitialState) 
    { (state, event) in 
        
        switch state {
            
        case AppReadModeState.InitialState : 
            
            switch event {
            case AppReadModeEvent.Begin:
                print("initialising....., now go to start reading")
                
                return (AppReadModeState.ReadingState, nil)
                
                //case AppReadModeEvent.Failed:
                //print("reading failed, return to initial")
                //return (AppReadModeState.InitialState, nil)
                
            default: 
                print("default initialising")
                return nil
            }
            
        case AppReadModeState.ResumeState : 
            switch event {
            case AppReadModeEvent.Resume:
                print("resumed, now go to start reading")
                return (AppReadModeState.ReadingState, nil)
                //case AppReadModeEvent.Failed:
                //print("reading failed, return to initial")
            //return (AppReadModeState.InitialState, nil)
            default: 
                print("default resume")
                return nil
            }
        case AppReadModeState.ReadingState: 
            
            switch event {
            case AppReadModeEvent.ActivateReading:
                
                print("now reading, you can either go to pause havent finished reading, or you go to end when finish reading")
                
                if arc4random_uniform(2) == 1 
                { 
                    print("you paused")
                    return (AppReadModeState.PauseState, nil)
                }else{
                    print("you finished reading")
                    return (AppReadModeState.CompletedState, nil)
                }
                
            default: 
                print("default reading")
                return nil
            }
        case AppReadModeState.PauseState(let pause): 
            
            switch event {
            case AppEvent.Pause:
                
                if arc4random_uniform(2) == 1 
                {
                    print("you timed out")
                    return (AppReadModeState.EndState, nil)
                }else{
                    print("you are resuming reading")
                    return (AppReadModeState.ResumeState, nil)
                }
                
                //case AppReadModeEvent.Failed:
                //print("reading failed, return to initial")
            //return (AppReadModeState.InitialState, nil)
            default: 
                print("default pause")
                return nil
            }
            
        case AppReadModeState.CompletedState: 
            
            switch event {
                
            case AppReadModeEvent.ActivateFeedback: 
                
                print("you are now checking your score, then you can end")
               
                return (AppReadModeState.EndState, nil)
                
            default: 
                print("default completed")
                return nil
            }
            
        case AppReadModeState.EndState(let end): 
            
            switch event {
                
            case AppReadModeEvent.End: 
                print("you finished reading, and saw your your score in feedback, now you can restart or go to next page ")
                return (AppReadModeState.InitialState, nil)
            default: 
                print("default end")
                return nil
            }
            
            
        default: return nil
        }
        
    } 

       
}