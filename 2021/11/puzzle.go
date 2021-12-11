package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

const maxEnergy int = 9

func checkFlashes(octopuses [][]int, i int, j int, flashMap map[string]bool) int {
	if i < 0 || i >= len(octopuses) || j < 0 || j >= len(octopuses[i]) {
		return 0
	}
	coords := fmt.Sprintf("(%d, %d)", i, j)
	if flashMap[coords] {
		return 0
	}
	energy := octopuses[i][j]
	if energy == maxEnergy {
		flashMap[coords] = true
		octopuses[i][j] = 0
		f := 0
		f += checkFlashes(octopuses, i, j+1, flashMap)
		f += checkFlashes(octopuses, i+1, j+1, flashMap)
		f += checkFlashes(octopuses, i+1, j, flashMap)
		f += checkFlashes(octopuses, i+1, j-1, flashMap)
		f += checkFlashes(octopuses, i, j-1, flashMap)
		f += checkFlashes(octopuses, i-1, j-1, flashMap)
		f += checkFlashes(octopuses, i-1, j, flashMap)
		f += checkFlashes(octopuses, i-1, j+1, flashMap)
		return f + 1
	} else {
		octopuses[i][j] = energy + 1
		return 0
	}
}

func partOne(octopuses [][]int) {
	totalFlashes := 0
	for step := 1; step <= 100; step++ {
		flashMap := make(map[string]bool)
		for i, row := range octopuses {
			for j := range row {
				totalFlashes += checkFlashes(octopuses, i, j, flashMap)
			}
		}
		// fmt.Println(fmt.Sprintf("After step %d:", step))
		// for _, r := range octopuses {
		// 	fmt.Println(r)
		// }
	}
	fmt.Println(fmt.Sprintf("Part One: %d", totalFlashes))
}

func main() {
	fmt.Println("Day 6: Lanternfish")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var octopuses [][]int

	for scanner.Scan() {
		strRow := strings.Split(scanner.Text(), "")
		var row []int
		for _, x := range strRow {
			octopus, _ := strconv.Atoi(x)
			row = append(row, octopus)
		}
		octopuses = append(octopuses, row)
	}

	partOne(octopuses)
}
