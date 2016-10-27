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
        //case AppEvent.Start:
            //return (AppState.Idle, nil)
            
            default: return nil
            }
        case AppReadModeState.ReadingState: switch event {
        //case AppEvent.Save:
            //return (AppState.Saving, { app in 
                
                //let saver = app.createSaveTask()
                    //.success { (str: String) -> String in 
                        //app <- .Saved; return str 
                    //}
                    //.failure { errorInfo -> String in 
                        //app <- .Failed; return "Error!" // FIXME: Unable to use $0  
                //} 
                
                //return .Saving })
            
        //case AppEvent.Purchase:
            //return (AppState.Purchasing, { app in 
                //let purchaser = app.createPurchaseTask()
                    //.success { isSaved -> Bool in 
                        //app <- .Purchased; return isSaved 
                    //}
                    //.failure { errorInfo -> Bool in 
                        //app <- .Failed; return false 
                //} 
                //return .Purchasing})
            
            default: return nil
            }
        case AppReadModeState.PauseState(let pause): switch event {
        //case AppEvent.Saved:
            //return (AppState.Idle, nil)
            
        //case AppEvent.Failed:
            //return (AppState.Alerting, { app in 
                //let alerter = app.createAlertTask()
                    //.success { saved in 
                        //app <- .Complete; return saved 
                    //}
                    //.failure { errorInfo -> Bool in 
                        //app <- .Failed; return false 
                //} 
                //return .Alerting })
            
            default: return nil
            }
            
        case AppReadModeState.EndState(let end): switch event {
        //case AppEvent.Purchased: 
            //return (AppState.Idle, nil)
            
        //case AppEvent.Failed:
            //return (AppState.Alerting, nil)
            
            default: return nil
            }
            
        case AppReadModeState.FeedbackState(let feedback): switch event {
        //case AppEvent.Complete: 
            //return (.Idle, nil)
            
            default: return nil
            }
        }
    } 
}