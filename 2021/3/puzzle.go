package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func partOne(diagnostics [][]string) {
	var gammaRate []string
	var epsilonRate []string
	for i := 0; i < len(diagnostics[0]); i++ {
		ones, zeros := numBitsInPosition(diagnostics, i)
		if ones > zeros {
			gammaRate = append(gammaRate, "1")
			epsilonRate = append(epsilonRate, "0")
		} else {
			gammaRate = append(gammaRate, "0")
			epsilonRate = append(epsilonRate, "1")
		}
	}
	gammaRateDecimal, _ := strconv.ParseInt(strings.Join(gammaRate, ""), 2, 0)
	epsilonRateDecimal, _ := strconv.ParseInt(strings.Join(epsilonRate, ""), 2, 0)

	fmt.Println(fmt.Sprintf("Part One: %d", gammaRateDecimal*epsilonRateDecimal))
}

func numBitsInPosition(bits [][]string, position int) (int, int) {
	ones := 0
	zeros := 0
	for _, b := range bits {
		if b[position] == "1" {
			ones++
		} else {
			zeros++
		}
	}
	return ones, zeros
}

func matchingBitsInPosition(vals [][]string, position int, toMatch string) [][]string {
	var newVals [][]string
	for _, x := range vals {
		if toMatch == x[position] {
			newVals = append(newVals, x)
		}
	}
	return newVals
}

func partTwo(diagnostics [][]string) {
	var oxygenGeneratorRating [][]string = diagnostics
	var co2ScrubberRating [][]string = diagnostics
	var ones = 0
	var zeros = 0
	for i := 0; i < len(diagnostics[0]); i++ {
		oxygenGeneratorRatingToMatch := "0"
		ones, zeros = numBitsInPosition(oxygenGeneratorRating, i)
		if ones >= zeros {
			oxygenGeneratorRatingToMatch = "1"
		}
		if len(oxygenGeneratorRating) > 1 {
			oxygenGeneratorRating = matchingBitsInPosition(oxygenGeneratorRating, i, oxygenGeneratorRatingToMatch)
		}

		co2ScrubberRatingToMatch := "0"
		ones, zeros = numBitsInPosition(co2ScrubberRating, i)
		if ones < zeros {
			co2ScrubberRatingToMatch = "1"
		}
		if len(co2ScrubberRating) > 1 {
			co2ScrubberRating = matchingBitsInPosition(co2ScrubberRating, i, co2ScrubberRatingToMatch)
		}
	}
	ogr, _ := strconv.ParseInt(strings.Join(oxygenGeneratorRating[0], ""), 2, 0)
	co2sr, _ := strconv.ParseInt(strings.Join(co2ScrubberRating[0], ""), 2, 0)
	fmt.Println(fmt.Sprintf("Part Two: %d", ogr*co2sr))
}

func main() {
	fmt.Println("Day 3: Binary Diagnostic")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var diagnostics [][]string

	for scanner.Scan() {
		diagnostics = append(diagnostics, strings.Split(scanner.Text(), ""))
	}

	partOne(diagnostics)
	partTwo(diagnostics)
}
