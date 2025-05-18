
import Foundation

struct Tile {
    let tag: Int
    let imagesNumber: String
    var isChoiceMatches: Bool
    
}

struct Model {
    var tiles: [Tile] = []
    var score: Int = 0
    
    mutating func generaterTiles() {
        let imageNames = ["1", "2", "3", "4", "5", "6", "7", "8"]
        let pairNames = (imageNames + imageNames).shuffled()
        tiles = []
        score = 0
        for i in 0 ..< pairNames.count {
            let tile = Tile(tag: i, imagesNumber: pairNames[i], isChoiceMatches: false)
            tiles.append(tile)
        }
    }
    
    func returnTile (tag: Int) -> Tile? {
        for tile in tiles {
            if tile.tag == tag {
                return tile
            }
        }
        return nil
    }
    
    mutating func markMatched(firstTag: Int, secondTag: Int) {
        var firstIndex: Int? = nil
        var secondIndex: Int? = nil
        
        for (index, tile) in tiles.enumerated() {
            guard firstIndex == nil || secondIndex == nil else { break } // как только оба индекса не нил, выходим из цикла
            if tile.tag == firstTag {
                firstIndex = index
            }
            if tile.tag == secondTag {
                secondIndex = index
            }
        }
        if let firstIndex = firstIndex, let secondIndex = secondIndex {
            tiles[firstIndex].isChoiceMatches = true
            tiles[secondIndex].isChoiceMatches = true
            score += 1
        }
    }
}
