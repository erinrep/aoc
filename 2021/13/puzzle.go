package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

type Coordinate struct {
	x int
	y int
}

type Fold struct {
	axis string
	num  int
}

func fold(paper [][]bool, fold Fold) [][]bool {
	h := len(paper)
	w := len(paper[0])

	if fold.axis == "x" {
		w = fold.num
	} else if fold.axis == "y" {
		h = fold.num
	}

	newPaper := make([][]bool, h)
	for i := range newPaper {
		newPaper[i] = make([]bool, w)
	}

	for i, row := range paper {
		for j := range row {
			if fold.axis == "x" {
				if j != fold.num {
					jCalc := j
					if j >= w {
						jCalc = int(math.Abs(float64(j - (w * 2))))
					}
					if paper[i][j] {
						newPaper[i][jCalc] = true
					}
				}
			} else {
				if i != fold.num {
					iCalc := i
					if i >= h {
						iCalc = int(math.Abs(float64(i - (h * 2))))
					}
					if paper[i][j] {
						newPaper[iCalc][j] = true
					}
				}
			}
		}
	}

	return newPaper
}

func printPaper(paper [][]bool) {
	for _, row := range paper {
		var stringRow []string
		for _, val := range row {
			char := "."
			if val {
				char = "#"
			}
			stringRow = append(stringRow, char)
		}
		fmt.Println(stringRow)
	}
}

func main() {
	fmt.Println("Day 13: Transparent Origami")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var instructions []Coordinate
	var folds []Fold
	maxX := 0
	maxY := 0

	for scanner.Scan() {
		line := scanner.Text()
		if line != "" {
			if strings.Contains(line, "=") {
				fold := strings.Split(strings.ReplaceAll(line, "fold along ", ""), "=")
				num, _ := strconv.Atoi(fold[1])
				folds = append(folds, Fold{axis: fold[0], num: num})
			} else {
				coord := strings.Split(line, ",")
				y, _ := strconv.Atoi(coord[0])
				x, _ := strconv.Atoi(coord[1])
				instructions = append(instructions, Coordinate{x: x, y: y})
				if x > maxX {
					maxX = x
				}
				if y > maxY {
					maxY = y
				}
			}
		}
	}

	paper := make([][]bool, maxX+1)
	for i := range paper {
		paper[i] = make([]bool, maxY+1)
	}
	for _, instruction := range instructions {
		paper[instruction.x][instruction.y] = true
	}

	folded := fold(paper, folds[0])
	total := 0
	for _, row := range folded {
		for _, val := range row {
			if val {
				total++
			}
		}
	}
	fmt.Println(fmt.Sprintf("Part One: %d", total))

	for i := 1; i < len(folds); i++ {
		folded = fold(folded, folds[i])
	}
	fmt.Println("Part Two:")
	printPaper(folded)
}
