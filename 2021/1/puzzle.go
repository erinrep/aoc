package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func numIncreases(nums []int64) int {
	increased := 0
	for i, d := range nums {
		if i > 0 && d > nums[i-1] {
			increased++
		}
	}
	return increased
}

func partOne(depths []int64) {
	fmt.Println(fmt.Sprintf("Part One: %d", numIncreases(depths)))
}

func partTwo(depths []int64) {
	var windows []int64

	for i, d := range depths {
		if i < len(depths)-2 {
			windows = append(windows, d+depths[i+1]+depths[i+2])
		}
	}

	fmt.Println(fmt.Sprintf("Part Two: %d", numIncreases(windows)))
}

func main() {
	fmt.Println("Day 1: Sonar Sweep")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var depths []int64

	for scanner.Scan() {
		current, _ := strconv.ParseInt(scanner.Text(), 0, 64)
		depths = append(depths, current)
	}

	partOne(depths)
	partTwo(depths)
}