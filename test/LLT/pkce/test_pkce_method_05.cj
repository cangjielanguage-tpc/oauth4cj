
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

public import oauth4cj.*

main (){

    let str: String = testGeneratingPKCE(1000)
    let res: String = PKCECodeChallengeMethod.S256.transform2CodeChallenge(str)

    let result: String = "aP6cn0md0aa_B8b3N8K2qBGMyjeHczbuDyZ0IJVU08Y"
    println("res = ${res}")

    println("result == res: ${result == res}")
    if (result != res) {
        println(1)
        return 1
    }

    if (PKCECodeChallengeMethod.S256.toString() != "S256") {
        println(2)
        return 2
    }
    
    return 0
}

func testGeneratingPKCE(len: Int64): String {
    var str: String = ""
    var i: Int64 = 0
    while (i < len) {
        str += "s"
        i++
    }
    return str
}
