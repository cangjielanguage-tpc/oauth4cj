// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

public import oauth4cj.*

main () {
    let pkce: PKCE = PKCEService().generatePKCE()
    
    let str00: String = pkce.getCodeChallengeMethod().toString()
    let str01: String = pkce.getCodeVerifier()
    let str02: String = pkce.getCodeChallenge()

    let str10: String = "S256"
    let str11: String = ""
    let str12: String = ""

    if (str00 != str10) {
        println(1)
        return 1
    }

    println("str01 = ${str01}")
    if (str01 == str11) {
        println(2)
        return 2
    }
    println("str02 = ${str02}")
    if (str02 == str12) {
        println(3)
        return 3
    }

    return 0
}