package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func partOne(directions [][]string) {
	var depth int = 0
	var distance int = 0

	for _, direction := range directions {
		num, _ := strconv.ParseInt(direction[1], 0, 64)
		command := direction[0]
		switch command {
		case "forward":
			distance += int(num)
		case "down":
			depth += int(num)
		case "up":
			depth -= int(num)
		}
	}

	fmt.Println(fmt.Sprintf("Part One: %d", depth*distance))
}

func partTwo(directions [][]string) {
	var aim int = 0
	var depth int = 0
	var distance int = 0

	for _, direction := range directions {
		num, _ := strconv.ParseInt(direction[1], 0, 64)
		command := direction[0]
		switch command {
		case "forward":
			distance += int(num)
			depth += (aim * int(num))
		case "down":
			aim += int(num)
		case "up":
			aim -= int(num)
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
