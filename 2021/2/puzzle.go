package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func partOne(directions [][]string) {
	var depth int64 = 0
	var distance int64 = 0

	for _, direction := range directions {
		num, _ := strconv.ParseInt(direction[1], 0, 64)
		command := direction[0]
		switch command {
		case "forward":
			distance += num
		case "down":
			depth += num
		case "up":
			depth -= num
		}
	}

	fmt.Println(fmt.Sprintf("Part One: %d", depth*distance))
}

func partTwo(directions [][]string) {
	var aim int64 = 0
	var depth int64 = 0
	var distance int64 = 0

	for _, direction := range directions {
		num, _ := strconv.ParseInt(direction[1], 0, 64)
		command := direction[0]
		switch command {
		case "forward":
			distance += num
			depth += (aim * num)
		case "down":
			aim += num
		case "up":
			aim -= num
		}
	}

	fmt.Println(fmt.Sprintf("Part Two: %d", depth*distance))
}

func main() {
	fmt.Println("Day 2: Dive!")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var directions [][]string
	for scanner.Scan() {
		directions = append(directions, strings.Fields(scanner.Text()))
	}

	partOne(directions)
	partTwo(directions)
}
