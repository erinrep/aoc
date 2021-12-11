package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

const maxEnergy int = 9

func outOfRange(octopuses [][]int, i int, j int) bool {
	if i < 0 || i >= len(octopuses) || j < 0 || j >= len(octopuses[i]) {
		return true
	}
	return false
}

func checkFlashes(octopuses [][]int, i int, j int, flashMap map[string]bool) {
	if outOfRange(octopuses, i, j) {
		return
	}
	coords := fmt.Sprintf("(%d, %d)", i, j)
	if flashMap[coords] {
		return
	}
	energy := octopuses[i][j]
	if energy == maxEnergy {
		flashMap[coords] = true
		octopuses[i][j] = 0
		checkFlashes(octopuses, i, j+1, flashMap)
		checkFlashes(octopuses, i+1, j+1, flashMap)
		checkFlashes(octopuses, i+1, j, flashMap)
		checkFlashes(octopuses, i+1, j-1, flashMap)
		checkFlashes(octopuses, i, j-1, flashMap)
		checkFlashes(octopuses, i-1, j-1, flashMap)
		checkFlashes(octopuses, i-1, j, flashMap)
		checkFlashes(octopuses, i-1, j+1, flashMap)
	} else {
		octopuses[i][j] = energy + 1
	}
}

func partOne(octopuses [][]int) {
	totalFlashes := 0
	for step := 1; step <= 100; step++ {
		flashMap := make(map[string]bool)
		for i, row := range octopuses {
			for j := range row {
				checkFlashes(octopuses, i, j, flashMap)
			}
		}
		totalFlashes += len(flashMap)
		// fmt.Println(fmt.Sprintf("After step %d:", step))
		// for _, r := range octopuses {
		// 	fmt.Println(r)
		// }
	}
	fmt.Println(fmt.Sprintf("Part One: %d", totalFlashes))
}

func partTwo(octopuses [][]int) {
	step := 1
	for {
		flashMap := make(map[string]bool)
		for i, row := range octopuses {
			for j := range row {
				checkFlashes(octopuses, i, j, flashMap)
			}
		}
		if len(flashMap) == 100 {
			break
		}
		step++
	}
	fmt.Println(fmt.Sprintf("Part Two: %d", step))
}

func main() {
	fmt.Println("Day 11: Dumbo Octopus")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var octopuses [][]int
	var octopuses2 [][]int

	for scanner.Scan() {
		strRow := strings.Split(scanner.Text(), "")
		var row []int
		var row2 []int
		for _, x := range strRow {
			octopus, _ := strconv.Atoi(x)
			row = append(row, octopus)
			row2 = append(row2, octopus)
		}
		octopuses = append(octopuses, row)
		octopuses2 = append(octopuses2, row2)
	}

	partOne(octopuses)
	partTwo(octopuses2)
}
