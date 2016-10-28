//
//  AppTextView.swift
//  SwiftReferenceApp
//
//  Created by GEORGE QUENTIN on 28/10/2016.
//  Copyright © 2016 StoryShare. All rights reserved.
//

import Foundation
import SwiftyStateMachine
import RxSwift
import UIKit

public enum AppTextState {
    
    case scrollingOn
    case scrollingOff
    case resetContentOffsetToLatestReading
    case fading
    
}

public enum AppTextEvent {
    
    case scrollingEnabled
    case scrollingDisabled
    case updateContentOffset
    case enableBlur
    case disableBlur
    
}


public class AppTextView 
{

    public typealias tSchema = GraphableStateMachineSchema<AppReadModeState, AppTextEvent, AppTextView> 
    
    public var machine : StateMachine<tSchema>! 
    
    public init() {
        machine  = StateMachine(schema: AppTextView.schema, subject: self)
    }
    
    
    static var schema = tSchema(initialState: .start) 
    { 
        state, event in switch state 
        {
            case AppReadModeState.readMode : 
                switch event {
                case AppTextEvent.enableBlur:
                
                return (AppReadModeState.start, nil)
                //return solution(AppReadModeState.start, event: AppReadModeEvent.complete)
                default: return nil
            }
            
            case AppReadModeState.start : 
                switch event {
                case AppTextEvent.scrollingDisabled:
                    
                    return (AppReadModeState.initiasing, nil)
                //return solution(AppReadModeState.initiasing, event: AppReadModeEvent.complete)
                default: return nil
            }
            
            
            
            default: 
            return nil
            
        }
    }
}



// MARK: UserState DOTLabelable extension
extension AppTextEvent: DOTLabelable 
{
    
    
    public static var DOTLabelableItems: [AppTextEvent] 
    {
        return [.scrollingEnabled, .scrollingDisabled, .updateContentOffset, .enableBlur, .disableBlur]
    }
    
    public var DOTLabel: String {
        switch self {
        case scrollingEnabled : return "Enable Scrolling"
        case scrollingDisabled : return "Disable Scrolling"
        case updateContentOffset: return "Update Content Offset"
        case enableBlur: return "Enable Blur"
        case disableBlur : return "Disable Blur"
        }
    }
}



// MARK: Add printable conformance
extension AppTextEvent : CustomStringConvertible {
    public var description: String { return self.DOTLabel }
}

extension AppTextEvent : CustomDebugStringConvertible {
    public var debugDescription: String { return "AppTextEvent.\(self.DOTLabel)" }
}


