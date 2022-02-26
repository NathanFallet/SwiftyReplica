//
//  GameState.swift
//  
//
//  Created by Nathan Fallet on 26/02/2022.
//

import Foundation

public enum GameState {
    
    case waiting, startCount, inGame, finished
    
    public var message: String {
        switch self {
        case .waiting:
            return Messages.statWaiting.rawValue
        case .startCount:
            return Messages.statStartCount.rawValue
        case .inGame:
            return Messages.statStartCount.rawValue
        case .finished:
            return Messages.statFinished.rawValue
        }
    }
    
}
