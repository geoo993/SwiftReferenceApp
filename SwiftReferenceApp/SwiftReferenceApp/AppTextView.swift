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
    
    case ScrollingOn
    case ScrollingOff
    case ResetContentOffsetToLatestReading
    case Fading
    case ShowTextState
    case HideTextState
    
}

public enum AppTextEvent {
    
    case ScrollingEnabled
    case ScrollingDisabled
    case UpdateContentOffset
    case EnableBlur
    case DisableBlur
    case ShowText
    case HideText
    
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
        return [.ScrollingEnabled, .ScrollingDisabled, .UpdateContentOffset, .EnableBlur, .DisableBlur, .ShowText, .HideText]
    }
    
    public var DOTLabel: String {
        switch self {
        case ScrollingEnabled : return "Enable Scrolling"
        case ScrollingDisabled : return "Disable Scrolling"
        case UpdateContentOffset: return "Update Content Offset"
        case EnableBlur: return "Enable Blur"
        case DisableBlur : return "Disable Blur"
        case ShowText: return "Show Text"
        case HideText: return "Hide Text"
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


