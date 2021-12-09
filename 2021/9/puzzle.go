package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func inRange(arr []int, num int) bool {
	if num >= 0 && num < len(arr) {
		return true
	}
	return false
}

func inRangeM(arr [][]int, num int) bool {
	if num >= 0 && num < len(arr) {
		return true
	}
	return false
}

func main() {
	fmt.Println("Day 9: Smoke Basin")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var heights [][]int

	for scanner.Scan() {
		strRow := strings.Split(scanner.Text(), "")
		var row []int
		for _, d := range strRow {
			num, _ := strconv.ParseInt(d, 0, 64)
			row = append(row, int(num))
		}
		heights = append(heights, row)
	}

	var riskLevel int
	for i, row := range heights {
		for j, height := range row {
			if (!inRange(row, j-1) || height < row[j-1]) && (!inRange(row, j+1) || height < row[j+1]) && (!inRangeM(heights, i-1) || height < heights[i-1][j]) && (!inRangeM(heights, i+1) || height < heights[i+1][j]) {
				riskLevel += (height + 1)
			}
		}
	}

	fmt.Println(fmt.Sprintf("Part One: %d", riskLevel))
}
