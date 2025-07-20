package main

import (
	"encoding/json"
	"net/http"
	"net/url"
	"strings"
	"os"
	"io"
)

type Emoji struct {
	Value string `json:"emoji"`
	Description string
	Categories []string `json:"category"`
}

const OUTPUT_FILE string = "emojis_zipped"
const URL string = "https://codebeautify.org/randomData"



func main() {
	zip(download())
}

func download() []byte {
	data := url.Values{}
	data.Set("type", "emoji")

	resp, err := http.PostForm(URL, data)
	if err != nil {
		panic(err.Error())
	}
	defer resp.Body.Close()
	
	if body, err := io.ReadAll(resp.Body); err != nil {
		panic(err.Error())
	} else {
		return body
	}
}

func zip(body []byte) {
	output := getFile()
	defer output.Close()

	var emojis []Emoji

	if err := json.Unmarshal(body, &emojis); err != nil {
		panic(err.Error())
	}

	var sb strings.Builder

	for _, e := range emojis {
		sb.WriteString(e.Value)
	}

	output.WriteString(sb.String())
}

func getFile() *os.File {
	if output, err := os.Create(OUTPUT_FILE); err != nil {
		panic("Cannot write file: " + err.Error())
	} else {
		return output
	}
}

