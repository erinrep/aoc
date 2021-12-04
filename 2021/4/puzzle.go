package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type card struct {
	numbers      [][]string
	rowCounts    [5]int
	columnCounts [5]int
}

func contains(nums []int, val int) bool {
	for _, v := range nums {
		if v == val {
			return true
		}
	}

	return false
}

func main() {
	fmt.Println("Day 4: Giant Squid")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var cards []card
	var cardNums [][]string
	var numbers []string
	i := 0

	for scanner.Scan() {
		line := scanner.Text()
		if i == 0 {
			numbers = strings.Split(line, ",")
		} else if line != "" {
			cardNums = append(cardNums, strings.Fields(line))
		} else if len(cardNums) > 0 {
			cards = append(cards, card{numbers: cardNums})
			cardNums = nil
		}
		i++
	}
	cards = append(cards, card{numbers: cardNums})

	var winningCard [][]string
	var winningNum int64
	for _, n := range numbers {
		for cardNum, c := range cards {
			for y, row := range c.numbers {
				for x, num := range row {
					if n == num {
						c.rowCounts[y] += 1
						c.columnCounts[x] += 1
						c.numbers[y][x] = "X"
						cards[cardNum] = c
					}
				}
			}
			if contains(c.columnCounts[:], 5) || contains(c.rowCounts[:], 5) {
				winningCard = c.numbers
				winningNum, _ = strconv.ParseInt(n, 0, 64)
				break
			}
		}
		if winningCard != nil {
			break
		}
	}
	var score int64 = 0
	for _, row := range winningCard {
		for _, s := range row {
			if s != "X" {
				n, _ := strconv.ParseInt(s, 0, 64)
				score += n
			}
		}
	}
	fmt.Println(fmt.Sprintf("Part One: %d", score*winningNum))
}
