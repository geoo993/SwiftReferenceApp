//
//  ReadingMode+Metadata.swift
//  SwiftReferenceApp
//
//  Created by GEORGE QUENTIN on 26/10/2016.
//  Copyright © 2016 StoryShare. All rights reserved.
//

import Foundation
import UIKit
import SwiftyStateMachine

//speech recognition services
//phonics assistance services
//speech playback services
//touch pointer behaviour
//teacher one service/ teacher strategy (which is the way we read)



//always goes from state to an event to new state

//- If the user spends more than 30 seconds without reading.
//- If the user gets a phone call
//- if the device shuts down or goes to screen saver
//- If the user tries to do anything else such press home button
//- If you pause/stop/ended and go to a tweek
//- any other cases



//page
public enum AppPageState {
    case NewPage
    case CompletedPage
    case InCompletedPage
}

//read mode
public enum AppReadModeState {
    case InitialState//you initialise by going to beginning
    case ResumeState//you resume reading
    case ReadingState//reading activates reading event when touch pointer is activated
    case PauseState//pause when finger is lifted 
    case CompletedState//complete, this is when you finished reading the page and touch pointer is not touched
    case FeedbackState//feedback when at end of the page
    case EndState//stop, reading has ended and you viewed your score
}

public enum AppReadModeEvent  {
    case Begin//go to start when initialised
    case ActivateReading//when finger in on touch pointer, you activate reading
    case Resume//this is to continue reading when paused
    case Failed//when something fails
    case Pause//when finger is lifted, you pause when its been less than 30 sec and false to all other ifs
    case End//when finger is lifted, you ended when its been more than 30 sec and true to all other ifs 
    case ActivateFeedback//activate feedback when completed
}

//image
public enum AppImageState {
    
    case ShowImageState
    case HideImageState
    
}
public enum AppImageEvent {
    
    case ShowImage
    case HideImage
    
}

//text
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

//phonics breakdown
public enum AppPhonicsAssistanceServicesState{
    case PhonicsAssistanceOn
    case PhonicsAssistanceOff
}

public enum AppPhonicsAssistanceServicesEvent{
    //Commands
    case doBlur(range: Range<Int>)
    case doZoomIn(duration: Double)
    case doZoomOut(duration: Double)
    case doFinish
    //Events
    case didTapWord(word: String, range: Range<Int>, rect: CGRect)
    case didBlur(range: Range<Int>)
    case zoomInComplete
    case zoomOutComplete
    case didFinish
    case didFail
}

//voice cursor/textborder/word highlighter
public enum AppVoiceCursorState{
    case UpdateTextRange//this is a rect
    case ShowVoiceCursor
    case HideVoiceCursor
}

public enum AppVoiceCursorEvent{
    //case UpdateTextRange//this is a rect
    case EnableVoiceCursor
    case DisableVoiceCursor
    case Animate
}

//voice recognition
public enum AppVoiceRecognitionState {
    case Inactive
    case Starting
    case Listening
    case DetectingSpeech
    case Suspending
    case Suspended
    case Resuming
    case Stopping
}

public enum AppVoiceRecognitionEvent  {
    // Events
    case RecognitionLoopDidStart
    case DidBeginStarting
    case DidStartListening
    case DidDetectSpeech
    case AvailableBuffer(NSData)
    case PartialHypothesis(String)
    //case FullHypothesis(VoiceRecognitionResult)
    case DidDetectFinishedSpeech
    case DidBeginSuspendRecognition
    case DidSuspendRecognition
    case DidResumeRecognition
    case DidChangeLanguageModel
    case DidBeginMuting
    case DidEndMuting
    case DidBeginStopListening
    case DidStopListening
    // Commands
    case StartListening(Void -> Void)
    case StopListening
    case Suspend
    case Resume
    case Mute
    
}


//voice feedback
public enum AppVoiceFeedbackState {
    
    case VoiceFeedbackOn
    case VoiceFeedbackOff
}
public enum AppVoiceFeedbackEvent {
    
    case Start
    case End
    case Failed
}


//finger pointer
public enum AppFingerPointerState{
    case GoToFirstWord
    case GoToFirstWordOnLatestSentence
    case GoToNextWord
    
