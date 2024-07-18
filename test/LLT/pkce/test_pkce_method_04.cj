
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

public import oauth4cj.*

main (){

    let str: String = " "
    let res: String = PKCECodeChallengeMethod.S256.transform2CodeChallenge(str)

    let result: String = "Nqnn8clbgv-5l0PgxcTOldg8mkMKrFn4TvPL-rYUUGg"
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
