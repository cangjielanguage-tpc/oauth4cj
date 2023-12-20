// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import oauth4cj.*

let RANDOM_BYTES: Array<UInt8> = Array<UInt8>([116, 24, 223, 180, 151, 153,
            224, 37, 79, 250, 96, 125, 216, 173, 187, 186, 22, 212, 37, 77,
            105, 214, 191, 240, 91, 88, 5, 88, 83, 132, 141, 121])

main (){
    let pkce: PKCE = PKCEService.defaultInstance().generatePKCE(RANDOM_BYTES)

    let str00: String = pkce.getCodeChallengeMethod().toString()
    let str01: String = pkce.getCodeVerifier()
    let str02: String = pkce.getCodeChallenge()

    let str10: String = "S256"
    let str11: String = "dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk"
    let str12: String = "E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM"

    println("str00 == str10: ${str00 == str10}")
    println("str01 == str11: ${str01 == str11}")
    println("str02 == str12: ${str02 == str12}")
    if (str00 != str10) {
        println(str00)
        println(str10)
        println(1)
        return 1
    }
    if (str01 != str11) {
        println(2)
        println(str01)
        println(str11)
        return 2
    }
    if (str02 != str12) {
        println(3)
        println(str02)
        println(str12)
        return 3
    }

    return 0
}
