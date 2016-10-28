
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
    
    static var schema = rSchema(initialState: .readMode) 
    { (state, event) in 
        
        
        func solution(state: AppReadModeState, event: AppReadModeEvent) -> (AppReadModeState, (ReadingMode -> AppReadModeState?)?)? {
            
            switch state {
            
            case AppReadModeState.exploreMode: 
                switch event {
                case AppReadModeEvent.switchMode:
                    print("Explore: now going to read mode")
                    
                    return (AppReadModeState.readMode, nil)
                    //return solution(AppReadModeState.readMode, event: AppReadModeEvent.complete)
                    
                default: 
                    return nil
                }
            case AppReadModeState.readMode : 
                
                switch event {
                case AppReadModeEvent.startMode:
                    print("Read Mode:  now start read mode")
                    
                    return (AppReadModeState.start, nil)
                    //return solution(AppReadModeState.start, event: AppReadModeEvent.readMode)
                    
                default: return nil
                }
                
                
            case AppReadModeState.start : 
                
                switch event {
                case AppReadModeEvent.begin(focus: 0..<0):
                    print("Start:   initialising....., now go to initialising")
                    
                    return (AppReadModeState.initiasing, nil)
                    //return solution(AppReadModeState.initiasing, event: AppReadModeEvent.begin(focus: 0..<0))
                case AppReadModeEvent.failed:
                    print("Start:   initialising failed....., now go to InvestigativeMode")
                    
                    return (AppReadModeState.exploreMode, nil)
                    //return solution(AppReadModeState.exploreMode, event: AppReadModeEvent.begin(focus: 0..<0))
                default: 
                    //print("default initialising")
                    return nil
                }
                
            //case AppReadModeState.ResumeState : 
                //switch event {
                //case AppReadModeEvent.Resume:
                    //print("Resume: now go to start reading")
                    
                    //return (AppReadModeState.ReadingState, nil)
                    ////return solution(AppReadModeState.ReadingState, event: AppReadModeEvent.ActivateReading)
                    
                    ////case AppReadModeEvent.Failed:
                    ////print("reading failed, return to initial")
                ////return (AppReadModeState.InitialState, nil)
                //default: 
                    ////print("default resume")
                    //return nil
                //}
            
            case AppReadModeState.initiasing : 
                switch event {
                case AppReadModeEvent.complete:
                print("Initialising: now going to idle")
                
                return (AppReadModeState.idle, nil)
                //return solution(AppReadModeState.reading, event: AppReadModeEvent.ActivateReading)
                
                //case AppReadModeEvent.Failed:
                //print("reading failed, return to initial")
                //return (AppReadModeState.InitialState, nil)
                default: 
                //print("default resume")
                return nil
                }
            case AppReadModeState.idle : 
                switch event {
                case AppReadModeEvent.startReading:
                    print("Idle: now going to start reading")
                    
                    return (AppReadModeState.reading, nil)
                    //return solution(AppReadModeState.reading, event: AppReadModeEvent.complete)
                case AppReadModeEvent.startPhonicsAssistance:
                    print("Idle: now going to phonics assistance")
                    
                    return (AppReadModeState.phonicsAssistance, nil)
                    //return solution(AppReadModeState.phonicsAssistance, event: AppReadModeEvent.complete)
                case AppReadModeEvent.reset:
                    print("Idle: now going to back to start because user reset the page")
                    
                    return (AppReadModeState.start, nil)
                    //return solution(AppReadModeState.initiasing, event: AppReadModeEvent.complete)
                case AppReadModeEvent.timedOut:
                    print("Idle:   spend to long on idle, now go to Explore Mode")
                    
                    return (AppReadModeState.exploreMode, nil)
                default: 
                    //print("default resume")
                    return nil
                }
            case AppReadModeState.reading: 
                
                switch event {
                case AppReadModeEvent.complete:
                    
                    print("Reading: now reading, then going to recognising")
                    return (AppReadModeState.recognising, nil)
                    //return solution(AppReadModeState.recognising, event: AppReadModeEvent.complete)
                    
                    
                    //if arc4random_uniform(2) == 1 
                    //{ 
                        //print("Reading:  you paused, going to pause")
                        //return (AppReadModeState.PauseState, nil)
                        ////return solution(AppReadModeState.PauseState, event: AppReadModeEvent.Pause)
                    //}else{
                        //print("Reading:  you finished reading, going to completed")
                        //return (AppReadModeState.CompletedState, nil)
                        ////return solution(AppReadModeState.CompletedState, event: AppReadModeEvent.ActivateFeedback)
                    //}
                    
                default: 
                    //print("default reading")
                    return nil
                }
            case AppReadModeState.phonicsAssistance : 
                switch event {
                case AppReadModeEvent.complete:
                    print("Phonics Assistance: now going back to idle")
                    
                    return (AppReadModeState.idle, nil)
                    //return solution(AppReadModeState.idle, event: AppReadModeEvent.complete)
                    
                default: 
                    return nil
                }
            case AppReadModeState.recognising : 
                switch event {
                case AppReadModeEvent.complete:
                    print("Recognising: now going to compute the next step ")
                    
                    return (AppReadModeState.computingNextStep, nil)
                    //return solution(AppReadModeState.computingNextStep, event: AppReadModeEvent.complete)
                case AppReadModeEvent.startFeedback:
                    
                    print("Recognising: now going to result")
                    return (AppReadModeState.feedback, nil)
                    //return solution(AppReadModeState.result, event: AppReadModeEvent.startFeedback)
                default: 
                    return nil
                }
            case AppReadModeState.computingNextStep : 
                switch event {
                case AppReadModeEvent.complete:
                    print("Computing Next Step: now going to initialising")
                    
                    return (AppReadModeState.initiasing, nil)
                    //return solution(AppReadModeState.initiasing, event: AppReadModeEvent.complete)
                    
                default: 
                    return nil
                }
            //case AppReadModeState.PauseState: 
                //switch event {
                //case AppEvent.Pause:
                    
                    //if arc4random_uniform(2) == 1 
                    //{
                        //print("Pause:  you timed out, going to end")
                        //return (AppReadModeState.EndState, nil)
                        ////return solution(AppReadModeState.EndState, event: AppReadModeEvent.End)
                    //}else{
                        //print("Pause: continue reading, going to resume")
                        //return (AppReadModeState.ResumeState, nil)
                        ////return solution(AppReadModeState.ResumeState, event: AppReadModeEvent.Resume)
                    //}
                    
                    ////case AppReadModeEvent.Failed:
                    ////print("reading failed, return to initial")
                    ////return (AppReadModeState.InitialState, nil)
                //default: 
                    ////print("default pause")
                    //return nil
                //}
                
            //case AppReadModeState.CompletedState: 
                
                //switch event {
                    
                //case AppReadModeEvent.ActivateFeedback: 
                    
                    //print("Completed: you are now checking your score, going end")
                    
                    //return (AppReadModeState.EndState, nil)
                    ////return solution(AppReadModeState.EndState, event: AppReadModeEvent.End)
                //default: 
                    ////print("default completed")
                    //return nil
                //}
            
            case AppReadModeState.feedback: 
                switch event {
                case AppReadModeEvent.complete:
                    print("Result: now going to end")
                    
                    return (AppReadModeState.end, nil)
                    //return solution(AppReadModeState.end, event: AppReadModeEvent.complete)
                    
                default: 
                    return nil
                }
            case AppReadModeState.end: 
                
                print("finised and now end")
                return nil
                //switch event {
                
                ////case AppReadModeEvent.Restart: 
                    ////print("Restart: you finished reading, and saw your your score in feedback, going instiate")
                    
                    ////return (AppReadModeState.initial, nil)
                    ////return solution(AppReadModeState.InitialState, event: AppReadModeEvent.Begin)
                //case AppReadModeEvent.end: 
                    //print("Page Completed:  you finished reading, and saw your your score in feedback, now you can go to next page because reading ended")
                    //return nil
                //default: 
                    //return nil
                //}
                
            default: return nil
            }

            
        }
     
        return solution(state, event: event)
                
    } 

       
}