// DEPENDENCE: ./gitee_api_test.cj
// EXEC: cjc %import-path %L %l %f ./gitee_api_test.cj
// EXEC: ./main

from std import collection.*
from std import io.*

from oauth4cj import httpclient.multipart.*
from oauth4cj import httpclient.*
from oauth4cj import oauth.*
from oauth4cj import builder.*
from oauth4cj import pkce.*
from oauth4cj import revoke.*
from oauth4cj import extractors.*
from oauth4cj import exceptions.*
from oauth4cj import util.*

from okhttp import okhttp.*

//将这些替换为您的客户端id和机密
let clientId: String = "your client id"
let clientSecret: String = "your client secret"

//替换成自己需要的权限范围
let SCOP: String = "user_info emails"

main() {

    let debugStream: OutputStream = ByteArrayStream()

    let service: OAuth20Service = ServiceBuilderOAuth20(clientId).
                                  setApiSecret(clientSecret).
                                  setDefaultScope(SCOP).
                                  setCallback("http://www.example.com/oauth_callback/").
                                  build(GiteeApiTest.instance())

    let test_01 = testOAuth20Service_15(service)
    if (test_01 != 0){
        println(test_01)
        return test_01
    }

    return test_01
}

func testOAuth20Service_15(service: OAuth20Service): Int32 {
    try {
        let res: Future<OAuth2AccessToken> = service.getAccessTokenClientCredentialsGrantAsync()
        res.get()
    } catch (e: Exception) {
        //e.printStackTrace()
        return 0
    }
    return 1
}
