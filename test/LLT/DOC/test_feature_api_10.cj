// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

//2.1.2 示例
from oauth4cj import oauth4cj.*

let RANDOM_BYTES: Array<UInt8> = Array<UInt8>([116, 24, 223, 180, 151, 153,
            224, 37, 79, 250, 96, 125, 216, 173, 187, 186, 22, 212, 37, 77,
            105, 214, 191, 240, 91, 88, 5, 88, 83, 132, 141, 121])
main (){
    let pkce: PKCE = PKCEService.defaultInstance().generatePKCE(RANDOM_BYTES)
    let str0: String = pkce.getCodeChallengeMethod().toString()
    let str1: String = pkce.getCodeVerifier()
    let str2: String = pkce.getCodeChallenge()
    if(str0=="S256" && str1=="dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk" && str2=="E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM"){
        println(str0)
        println(str1)
        println(str2)
        return 0
    }
    return 1
}