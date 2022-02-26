//
//  PlayerQuit.swift
//  
//
//  Created by Nathan Fallet on 26/02/2022.
//

import Foundation
import SwiftMC

public class PlayerQuit: EventListener {
    
    override public func onPlayerQuit(event: PlayerQuitEvent) {
        Replica.instance.uninitPlayer(uuid: event.player.getUUID())
    }
    
}
