// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

public import oauth4cj.*

main (){
    let bytes: Array<UInt8> = Array<UInt8>([116, 24, 223, 180, 151, 153,
                224, 37, 79, 250, 96, 125, 216, 173, 187, 186, 22, 212, 37, 77,
                105, 214, 191, 240, 91, 88, 5, 88, 83, 132, 141])
    let encoded: String = "dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjQ"
    let str: String = Base64Utils.encodeUrlWithoutPadding(bytes)
    println("encoded == str: ${encoded == str}")
    if (str != encoded) {
        println(1)
        return 1
    }
    return 0
}
