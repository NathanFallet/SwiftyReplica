//
//  File.swift
//  
//
//  Created by Nathan Fallet on 26/02/2022.
//

import Foundation
import SwiftMC

public class ReplicaCmd: Command {
    
    public func execute(server: SwiftMC, sender: CommandSender, args: [String]) {
        if args.count > 0 {
            if args.first == "goto" {
                //if sender.hasPermission("replica.admin") {
                if let player = sender as? Player {
                    if let world = server.worlds.first(where: { $0.getName() == "Replica" }) {
                        player.sendMessage(message: "§a\(Messages.cmdGotoSuccess.rawValue)")
                        player.goTo(world: world)
                    }
                } else {
                    sender.sendMessage(message: "§c\(Messages.cmdErrorNotAPlayer.rawValue)")
                }
                //} else {
                //sender.sendMessage(message: "§c\(Messages.cmdErrorPerm.rawValue)")
                //}
            } else if args.first == "buildmode" {
                //if sender.hasPermission("replica.admin") {
                if let player = sender as? Player, let zp = Replica.instance.players.first(where: { $0.uuid == player.getUUID() }) {
                    zp.buildmode = !zp.buildmode
                    player.sendMessage(message: "§a\(zp.buildmode ? Messages.cmdBuildmodeEnable.rawValue : Messages.cmdBuildmodeDisable.rawValue)")
                } else {
                    sender.sendMessage(message: "§c\(Messages.cmdErrorNotAPlayer.rawValue)")
                }
                //} else {
                //sender.sendMessage(message: "§c\(Messages.cmdErrorPerm.rawValue)")
                //}
            } else if args.first == "leave" {
                if let player = sender as? Player, let zp = Replica.instance.players.first(where: { $0.uuid == player.getUUID() }) {
                    if zp.currentGame != 0 {
                        zp.currentGame = 0
                        zp.playing = false
                        zp.finished = false
                        zp.plot = 0
                        server.dispatchCommand(sender: player, command: "spawn") // TODO: Get spawn command from config
                        player.setGameMode(to: .survival)
                        // TODO: Clear inventory
                    } else {
                        sender.sendMessage(message: "§c\(Messages.chatNoGame)")
                    }
                } else {
                    sender.sendMessage(message: "§c\(Messages.cmdErrorNotAPlayer.rawValue)")
                }
            } else {
                sendHelp(sender: sender)
            }
        } else {
            sendHelp(sender: sender)
        }
    }
    
    public func description() -> String {
        return "Management of Replica"
    }
    
    public func sendHelp(sender: CommandSender) {
        //if sender.hasPermission("replica.admin") {
        //sender.sendMessage(message: "§6/replica goto: §e\(Messages.cmdHelpGoto.rawValue)")
        //sender.sendMessage(message: "§6/replica buildmode: §e\(Messages.cmdHelpBuildmode.rawValue)")
        //}
        sender.sendMessage(message: "§6/replica leave: §e\(Messages.cmdHelpLeave.rawValue)")
    }
    
}
