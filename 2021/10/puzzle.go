package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"sort"
	"strings"
)

type Stack []string

func (s *Stack) IsEmpty() bool {
	return len(*s) == 0
}

func (s *Stack) Push(str string) {
	*s = append(*s, str)
}

func (s *Stack) Pop() (string, bool) {
	if s.IsEmpty() {
		return "", false
	} else {
		index := len(*s) - 1
		element := (*s)[index]
		*s = (*s)[:index]
		return element, true
	}
}

func reverse(ss []string) {
	last := len(ss) - 1
	for i := 0; i < len(ss)/2; i++ {
		ss[i], ss[last-i] = ss[last-i], ss[i]
	}
}

func main() {
	fmt.Println("Day 10: Syntax Scoring")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)

	syntaxMap := map[string]string{"(": ")", "<": ">", "[": "]", "{": "}"}
	var errors []string
	var incomplete [][]string
	for scanner.Scan() {
		line := strings.Split(scanner.Text(), "")
		var openers Stack
		corrupt := false
		for _, char := range line {
			if syntaxMap[char] != "" {
				openers.Push(char)
			} else {
				top, _ := openers.Pop()
				if syntaxMap[top] != char {
					errors = append(errors, char)
					corrupt = true
					break
				}
			}
		}
		if !corrupt {
			reverse(openers)
			incomplete = append(incomplete, openers)
		}
	}

	pointMap := map[string]int{")": 3, ">": 25137, "]": 57, "}": 1197}
	score := 0
	for _, err := range errors {
		score += pointMap[err]
	}
	fmt.Println(fmt.Sprintf("Part One: %d", score))

	pointMap = map[string]int{")": 1, "]": 2, "}": 3, ">": 4}
	var scores []int
	for _, x := range incomplete {
		score := 0
		for _, opener := range x {
			points := pointMap[syntaxMap[opener]]
			score = score*5 + points
		}
		scores = append(scores, score)
	}
	sort.Ints(scores)
	why := len(scores) / 2
	middleIndex := math.Round(float64(why))
	fmt.Println(fmt.Sprintf("Part Two: %d", scores[int(middleIndex)]))
}
