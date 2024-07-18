// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

public import oauth4cj.*

main (){

    let str: String = "dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk"
    let res: String = PKCECodeChallengeMethod.S256.transform2CodeChallenge(str)

    let result: String = "E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM"
    println("res = ${res}")

    println("result == res: ${result == res}")
    if (result != res) {
        println(1)
        return 1
    }

    if (PKCECodeChallengeMethod.S256.toString() != "S256") {
        return -1
    }
    
    return 0
}
