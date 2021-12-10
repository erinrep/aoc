package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

const babyFishCycle int = 8
const resetFishCycle int = 6
const cycles int = 9

func sum(arr [cycles]int) int {
	sum := 0
	for _, x := range arr {
		sum += x
	}
	return sum
}

func runFishSpawningSim(fish [9]int, numDays int) int {
	for d := 0; d < numDays; d++ {
		numNewFish := fish[0]
		for i := 0; i < babyFishCycle; i++ {
			fish[i] = fish[i+1]
		}
		fish[babyFishCycle] = numNewFish
		fish[resetFishCycle] += numNewFish
	}
	return sum(fish)
}

func main() {
	fmt.Println("Day 6: Lanternfish")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var rawFish []string
	var fish [cycles]int

	for scanner.Scan() {
		rawFish = strings.Split(scanner.Text(), ",")
	}
	for _, f := range rawFish {
		n, _ := strconv.Atoi(f)
		fish[n] += 1
	}

	p1 := runFishSpawningSim(fish, 80)
	fmt.Println(fmt.Sprintf("Part One: %d", p1))

	p2 := runFishSpawningSim(fish, 256)
	fmt.Println(fmt.Sprintf("Part Two: %d", p2))
}
