//
//  Messages.swift
//  
//
//  Created by Nathan Fallet on 26/02/2022.
//

import Foundation

enum Messages: String {
    
    case sbPlayers = "Players:"
    case sbStatus = "Status:"
    case cmdHelpGoto = "Go in the Replica world"
    case cmdHelpBuildmode = "Enable/Disable the buildmode"
    case cmdHelpLeave = "Leave a game"
    case cmdErrorPerm = "You don't have the permission &4replica.admin &cto use this command!"
    case cmdErrorNotAPlayer = "You have to be a player to do that command!"
    case cmdErrorOnlyLeave = "You can only use the &4/replica leave &ccommand in a game!"
    case cmdGotoSuccess = "You were teleported in the Replica world!"
    case cmdBuildmodeEnable = "You enable the buildmode"
    case cmdBuildmodeDisable = "You disable the buildmode"
    case signErrorPerm = "You don't have the permission &4replica.admin &cto use this sign!"
    case signErrorInvalidLine = "Please use a valid game number in the second line!"
    case signLineGame = "Game %d"
    case reloadMsg = "RELOAD = The game will stop!"
    case statWaiting = "Waiting..."
    case statStartCount = "Start in %ds"
    case statInGame = "In game..."
    case statFinished = "Finished"
    case chatStartCount = "The game will start in %d seconds"
    case chatGameJoin = "You join the game number %d"
    case chatGameFull = "This game is already full!"
    case chatGameInGame = "This game is already started!"
    case chatNoGame = "You aren't in a game!"
    case chatWinPublic = "&e%s &7won the Replica game!"
    case chatWinPrivate = "You won the game!"
    case chatLosePublic = "&e%s &7was eradicated of the game!"
    case chatLosePrivate = "You were eradicated!"
    case chatUseLeave = "Please use &e/replica leave &7to leave the game."
    
}