    case StartedReading
    case DraggingHorizontal
    case DraggingToNextLine
    case ThrowingToNextLine
    case CompletedReading
    
    case ShowTouchPointer
    case HideTouchPointer
}

public enum AppFingerPointerEvent {
    case ReadingStarted 
    case WordSelected 
    case ReadingEnded
}




//feedback text
public enum AppFeedbackTextState {
    
    case FeedbackTextEnabled
    case FeedbackTextDisabled
}

public enum AppFeedbackTextEvent {
    
    case UpdateText
    case UpdateColor
    
}

//score
public enum AppScoreState {
    
    case UpdateScore
    case ResetScore
}

public enum AppScoreEvent {
    
    case AddPoints
    case RemovePoints
    
}






// MARK: AppState DOTLabelable extension
extension AppReadModeState: DOTLabelable {
    
    //func isSaving() -> Bool {
        //switch self {
        //case .Saving: return true
        //default: return false
        //}
    //}
   
    public static var DOTLabelableItems: [AppReadModeState] 
    {
        return [ .InitialState, .ResumeState, .ReadingState, .PauseState, .CompletedState, .FeedbackState, .EndState]
    }
    
    public var DOTLabel: String {
        switch self {
        case .InitialState: return "Initialising"
        case .ResumeState: return "Resuming"
        case .ReadingState: return "Reading"
        case .PauseState: return "Pausing"
        case .CompletedState: return "Completing"
        case .FeedbackState: return "Showing Feedback"
        case .EndState: return "Ending"
        }
    }
}

// MARK: AppEvent DOTLabelable extension
extension AppReadModeEvent: DOTLabelable 
{
    
    public static var DOTLabelableItems: [AppReadModeEvent] 
    {
        return [.Begin, .ActivateReading, .Failed, .Pause, .Resume, .End, .ActivateFeedback]
    }
    
    public var DOTLabel: String {
        switch self {
        case .Begin: return "Start"
        case .ActivateReading: return "Activate Reading"
        case .Failed: return "Failed"
        case .Pause: return "Pause"
        case .Resume: return "resume"
        case .End: return "End"
        case .ActivateFeedback: return "Activate Feedback"
        }
    }
}

// MARK: Add printable conformance
extension AppReadModeState : CustomStringConvertible {
    public var description: String { return self.DOTLabel }
}

extension AppReadModeState : CustomDebugStringConvertible {
    public var debugDescription: String { return "AppReadModeState.\(self.DOTLabel)" }
}

extension AppReadModeEvent : CustomStringConvertible {
    public var description: String { return self.DOTLabel }
}

extension AppReadModeEvent : CustomDebugStringConvertible {
    public var debugDescription: String { return "AppReadModeEvent.\(self.DOTLabel)" }
}


public typealias AppReadModeTransitionState = (AppReadModeState, AppReadModeEvent, AppReadModeState, UserState)

public struct AppReadModeTransition {
    public let oldState : AppReadModeState
    public let event : AppReadModeEvent
    public let newState : AppReadModeState
    public let userState : UserState
    
    public init(oldState: AppReadModeState, event: AppReadModeEvent, newState: AppReadModeState, userState: UserState) 
    {
        self.oldState = oldState
        self.event = event
        self.newState = newState
        self.userState = userState
    }
}

extension AppReadModeTransition : Equatable {}
public func == (lhs: AppReadModeTransition, rhs: AppReadModeTransition) -> Bool {
    let o = lhs.oldState == rhs.oldState
    let e = lhs.event == rhs.event 
    let n = lhs.newState == rhs.newState 
    let u = lhs.userState == rhs.userState 
    return o && e && n && u
}

extension AppReadModeTransition : CustomStringConvertible {
    public var description: String {
        return "AppTransition(oldState:\(self.oldState), event: \(self.event), newState: \(self.newState), userState: \(self.userState)"
    }
}

extension AppReadModeTransition :CustomDebugStringConvertible {
    public var debugDescription : String {
        return  "AppTransition(oldState:\(self.oldState), event: \(self.event), newState: \(self.newState), userState: \(self.userState)" 
    }
}


