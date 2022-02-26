//
//  Replica.swift
//  
//
//  Created by Nathan Fallet on 26/02/2022.
//

import Foundation
import SwiftMC
import NIO

public class Replica {
    
    public static let instance = Replica()
    public static let distance: Int32 = 5
    public static let countdown = 30
    
    private let eventLoopGroup: EventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
    public private(set) var players = [ZabriPlayer]()
    public private(set) var pictures = [Picture]()
    public private(set) var games = [Game]()
    
    public func initPlayer(player: Player) {
        players.append(ZabriPlayer(player: player))
    }
    
    public func uninitPlayer(uuid: String) {
        players.removeAll(where: { $0.uuid == uuid })
    }
    
    public func getRandomPicture() -> Picture? {
        return pictures.randomElement()
    }
    
    public func joinPlayer(player: Player, game: Game) {
        if game.state == .waiting || game.state == .startCount {
            if game.getPlayers().count < 10 {
                players.first(where: { $0.uuid == player.getUUID() })?.currentGame = game.id
                player.sendMessage(message: "§a\(Messages.chatGameJoin.rawValue.replacingOccurrences(of: "%d", with: "\(game.id)"))")
            } else {
                player.sendMessage(message: "§c\(Messages.chatGameFull)")
            }
        } else {
            player.sendMessage(message: "§c\(Messages.chatGameInGame)")
        }
    }
    
    public func enable(server: SwiftMC) {
        server.registerWorldGenerator(generator: ReplicaGenerator())
        server.registerLocalWorld(name: "Replica", generator: "replica")
        
        for player in server.players {
            initPlayer(player: player)
        }
        
        games.removeAll()
        games.append(Game(id: 1))
        for game in games {
            game.loadPlots(in: server)
        }
        
        pictures.removeAll()
        pictures.append(Picture(name: "test", blocks: [:]))
        
        server.registerListener(listener: PlayerJoin())
        server.registerListener(listener: PlayerQuit())
        //...
        
        server.registerCommand("replica", command: ReplicaCmd())
        
        eventLoopGroup.next().scheduleRepeatedTask(initialDelay: TimeAmount.seconds(1), delay: TimeAmount.seconds(1)) { task in
            for game in self.games {
                if game.state == .inGame {
                    game.verifNext()
                } else {
                    if game.state == .waiting && game.getPlayers().count > 1 {
                        game.state = .startCount
                        game.currentCountValue = Replica.countdown + 1
                    }
                    if game.state == .startCount && game.getPlayers().count < 2 {
                        game.state = .waiting
                        game.currentCountValue = 0
                    }
                    if game.state == .startCount {
                        game.currentCountValue = game.currentCountValue - 1
                        if game.currentCountValue == 0 {
                            game.start()
                        } else if game.currentCountValue == 60 || game.currentCountValue == 30 || game.currentCountValue == 20 || game.currentCountValue == 10 || game.currentCountValue <= 5 {
                            // TODO: Show title in middle of screen (PacketType.Play.Server.TITLE)
                            for player in game.getPlayers() {
                                server.getPlayer(uuid: player.uuid)?.sendMessage(message: "§e\(Messages.chatStartCount.rawValue.replacingOccurrences(of: "%d", with: "\(game.currentCountValue)"))")
                            }
                        }
                    }
                }
                
                let scoreboard = [
                    "§b",
                    "§b§l\(Messages.sbPlayers)",
                    "§f\(game.getPlayers().count)/10",
                    "§a",
                    "§a§l\(Messages.sbStatus)",
                    "§f\(game.state.message.replacingOccurrences(of: "%d", with: "\(game.currentCountValue)"))",
                    "§e",
                    "§e§lPlugin by ZabriCraft"
                ]
            }
        }
    }
    
}
