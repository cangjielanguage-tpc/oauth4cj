// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.*
from oauth4cj import httpclient.multipart.*
from oauth4cj import httpclient.*

from httpclient4cj import httpclient4cj.*

type OAuth4cjHttpClient = oauth4cj.httpclient.HttpClient

main() {

    var test_01 = testOkHttpHttpClientConfig_01()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOkHttpHttpClientConfig_02()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    test_01 = testOkHttpHttpClientConfig_03()
    if (test_01 != 0){
        println(test_01)
        return test_01
    }
    return test_01
}

public func testOkHttpHttpClientConfig_01(): Int32 {
    let bp: OkHttpProvider = OkHttpProvider()
    let config: OkHttpHttpClientConfig = OkHttpHttpClientConfig(httpclient4cj.HttpClient.builder())
    let client: Option<OAuth4cjHttpClient> = bp.createClient(config)
    match(client) {
        case Some(v) => println(v is OkHttpHttpClient)
        case None =>
            println(1)
            return 1
    }
    return 0
}

public func testOkHttpHttpClientConfig_02(): Int32 {
    let bp: OkHttpProvider = OkHttpProvider()
    let config: OkHttpHttpClientConfig = OkHttpHttpClientConfig.defaultConfig()
    let config2: OkHttpHttpClientConfig = config.createDefaultConfig()
    let client: Option<OAuth4cjHttpClient> = bp.createClient(config2)
    match(client) {
        case Some(v) => println(v is OkHttpHttpClient)
        case None =>
            println(2)
            return 2
    }
    return 0
}

public func testOkHttpHttpClientConfig_03(): Int32 {
    let bp: OkHttpProvider = OkHttpProvider()
    let config: OkHttpHttpClientConfig = OkHttpHttpClientConfig.defaultConfig()
    let ob: HttpClientBuilder = config.getClientBuilder()
    let config2: OkHttpHttpClientConfig = OkHttpHttpClientConfig(ob)
    let client: Option<OAuth4cjHttpClient> = bp.createClient(config2)
    match(client) {
        case Some(v) => println(v is OkHttpHttpClient)
        case None =>
            println(2)
            return 2
    }
    return 0
}

