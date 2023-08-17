// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import fs.*

from oauth4cj import services.*
from oauth4cj import commons.*
from oauth4cj import exceptions.*

main() {
    var test_01 = testRSASha1SignatureServiceGetSignature03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}

func testRSASha1SignatureServiceGetSignature03(): Int64 {
    let rsss = RSASha1SignatureService("./common_Values.pem")
    var flag: Int64 = 1
    try{
        rsss.getSignature("baseString","apiSecret","tokenSecret")
    }catch(e:OAuth4cjSignatureException){
        println(e.toString())
        let err: String = "Error while signing string: baseString: The file does not exist"
        println("e.message = ${e.message}")
        if(e.message.contains(err) && e.toString().contains("baseString") &&
                e.toString().contains("The file does not exist")){
            flag = 0
        }
    }
    return flag
}
