//
//  ReplicaGenerator.swift
//  
//
//  Created by Nathan Fallet on 26/02/2022.
//

import Foundation
import SwiftMC

public class ReplicaGenerator: WorldGenerator {
    
    public func generateBiomes(world: LocalWorld, random: Random, chunkX: Int32, chunkZ: Int32) -> [Int8] {
        return [Int8](repeating: 1, count: 256)
    }
    
    public func generateChunkData(world: LocalWorld, random: Random, chunkX: Int32, chunkZ: Int32, biomes: [Int8]) -> WorldChunkData {
        let chunkData = WorldChunkData(world: world)
        
        if chunkX >= 0 && chunkX % Replica.distance == 0 && chunkZ % 2 == 0 && chunkZ >= 0 && chunkZ < 40 {
            for x: Int32 in 2 ..< 16 {
                for z: Int32 in 3 ..< 15 {
                    chunkData.setBlock(x: x, y: 63, z: z, material: .wood)
                    chunkData.setBlock(x: x, y: 64, z: z, material: .wood)
                    if z == 3 || z == 14 || x == 2 {
                        //chunkData.setBlock(x: x, y: 65, z: z, material: .fence)
                    }
                }
            }
            for y: Int32 in 0 ..< 11 {
                for z: Int32 in 4 ..< 14 {
                    chunkData.setBlock(x: 14, y: 64 + y, z: z, material: .wood)
                    chunkData.setBlock(x: 15, y: 64 + y, z: z, material: .wood)
                }
            }
        }
        
        return chunkData
    }
    
    public func getName() -> String {
        return "replica"
    }
    
}
