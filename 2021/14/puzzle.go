package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func insertPairs(sequence []string, rules map[string]string, elems map[string]int) []string {
	var newSequence []string
	for i, letter := range sequence {
		newSequence = append(newSequence, letter)
		if i < len(sequence)-1 {
			pair := fmt.Sprintf("%s%s", letter, sequence[i+1])
			newSequence = append(newSequence, rules[pair])
			elems[rules[pair]]++
		}
	}
	return newSequence
}

func leastAndMostCommon(elems map[string]int) (string, string) {
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

	return leastCommon, mostCommon
}

func partOne(sequence []string, rules map[string]string, cycles int) int {
	elems := make(map[string]int)
	for _, l := range sequence {
		elems[l]++
	}

	for i := 0; i < cycles; i++ {
		sequence = insertPairs(sequence, rules, elems)
	}

	leastCommon, mostCommon := leastAndMostCommon(elems)
	return elems[mostCommon] - elems[leastCommon]
}

func partTwo(sequence []string, rules map[string]string, cycles int) int {
	elems := make(map[string]int)
	for _, l := range sequence {
		elems[l]++
	}

	pairs := make(map[string]int)
	for i, l := range sequence {
		if i < len(sequence)-1 {
			pair := fmt.Sprintf("%s%s", l, sequence[i+1])
			pairs[pair]++
		}
	}

	for i := 0; i < cycles; i++ {
		newPairs := make(map[string]int)
		for k, v := range pairs {
			if v != 0 {
				letters := strings.Split(k, "")
				elems[rules[k]] += v
				p1 := fmt.Sprintf("%s%s", letters[0], rules[k])
				p2 := fmt.Sprintf("%s%s", rules[k], letters[1])
				newPairs[p1] += v
				newPairs[p2] += v
				pairs[k] -= v
			}
		}
		for k, v := range newPairs {
			pairs[k] += v
		}
	}

	leastCommon, mostCommon := leastAndMostCommon(elems)
	return elems[mostCommon] - elems[leastCommon]
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

	fmt.Println(fmt.Sprintf("Part One: %d", partOne(template, rules, 10)))
	fmt.Println(fmt.Sprintf("Part Two: %d", partTwo(template, rules, 40)))
}
