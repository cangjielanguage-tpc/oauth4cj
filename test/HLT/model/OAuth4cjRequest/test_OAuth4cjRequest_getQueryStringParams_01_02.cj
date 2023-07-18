// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB001{
    /***
        初始化查询：url不带参数，url无效协议
    ***/
    @TestCase
    func testOAuth4cjRequestgetQueryStringParams0102(): Unit {
        var url="sss://www.baidu.com"
        var exp_flag=0
        try{
            var oauth4cjRequest=OAuth4cjRequest(Verb.GET,url)
            @Assert(oauth4cjRequest.getQueryStringParams().asFormUrlEncodedString(),"")
        }catch(e:Exception){
		    println(e.toString())
            if(e.toString().contains("Malformed URL")){
                 exp_flag=1
            }
        }
        @Assert(exp_flag,1)
    }
}