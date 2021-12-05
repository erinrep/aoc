package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type ventLine struct {
	x1 int64
	x2 int64
	y1 int64
	y2 int64
}

func main() {
	fmt.Println("Day 5: Hydrothermal Venture")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var ventLines []ventLine
	var maxX int64 = 0
	var maxY int64 = 0

	for scanner.Scan() {
		coord := strings.Split(scanner.Text(), " -> ")
		one := strings.Split(coord[0], ",")
		two := strings.Split(coord[1], ",")
		x1, _ := strconv.ParseInt(one[0], 0, 64)
		y1, _ := strconv.ParseInt(one[1], 0, 64)
		x2, _ := strconv.ParseInt(two[0], 0, 64)
		y2, _ := strconv.ParseInt(two[1], 0, 64)
		vl := ventLine{x1: x1, x2: x2, y1: y1, y2: y2}
		ventLines = append(ventLines, vl)
		if x1 > maxX {
			maxX = x1
		}
		if x2 > maxX {
			maxX = x2
		}
		if y1 > maxY {
			maxY = y1
		}
		if y2 > maxY {
			maxY = y2
		}
	}

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
		}
		if isVertical {
			start := line.y1
			end := line.y2
			if line.y1 > line.y2 {
				start = line.y2
				end = line.y1
			}
			for i := start; i <= end; i++ {
				ventMap[i][line.x1] += 1
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

	fmt.Println(fmt.Sprintf("Part One: %d", danger))
}
