package main

import (
  "os/exec"
  "log"
  "net/http"
)

func startBrowser(){
	err := exec.Command("rundll32", "url.dll,FileProtocolHandler", "http://localhost:8070/index.html").Start()
	if err != nil {
		log.Fatal(err)
	}
}

func main() {
  fs := http.FileServer(http.Dir("."))
  http.Handle("/", fs)

  log.Println("Listening on :8070...")
  go startBrowser()
  err := http.ListenAndServe(":8070", nil)
  if err != nil {
    log.Fatal(err)
  }
}