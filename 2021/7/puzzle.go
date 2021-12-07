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
		n, _ := strconv.ParseInt(p, 0, 64)
		if int(n) > maxPosition {
			maxPosition = int(n)
		}
		if int(n) < minPosition {
			minPosition = int(n)
		}
		positions = append(positions, int(n))
	}

	var totals []int
	for i := minPosition; i <= maxPosition; i++ {
		total := 0
		for j := 0; j < len(positions); j++ {
			total += int(math.Abs(float64(positions[j] - i)))
		}
		totals = append(totals, total)
	}
	fmt.Println(fmt.Sprintf("Part One: %d", smallest(totals)))
}
