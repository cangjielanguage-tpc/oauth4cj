// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestOAuth4cjRequestB001{
    /***
        从无到有，追加header
    ***/
    @TestCase
    func testOAuth4cjRequestaddHeader01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var exp_headers=HashMap<String,String>()
        for (str in strValues){
            oauth4cjRequest.addHeader(str,str)
            exp_headers.put(str,str)
        }
        @Assert(oauth4cjRequest.getHeaders(),exp_headers)
    }
}