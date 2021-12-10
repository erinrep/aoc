package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

func smallest(arr []int) int {
	smallest := arr[0]
	for _, n := range arr {
		if n < smallest {
			smallest = n
		}
	}
	return smallest
}

func triangleNumber(n int) int {
	if n == 0 {
		return 0
	}
	return n + triangleNumber(n-1)
}

func partOne(positions []int, min int, max int) {
	var totals []int
	for i := min; i <= max; i++ {
		total := 0
		for _, p := range positions {
			total += int(math.Abs(float64(p - i)))
		}
		totals = append(totals, total)
	}
	fmt.Println(fmt.Sprintf("Part One: %d", smallest(totals)))
}

func partTwo(positions []int, min int, max int) {
	var totals []int
	for i := min; i <= max; i++ {
		total := 0
		for _, p := range positions {
			total += triangleNumber(int(math.Abs(float64(p - i))))
		}
		totals = append(totals, total)
	}
	fmt.Println(fmt.Sprintf("Part Two: %d", smallest(totals)))
}

func main() {
	fmt.Println("Day 7: The Treachery of Whales")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var strPositions []string
	scanner.Scan()
	strPositions = strings.Split(scanner.Text(), ",")

	var positions []int
	minPosition := 0
	maxPosition := 0
	for _, p := range strPositions {
		n, _ := strconv.Atoi(p)
		if n > maxPosition {
			maxPosition = n
		}
		if n < minPosition {
			minPosition = n
		}
		positions = append(positions, n)
	}

	partOne(positions, minPosition, maxPosition)
	partTwo(positions, minPosition, maxPosition)
}
