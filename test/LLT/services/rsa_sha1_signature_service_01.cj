// DEPENDENCE: ./key.pem
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from encoding import base64.*

from oauth4cj import services.*
from oauth4cj import utils.*

public func testPlaintextSignatureService_01(rsa: RSASha1SignatureService): Int32 {

    let str: String = rsa.getSignatureMethod()
    let result: String = "RSA-SHA1"

    if (!str.equals(result)) {
        println(1)
        return 1
    }

    let bytes: Array<UInt8> = Array<UInt8>(
        [45, 67, 81, 205, 0, 37, 165, 211, 114, 51, 217, 139, 94, 111, 122, 85, 174, 160, 254, 165, 77,
        156, 64, 27, 238, 158, 202, 212, 163, 52, 131, 194, 40, 164, 225, 80, 36, 250, 14, 59, 183, 47,
        166, 152, 45, 239, 13, 208, 202, 24, 163, 88, 153, 194, 154, 250, 151, 105, 162, 0, 26, 186, 175,
        119, 42, 247, 124, 140, 193, 80, 184, 124, 15, 248, 153, 65, 67, 75, 50, 45, 60, 24, 35, 128, 223,
        131, 252, 213, 112, 111, 177, 206, 192, 230, 226, 99, 60, 59, 6, 132, 152, 54, 51, 58, 21, 39, 201,
        214, 38, 21, 63, 148, 195, 36, 225, 207, 118, 75, 85, 134, 178, 71, 168, 14, 135, 209, 194, 154])

    let str1: String = Base64Utils.encode(bytes)
    println("str1 = ${str1}")

    return 0
}

public func testPlaintextSignatureService_02(rsa: RSASha1SignatureService): Int32 {
    let apiSecret: String = "api secret"
    let tokenSecret: String = "token secret"
    let baseString: String = "base string"

    let signature: String = "LUNRzQAlpdNyM9mLXm96Va6g/qVNnEAb7p7K1KM0g8IopOFQJPoOO7cvppgt7w3QyhijWJnCmvqXaaIAGrqvd" +
                    "yr3fIzBULh8D/iZQUNLMi08GCOA34P81XBvsc7A5uJjPDsGhJg2MzoVJ8nWJhU/lMMk4c92S1WGskeoDofRwpo="

    let str: String = rsa.getSignature(baseString, apiSecret, tokenSecret)
    println("str = ${str}")

    if (!str.equals(signature)) {
        println(2)
        return 2
    }

    return 0
}

main() {

    let str: String = "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMPQ5BCMxlUq2TYy\n" +
                    "iRIoEUsz6HGTJhHuasS2nx1Se4Co3lxwxyubVdFj8AuhHNJSmJvjlpbTsGOjLZpr\n" +
                    "HyDEDdJmf1Fensh1MhUnBZ4a7uLrZrKzFHHJdamX9pxapB89vLeHlCot9hVXdrZH\n" +
                    "nNtg6FdmRKH/8gbs8iDyIayFvzYDAgMBAAECgYA+c9MpTBy9cQsR9BAvkEPjvkx2\n" +
                    "XL4ZnfbDgpNA4Nuu7yzsQrPjPomiXMNkkiAFHH67yVxwAlgRjyuuQlgNNTpKvyQt\n" +
                    "XcHxffnU0820VmE23M+L7jg2TlB3+rUnEDmDvCoyjlwGDR6lNb7t7Fgg2iR+iaov\n" +
                    "0iVzz+l9w0slRlyGsQJBAPWXW2m3NmFgqfDxtw8fsKC2y8o17/cnPjozRGtWb8LQ\n" +
                    "g3VCb8kbOFHOYNGazq3M7+wD1qILF2h/HecgK9eQrZ0CQQDMHXoJMfKKbrFrTKgE\n" +
                    "zyggO1gtuT5OXYeFewMEb5AbDI2FfSc2YP7SHij8iQ2HdukBrbTmi6qxh3HmIR58\n" +
                    "I/AfAkEA0Y9vr0tombsUB8cZv0v5OYoBZvCTbMANtzfb4AOHpiKqqbohDOevLQ7/\n" +
                    "SpvgVCmVaDz2PptcRAyEBZ5MCssneQJAB2pmvaDH7Ambfod5bztLfOhLCtY5EkXJ\n" +
                    "n6rZcDbRaHorRhdG7m3VtDKOUKZ2DF7glkQGV33phKukErVPUzlHBwJAScD9TqaG\n" +
                    "wJ3juUsVtujV23SnH43iMggXT7m82STpPGam1hPfmqu2Z0niePFo927ogQ7H1EMJ\n" +
                    "UHgqXmuvk2X/Ww=="

    let opArr: Option<Array<UInt8>> = fromBase64String(str)
    let arr2: Array<UInt8> = match (opArr) {
        case Some(s) =>
            println("s = ${s}")
            s
        case None =>
            println("空！")
            Array<UInt8>()
    }
    let str2: String = String.fromUtf8(arr2)
    println("str2 = ${str2}")
    //println("arr2 = ${arr2}")


    let rsa: RSASha1SignatureService = RSASha1SignatureService("./key.pem")

    var test_01 = testPlaintextSignatureService_01(rsa)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    test_01 = testPlaintextSignatureService_02(rsa)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}