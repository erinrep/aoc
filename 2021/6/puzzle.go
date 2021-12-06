package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type ventLine struct {
	x1 int64
	x2 int64
	y1 int64
	y2 int64
}

func main() {
	fmt.Println("Day 6: Lanternfish")

	file, _ := os.Open("input.txt")
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var rawFish []string
	var fish []int64

	for scanner.Scan() {
		rawFish = strings.Split(scanner.Text(), ",")
	}
	for _, f := range rawFish {
		n, _ := strconv.ParseInt(f, 0, 64)
		fish = append(fish, n)
	}

	numDays := 80
	var babyFishCycle int64 = 8
	var resetFishCycle int64 = 6
	for d := 0; d < numDays; d++ {
		var newFish []int64
		for i, f := range fish {
			if f == 0 {
				newFish = append(newFish, babyFishCycle)
				fish[i] = resetFishCycle
			} else {
				fish[i] = f - 1
			}
		}
		fish = append(fish, newFish...)
	}
	fmt.Println(fmt.Sprintf("Part One: %d", len(fish)))
}
