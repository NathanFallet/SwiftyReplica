//
//  ZabriPlayer.swift
//  
//
//  Created by Nathan Fallet on 26/02/2022.
//

import Foundation
import SwiftMC

public class ZabriPlayer {
    
    public private(set) var uuid: String
    public var currentGame = 0
    public var buildmode = false
    public var playing = false
    public var finished = false
    public var plot = 0
    
    public init(player: Player) {
        self.uuid = player.getUUID()
    }
    
}
