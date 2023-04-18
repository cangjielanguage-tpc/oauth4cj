// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import pkce.*

from encoding import base64.*
from oauth4cj import utils.*

main () {
    let str: String = "dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk"
    let res: String = PKCECodeChallengeMethod.PLAIN.transform2CodeChallenge(str)

    println("res = ${res}")
    if (!res.equals(str)) {
        return -1
    }

    if (!PKCECodeChallengeMethod.PLAIN.toString().equals("PLAIN")) {
        return -1
    }

    return 0
}