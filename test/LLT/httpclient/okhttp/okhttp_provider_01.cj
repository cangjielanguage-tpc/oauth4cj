// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*
from oauth4cj import httpclient.multipart.*
from oauth4cj import httpclient.*

from httpclient4cj import httpclient4cj.*

type OAuth4cjHttpClient = oauth4cj.httpclient.HttpClient

main() {

    var test_01 = testOkHttpProvider_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOkHttpProvider_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

public func testOkHttpProvider_01(): Int32 {
    let bp: OkHttpProvider = OkHttpProvider()
    let config: OkHttpHttpClientConfig = OkHttpHttpClientConfig.defaultConfig()
    let client: Option<OAuth4cjHttpClient> = bp.createClient(config)
    match(client) {
        case Some(v) => println(v is OkHttpHttpClient)
        case None =>
            println(1)
            return 1
    }
    return 0
}

public func testOkHttpProvider_02(): Int32 {
    let bp: OkHttpProvider = OkHttpProvider()
    let config: HttpClientConfig = DefaultHttpClientConfig()
    let client: Option<OAuth4cjHttpClient> = bp.createClient(config)
    match(client) {
        case Some(v) =>
            println(v is OkHttpHttpClient)
            println(2)
            return 2
        case None => ()
    }
    return 0
}

class DefaultHttpClientConfig <: HttpClientConfig {

    init(){ }

    public func createDefaultConfig(): HttpClientConfig {
        return this
    }
}
