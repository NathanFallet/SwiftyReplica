//
//  main.swift
//  
//
//  Created by Nathan Fallet on 26/02/2022.
//

import Foundation
import SwiftMC
import SwiftyReplica

// Initialize a server
let server = SwiftMC()

// Load the plugin
Replica.instance.enable(server: server)

// And start it
DispatchQueue.global().async {
    server.start()
    exit(0)
}

// Read commands from console
while let input = readLine(strippingNewline: true) {
    server.dispatchCommand(command: input)
}
