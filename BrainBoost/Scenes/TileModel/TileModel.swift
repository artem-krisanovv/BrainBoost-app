import UIKit

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
    
    func getSegmentValue(index: Int) -> Int {
        switch index {
        case 0:
            return 30
        case 1:
            return 20
        case 2:
            return 15
        default:
            return 30
        }
    }
}
