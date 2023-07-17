// DEPENDENCE: ../common_Values.cj
// EXEC: cjc %import-path %L %l %f common_Values.cj
// EXEC: ./main

main (){

    let flag = testExecuteAny()
    if (flag != 0){
        return flag
    }
    return flag
}

/*
 *   public func execute(request: OAuth4cjRequest, callback: Option<OAuthAsyncRequestCallback>): Future<Any>
 *   测试场景:callback为Option<OAuthAsyncRequestCallback>.None,不回调
 */
func testExecuteAny(): Int32 {

    let oauth10aService=OAuthServiceTest.getOAuth10aService()
    var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
    var callback=Option<OAuthAsyncRequestCallback>.None
    let fut_response=oauth10aService.execute(oauth4cjRequest,callback)

    let act_response = fut_response.get()

    let response = (act_response as oauth4cj.model.Response).getOrThrow()
    let code: Int32 = response.getCode()
    println(code)
    println(response.getBody())

    if (code != 200){
        println(1)
        return 1
    }
    return 0
}
