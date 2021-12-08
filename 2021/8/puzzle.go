package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

type entry struct {
	signalPattern []string
	output        []string
}

func main() {
	fmt.Println("Day 8: Seven Segment Search")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var entries []entry

	for scanner.Scan() {
		line := strings.Split(scanner.Text(), " | ")
		entries = append(entries, entry{signalPattern: strings.Fields(line[0]), output: strings.Fields(line[1])})
	}

	total := 0
	for _, e := range entries {
		for _, output := range e.output {
			length := len(output)
			if length == 2 || length == 3 || length == 4 || length == 7 {
				total++
			}
		}
	}

	fmt.Println(fmt.Sprintf("Part One: %d", total))
}
