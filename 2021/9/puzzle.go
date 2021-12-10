package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

const maxHeight int = 9

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

func partOne(heights [][]int) {
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

func mapBasins(heights [][]int, basins [][]int, basinNum int, i int, j int) ([][]int, int) {
	if !inRangeM(heights, i) || heights[i][j] == maxHeight {
		return basins, j
	}
	m := j
	for m-1 >= 0 && heights[i][m-1] != maxHeight {
		m--
	}
	for m < len(heights[i]) {
		if heights[i][m] != maxHeight && basins[i][m] == 0 {
			//fmt.Println(fmt.Sprintf("%d (%d, %d) is part of basin %d", heights[i][m], i, m, basinNum))
			basins[i][m] = basinNum
			basins, _ = mapBasins(heights, basins, basinNum, i+1, m)
			basins, _ = mapBasins(heights, basins, basinNum, i-1, m)
		} else {
			break
		}
		m++
	}
	return basins, m
}

func partTwo(heights [][]int) {
	basins := make([][]int, len(heights))
	for i := range basins {
		basins[i] = make([]int, len(heights[i]))
	}
	basinNum := 1

	for i, row := range heights {
		for j := 0; j < len(row); j++ {
			if heights[i][j] != maxHeight && basins[i][j] == 0 {
				basins, j = mapBasins(heights, basins, basinNum, i, j)
				basinNum++
			}
		}
	}

	basinSizeMap := make(map[int]int)
	for _, row := range basins {
		//fmt.Println(row)
		for _, num := range row {
			if num != 0 {
				basinSizeMap[num] += 1
			}
		}
	}
	var basinSizes []int
	for _, v := range basinSizeMap {
		basinSizes = append(basinSizes, v)
	}
	sort.Ints(basinSizes)
	//fmt.Println(basinSizes)
	l := len(basinSizes)
	fmt.Println(fmt.Sprintf("Part Two: %d", basinSizes[l-1]*basinSizes[l-2]*basinSizes[l-3]))
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
			num, _ := strconv.Atoi(d)
			row = append(row, num)
		}
		heights = append(heights, row)
	}

	partOne(heights)
	partTwo(heights)
}
