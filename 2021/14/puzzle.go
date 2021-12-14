package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func insertPairs(sequence []string, rules map[string]string) []string {
	var newSequence []string
	for i, letter := range sequence {
		newSequence = append(newSequence, letter)
		if i < len(sequence)-1 {
			pair := fmt.Sprintf("%s%s", letter, sequence[i+1])
			newSequence = append(newSequence, rules[pair])
		}
	}
	return newSequence
}

func main() {
	fmt.Println("Day 14: Extended Polymerization")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	rules := make(map[string]string)
	var template []string
	delim := " -> "

	for scanner.Scan() {
		line := scanner.Text()
		if strings.Contains(line, delim) {
			pair := strings.Split(line, delim)
			rules[pair[0]] = pair[1]
		} else if line != "" {
			template = strings.Split(line, "")
		}
	}

	var sequence []string
	sequence = insertPairs(template, rules)
	for i := 0; i < 9; i++ {
		sequence = insertPairs(sequence, rules)
	}

	elems := make(map[string]int)
	for _, l := range sequence {
		elems[l]++
	}
	leastCommon := "B"
	mostCommon := "B"
	for k, v := range elems {
		if v < elems[leastCommon] {
			leastCommon = k
		}
		if v > elems[mostCommon] {
			mostCommon = k
		}
	}

	fmt.Println(fmt.Sprintf("Part One: %d", elems[mostCommon]-elems[leastCommon]))
}
