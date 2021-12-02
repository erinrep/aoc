package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	fmt.Println("Day 2: Dive!")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var depth int64 = 0
	var distance int64 = 0

	for scanner.Scan() {
		direction := strings.Split(scanner.Text(), " ")
		num, _ := strconv.ParseInt(direction[1], 0, 64)
		command := direction[0]
		if command == "forward" {
			distance += num
		} else if command == "down" {
			depth += num
		} else {
			depth -= num
		}
	}

	fmt.Println(depth * distance)
}
