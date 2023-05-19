// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import fs.*

from oauth4cj import services.*
from oauth4cj import utils.*
from oauth4cj import exceptions.*

main() {
    var test_01 = testRSASha1SignatureServiceGetSignature04()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}

/***
    public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String
    测试场景:秘钥文件路径文件存在，但是文件内容为空
***/

func testRSASha1SignatureServiceGetSignature04(): Int64 {
    var file01 = File("priKey.pem",OpenOption.CreateOrTruncate(true))
    let rsss=RSASha1SignatureService("priKey.pem")
    var flag: Int64 = 1
    try{
        rsss.getSignature("baseString","apiSecret","tokenSecret")
    }catch(e:OAuth4cjSignatureException){
        println(e.toString())
        if(e.toString().contains("baseString") &&
                e.toString().contains("Please check the key")){
            flag = 0
        }
    }
    file01.close()
    File.delete("priKey.pem")

    return flag
}
