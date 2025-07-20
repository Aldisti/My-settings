
package main

import (
	"math/rand/v2"
	_ "embed"
	"fmt"
)

//go:embed emojis_zipped
var emojis string

func main() {
	emojis := []rune(emojis)
	fmt.Println(string(emojis[rand.IntN(len(emojis))]))
}

