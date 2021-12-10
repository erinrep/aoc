package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

type entry struct {
	signalPattern []string
	output        []string
}

func partOne(entries []entry) {
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

func Union(a, b string) string {
	m := make(map[string]bool)
	var u []string

	for _, item := range strings.Split(a, "") {
		m[item] = true
	}

	for _, item := range strings.Split(b, "") {
		if m[item] {
			u = append(u, item)
		}
	}
	sort.Sort(sort.StringSlice(u))
	return strings.Join(u, "")
}

func partTwo(entries []entry) {
	var answers []int

	for _, e := range entries {
		digits := make(map[int]string)

		// add 1, 4, 7, 8 to the digits map
		for _, p := range e.signalPattern {
			length := len(p)
			letters := strings.Split(p, "")
			sort.Sort(sort.StringSlice(letters))
			index := 0
			if length == 2 {
				index = 1
			} else if length == 3 {
				index = 7
			} else if length == 4 {
				index = 4
			} else if length == 7 {
				index = 8
			}
			if index != 0 {
				digits[index] = strings.Join(letters, "")
			}
		}

		// figure out 0, 2, 3, 5, 6, 9 using 1 and 4
		for _, p := range e.signalPattern {
			length := len(p)
			letters := strings.Split(p, "")
			sort.Sort(sort.StringSlice(letters))
			str := strings.Join(letters, "")
			if length == 5 && Union(str, digits[1]) == digits[1] {
				digits[3] = str
			} else if length == 6 && Union(str, digits[4]) == digits[4] {
				digits[9] = str
			} else if length == 6 && Union(str, digits[1]) == digits[1] {
				digits[0] = str
			} else if length == 6 {
				digits[6] = str
			} else if length == 5 && len(Union(str, digits[4])) == 3 {
				digits[5] = str
			} else if length == 5 {
				digits[2] = str
			}
		}

		// translate the output
		var answer []string
		for _, output := range e.output {
			letters := strings.Split(output, "")
			sort.Sort(sort.StringSlice(letters))
			str := strings.Join(letters, "")
			for k, v := range digits {
				if v == str {
					answer = append(answer, strconv.Itoa(k))
				}
			}
		}
		value, _ := strconv.Atoi(strings.Join(answer, ""))
		answers = append(answers, value)
	}

	//calculate the total of all the translated outputs
	total := 0
	for _, n := range answers {
		total += n
	}
	fmt.Println(fmt.Sprintf("Part Two: %d", total))
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

	partOne(entries)
	partTwo(entries)
}
