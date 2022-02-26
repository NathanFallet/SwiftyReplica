//
//  PlayerJoin.swift
//  
//
//  Created by Nathan Fallet on 26/02/2022.
//

import Foundation
import SwiftMC

public class PlayerJoin: EventListener {
    
    override public func onPlayerJoin(event: PlayerJoinEvent) {
        Replica.instance.initPlayer(player: event.player)
    }
    
}
