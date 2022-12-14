import UIKit

let fileURL = Bundle.main.url(forResource: "input14", withExtension: "")
let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: .newlines)

let dataSize = (x: 800, y: 170)
var data = Array(repeating: Array(repeating: ".", count: dataSize.x), count: dataSize.y)
for line in lines {
    let instructions = line.components(separatedBy: " -> ")
    for (index, instruction) in instructions.prefix(upTo: instructions.count-1).enumerated() {
        let xStart = Int(instruction.components(separatedBy: ",")[0])!
        let yStart = Int(instruction.components(separatedBy: ",")[1])!
        let xEnd = Int(instructions[index+1].components(separatedBy: ",")[0])!
        let yEnd = Int(instructions[index+1].components(separatedBy: ",")[1])!
        var x = xStart
        var y = yStart
        data[y][x] = "#"
        while x != xEnd || y != yEnd {
            if xEnd - xStart != 0 {
                x = x + (xEnd - xStart) / abs(xEnd - xStart)
            }
            if yEnd - yStart != 0 {
                y = y + (yEnd - yStart) / abs(yEnd - yStart)
            }
            data[y][x] = "#"
        }
    }
}

func moveSand(position: (x: Int, y: Int)) -> (x: Int, y: Int)? {
    if position.y+1 >= data.count {
        return (x: position.x, y: Int.max)
    }
    for pos in [(x: position.x, y: position.y + 1),
                (x: position.x - 1, y: position.y + 1),
                (x: position.x + 1, y: position.y + 1)] {
        if data[pos.y][pos.x] == "." {
            return pos
        }
    }
    return nil
}

//Part one
/*
var sandIndex = 1
outerLoop: while true {
    var sandPos = (x: 500, y: 0)
    while let newPosition = moveSand(position: (x: sandPos.x, y: sandPos.y)) {
        sandPos = newPosition
        
        if sandPos.y == Int.max {
            print("\(sandIndex) Fell through!")
            break outerLoop
        }
    }
    
    data[sandPos.y][sandPos.x] = "o"
    sandIndex += 1
}*/


//Part two
var maxRock = 0
for y in 0..<data.count {
    for x in 0..<data[0].count {
        if data[y][x] == "#" {
            maxRock = max(maxRock, y)
        }
    }
}
data[maxRock+2] = Array(repeating: "#", count: dataSize.x)
maxRock

var sandIndex = 1
outerLoop: while true {
    var sandPos = (x: 500, y: 0)
    while let newPosition = moveSand(position: (x: sandPos.x, y: sandPos.y)) {
        sandPos = newPosition
    }
    
    data[sandPos.y][sandPos.x] = "o"
    
    if sandPos == (x: 500, y: 0) {
        print("Sand hit home! (\(sandIndex))")
        break outerLoop
    }
    
    print(sandPos)
    sandIndex += 1
}
