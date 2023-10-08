// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

//1.9.2 示例
from oauth4cj import oauth4cj.*

main (){

    let ose: OAuth4cjSignatureException = OAuth4cjSignatureException()
    let ose2: OAuth4cjException = OAuth4cjSignatureException("ceshi-1")
    if(!ose.message.contains("")){
        return 1
    }
    if(!ose2.message.contains("Error while signing string: ceshi-1")){
        return 2
    }
    println(ose2.message.contains("Error while signing string: ceshi-1"))
    let ope: OAuth4cjParametersMissingException = OAuth4cjParametersMissingException()
    let ope2: OAuth4cjException = OAuth4cjParametersMissingException("ceshi-2")
    if(!ope.message.contains("")){
        return 3
    }
    if(!ope2.message.contains("ceshi-2")){
        return 4
    }
    println(ope2.message.contains("ceshi-2"))
    return 0
}