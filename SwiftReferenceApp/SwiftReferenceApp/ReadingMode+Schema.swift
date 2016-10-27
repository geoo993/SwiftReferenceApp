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
    
    static var schema = rSchema(initialState: .ReadingState) 
    {   
        state, event in switch state 
        {
            
            
        case AppReadModeState.InitialState : switch event {
            case AppReadModeEvent.Begin:
                return (AppReadModeState.ReadingState, nil)
            
            case AppReadModeEvent.Failed:
                print("reading failed, return to initial")
                return (AppReadModeState.InitialState, nil)
            default: return nil
            }
        case AppReadModeState.ResumeState : switch event {
            case AppReadModeEvent.Resume:
                return (AppReadModeState.ReadingState, nil)
            case AppReadModeEvent.Failed:
                print("reading failed, return to initial")
                return (AppReadModeState.InitialState, nil)
            default: return nil
            }
        case AppReadModeState.ReadingState: switch event {
            case AppReadModeEvent.ActivateReading:
            
                print("now reading, you can either go to pause havent finished reading, or you go to end when finish reading")
                
                if arc4random_uniform(2) > 0 
                { 
                    print("you paused")
                    return (AppReadModeState.PauseState, nil)
                }else{
                    print("you finished reading")
                    return (AppReadModeState.CompletedState, nil)
                }
           
            default: return nil
            }
        case AppReadModeState.PauseState(let pause): switch event {
            case AppEvent.Pause:
                
                if arc4random_uniform(2) > 0 
                {
                    print("you timed out")
                    return (AppReadModeState.InitialState, nil)
                }else{
                    print("you are resuming reading")
                    return (AppReadModeState.ResumeState, nil)
                }
            
            //case AppReadModeEvent.Failed:
                //print("reading failed, return to initial")
                //return (AppReadModeState.InitialState, nil)
            default: return nil
            }
            
        case AppReadModeState.CompletedState: switch event {
            
            case AppReadModeEvent.ActivateFeedback: 
                
                print("you are now checking your score")
                if arc4random_uniform(2) > 0 
                {
                    print("you can end")
                    return (AppReadModeState.EndState, nil)
                }else{
                    print("you start again")
                    return (AppReadModeState.InitialState, nil)
                }
            
            default: return nil
            }
        
        case AppReadModeState.EndState(let end): switch event {
            
            case AppReadModeEvent.End: 
                print("you finshed reading, and saw your your score in feedback ")
                return  nil
            default: return nil
            }
            
            
        default: return nil
        }
        
        
    
        
    } 
}