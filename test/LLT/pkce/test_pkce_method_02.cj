// EXEC: cjc %import-path %L %l %f
// EXEC: ./main


import encoding.base64.*
public import oauth4cj.*

main () {
    let str: String = "dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk"
    let res: String = PKCECodeChallengeMethod.PLAIN.transform2CodeChallenge(str)

    println("res = ${res}")
    if (res != str) {
        return -1
    }

    if (PKCECodeChallengeMethod.PLAIN.toString() != "PLAIN") {
        return -1
    }

    return 0
}