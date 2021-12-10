package main

import (
	"bufio"
	"fmt"
	"os"
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

func main() {
	fmt.Println("Day 10: Syntax Scoring")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)

	syntaxMap := map[string]string{"(": ")", "<": ">", "[": "]", "{": "}"}
	var errors []string
	for scanner.Scan() {
		line := strings.Split(scanner.Text(), "")
		var openers Stack
		for _, char := range line {
			if syntaxMap[char] != "" {
				openers.Push(char)
			} else {
				top, _ := openers.Pop()
				if syntaxMap[top] != char {
					errors = append(errors, char)
					break
				}
			}
		}
	}

	pointMap := map[string]int{")": 3, ">": 25137, "]": 57, "}": 1197}
	score := 0
	for _, err := range errors {
		score += pointMap[err]
	}

	fmt.Println(fmt.Sprintf("Part One: %d", score))
}
