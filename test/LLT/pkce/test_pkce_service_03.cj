// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import pkce.*

main () {
    let pkce: PKCE = PKCEService(0).generatePKCE()
    let str00: String = pkce.getCodeChallengeMethod().toString()
    let str01: String = pkce.getCodeVerifier()
    let str02: String = pkce.getCodeChallenge()

    let str10: String = "PLAIN"
    let str11: String = ""
    let str12: String = ""

    if (!str00.equals(str10)) {
        println(1)
        return 1
    }
    if (!str01.equals(str11)) {
        println(2)
        return 2
    }
    if (!str02.equals(str12)) {
        println(3)
        return 3
    }

    return 0
}