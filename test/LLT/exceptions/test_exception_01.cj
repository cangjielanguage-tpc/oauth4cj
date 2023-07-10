// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import exceptions.*

main (){

    let ose: OAuth4cjSignatureException = OAuth4cjSignatureException()
    let ose2: OAuth4cjException = OAuth4cjSignatureException("ceshi-1")
    var flag: Bool = ose is OAuth4cjException
    if (!ose.message.isEmpty() || !flag) {
        println(1)
        return 1
    }
    println("ose2.message = ${ose2.message}")
    if (!ose2.message.contains("Error while signing string: ceshi-1")) {
        println(2)
        return 2
    }

    let ope: OAuth4cjParametersMissingException = OAuth4cjParametersMissingException()
    let ope2: OAuth4cjException = OAuth4cjParametersMissingException("ceshi-2")
    flag = ope is OAuth4cjException
    if (!ope.message.isEmpty() || !flag) {
        println(3)
        return 3
    }
    println("ope2.message = ${ope2.message}")
    println("ope2.message.equals(ceshi-2) = ${ope2.message.equals("ceshi-2")}")
    if (!ope2.message.contains("ceshi-2")) {
        println(4)
        return 4
    }

    return 0
}
