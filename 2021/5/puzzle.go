package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type ventLine struct {
	x1 int
	x2 int
	y1 int
	y2 int
}

func findDanger(ventLines []ventLine, maxX int, maxY int, includePart2 bool) {
	ventMap := make([][]int, maxX+1)
	for i := range ventMap {
		ventMap[i] = make([]int, maxY+1)
	}

	for _, line := range ventLines {
		isVertical := line.x1 == line.x2
		isHorizontal := line.y1 == line.y2

		if isHorizontal {
			start := line.x1
			end := line.x2
			if line.x1 > line.x2 {
				start = line.x2
				end = line.x1
			}
			for i := start; i <= end; i++ {
				ventMap[line.y1][i] += 1
			}
		} else if isVertical {
			start := line.y1
			end := line.y2
			if line.y1 > line.y2 {
				start = line.y2
				end = line.y1
			}
			for i := start; i <= end; i++ {
				ventMap[i][line.x1] += 1
			}
		} else if includePart2 {
			startX := line.x1
			startY := line.y1
			endX := line.x2
			endY := line.y2
			var incX int = 1
			var incY int = 1
			if startX > endX && startY > endY {
				startX = line.x2
				endX = line.x1
				startY = line.y2
				endY = line.y1
			} else if startX < endX && startY > endY {
				incY = -1
			} else if startX > endX && startY < endY {
				startX = line.x2
				endX = line.x1
				startY = line.y2
				endY = line.y1
				incY = -1
			}
			i := startX
			j := startY
			for {
				ventMap[j][i] += 1
				i += incX
				j += incY
				if i > endX {
					break
				}
			}
		}
	}

	danger := 0
	for _, row := range ventMap {
		//fmt.Println(row)
		for _, p := range row {
			if p >= 2 {
				danger++
			}
		}
	}

	part := "One"
	if includePart2 {
		part = "Two"
	}
	fmt.Println(fmt.Sprintf("Part %s: %d", part, danger))
}

func main() {
	fmt.Println("Day 5: Hydrothermal Venture")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var ventLines []ventLine
	var maxX int = 0
	var maxY int = 0

	for scanner.Scan() {
		coord := strings.Split(scanner.Text(), " -> ")
		one := strings.Split(coord[0], ",")
		two := strings.Split(coord[1], ",")
		x1, _ := strconv.Atoi(one[0])
		y1, _ := strconv.Atoi(one[1])
		x2, _ := strconv.Atoi(two[0])
		y2, _ := strconv.Atoi(two[1])
		vl := ventLine{x1: x1, x2: x2, y1: y1, y2: y2}
		ventLines = append(ventLines, vl)
		if vl.x1 > maxX {
			maxX = vl.x1
		}
		if vl.x2 > maxX {
			maxX = vl.x2
		}
		if vl.y1 > maxY {
			maxY = vl.y1
		}
		if vl.y2 > maxY {
			maxY = vl.y2
		}
	}

	findDanger(ventLines, maxX, maxY, false)
	findDanger(ventLines, maxX, maxY, true)
}
