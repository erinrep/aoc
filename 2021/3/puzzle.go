package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	fmt.Println("Day 3: Binary Diagnostic")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var diagnostics [][]string

	for scanner.Scan() {
		diagnostics = append(diagnostics, strings.Split(scanner.Text(), ""))
	}

	var gammaRate []string
	var epsilonRate []string
	for i := 0; i < len(diagnostics[0]); i++ {
		ones := 0
		zeros := 0
		for _, d := range diagnostics {
			if d[i] == "1" {
				ones++
			} else {
				zeros++
			}
		}
		if ones > zeros {
			gammaRate = append(gammaRate, "1")
			epsilonRate = append(epsilonRate, "0")
		} else {
			gammaRate = append(gammaRate, "0")
			epsilonRate = append(epsilonRate, "1")
		}
	}
	gammaRateDecimal, _ := strconv.ParseInt(strings.Join(gammaRate, ""), 2, 64)
	epsilonRateDecimal, _ := strconv.ParseInt(strings.Join(epsilonRate, ""), 2, 64)

	fmt.Println(fmt.Sprintf("Part One: %d", gammaRateDecimal*epsilonRateDecimal))
}
