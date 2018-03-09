package main

// #include "main.h"
import "C"
// Attention!!! There must be no blank line between include and import!!!

import "fmt"

func main() {

    fmt.Println(C.test())
    fmt.Println(C.testText(), "\n")

    fmt.Println(int(C.test()))
    fmt.Println(C.GoString(C.testText()))

}
