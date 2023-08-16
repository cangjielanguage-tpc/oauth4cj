// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import fs.*

from oauth4cj import services.*
from oauth4cj import commons.*
from oauth4cj import exceptions.*

main() {
    var test_01 = testRSASha1SignatureServiceGetSignature06()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}

/***
    public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String
    测试场景:私钥文件路径结尾是.pem,但文件内容非正常私钥文件
***/
func testRSASha1SignatureServiceGetSignature06(): Int64 {
    var file01 = File("priKey.pem",OpenOption.CreateOrTruncate(true))
    file01.write("hello cangjie".toUtf8Array())
    file01.close()
    file01 = File("priKey.pem",OpenOption.CreateOrTruncate(true))
    let rsss=RSASha1SignatureService("priKey.pem")
    var flag: Int64 = 1
    try{
        rsss.getSignature("baseString","apiSecret","tokenSecret")
    }catch(e:OAuth4cjSignatureException){
        println(e.toString())
        if(e.toString().contains("baseString") &&
                e.toString().contains("Illegal RSA Private key")){
            flag = 0
        }
    }
    file01.close()
    File.delete("priKey.pem")

    return flag
}
