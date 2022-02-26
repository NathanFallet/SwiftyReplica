//
//  Game.swift
//  
//
//  Created by Nathan Fallet on 26/02/2022.
//

import Foundation
import SwiftMC

public class Game {
    
    public private(set) var id: Int
    public private(set) var signs: [Location]
    public var state: GameState
    public var currentCountValue: Int
    
    public init(id: Int) {
        self.id = id
        self.state = .waiting
        self.currentCountValue = 0
        self.signs = []
    }
    
    public func updateSigns() {
        // TODO
    }
    
    public func getPlayers() -> [ZabriPlayer] {
        return Replica.instance.players.filter { player in
            player.currentGame == id &&
            ((state != .inGame && state != .finished) || player.playing) &&
            !player.buildmode
        }
    }
    
    public func getAllPlayers() -> [ZabriPlayer] {
        return Replica.instance.players.filter { player in
            player.currentGame == id &&
            !player.buildmode
        }
    }
    
    public func loadPlots(in server: SwiftMC) {
        let world = server.worlds.first(where: { $0.getName() == "Replica" })
        
        for i in 0 ..< 20 {
            for x in 5 ..< 13 {
                for z in 5 ..< 13 {
                    //new Location(Bukkit.getWorld("Replica"), x + Replica.distance * 16 * (id - 1), 64, z + i * 32)
                        //.getBlock().setType(Material.AIR);
                }
            }
            for y in 8 ..< 8 {
                for z in 5 ..< 13 {
                    //new Location(Bukkit.getWorld("Replica"), 14 + Replica.distance * 16 * (id - 1), 66 + y, z + i * 32)
                        //.getBlock().setType(Material.AIR);
                }
            }
        }
    }
    
    public func breakPlot(col: Int) {
        let col = col - 1
        for y in 0 ..< 8 {
            for z in 5 ..< 13 {
                //new Location(Bukkit.getWorld("Replica"), 14 + Replica.DISTANCE * 16 * (id - 1), 66 + (7 - y), z + col * 32)
                    //.getBlock().setType(Material.AIR);
                //b.setType(makeClay(p.getBlock(z - 5, y)));
            }
        }
    }
    
    public func drawPlot(col: Int, picture: Picture) {
        let col = col - 1
        for y in 0 ..< 8 {
            for z in 5 ..< 13 {
                //Block b = new Location(Bukkit.getWorld("Replica"), 14 + Replica.DISTANCE * 16 * (id - 1), 66 + (7 - y), z + col * 32).getBlock();
                //b.setType(makeClay(p.getBlock(z - 5, y)));
            }
        }
    }
    
    public func isCompletingPlot(col: Int) -> Bool {
        let col = col - 1
        for x in 0 ..< 8 {
            for y in 0 ..< 8 {
                //Location b = new Location(Bukkit.getWorld("Replica"), 14 + Replica.DISTANCE * 16 * (id - 1),
                    //66 + (7 - y), (7 - x) + col * 32 + 5);
                //Location b2 = new Location(Bukkit.getWorld("Replica"), 5 + (7 - y) + Replica.DISTANCE * 16 * (id - 1),
                    //64, (7 - x) + col * 32 + 5);
                //if (!b.getBlock().getType().equals(b2.getBlock().getType())) {
                    //return false
                //}
            }
        }
        return true
    }
    
    public func containsColor(col: Int, color: Int) -> Bool {
        let col = col - 1
        for x in 0 ..< 8 {
            for y in 0 ..< 8 {
                //Location b = new Location(Bukkit.getWorld("Replica"), 14 + Replica.DISTANCE * 16 * (id - 1),
                    //66 + (7 - y), (7 - x) + col * 32 + 5);
                //if (b.getBlock().getType().equals(makeClay(color))) {
                    //return true
                //}
            }
        }
        return false
    }
    
    public func start() {
        for player in getPlayers() {
            player.playing = true
        }
        state = .inGame
        loadDraw()
    }
    
    public func stop(in server: SwiftMC) {
        if state == .inGame {
            state  = .finished
            if let zp = getPlayers().first, let player = server.players.first(where: { $0.getUUID() == zp.uuid }) {
                server.broadcast(packet: Chat(message: "§7\(Messages.chatWinPublic.rawValue.replacingOccurrences(of: "%s", with: player.getName()))"))
                // TODO: Clear inventory
                player.setGameMode(to: .spectator)
                // TODO: Send title packet
                // TODO: Call reward commands
            }
            currentCountValue = 0
            loadPlots(in: server)
            // TODO: End game
        }
    }
    
    public func loadDraw() {
        
    }
    
    public func verifNext() {
        
    }
    
    public func draw(picture: Picture, limit: Int) {
        for i in 1 ... limit {
            drawPlot(col: i, picture: picture)
        }
    }
    
}
