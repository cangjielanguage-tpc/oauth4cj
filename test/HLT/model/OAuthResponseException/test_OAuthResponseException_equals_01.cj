// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestOAuthResponseExceptionB001{
    @TestCase
    func testOAuthResponseExceptionEquals01(): Unit {
        var response01=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubResource(File("../../common_Values.cj",OpenOption.Open(true,true)))
        var inputStream=ByteArrayStream()
        inputStream.write("hello world".toUtf8Array())
        var response02=oauth4cj.model.Response(Int32(2),"message",HashMap<String,String>(),inputStream,ArrayList<Resource>([sub01]))

        var oauthResponseException01=OAuthResponseException(response01)
        var oauthResponseException02=OAuthResponseException(response02)
        for (str in strValues) {
            for (int32Value in int32Values){
                response01=oauth4cj.model.Response(int32Value,str,HashMap<String,String>(),str)
                inputStream.write("hello world".toUtf8Array())
                response02=oauth4cj.model.Response(int32Value,str,HashMap<String,String>(),inputStream,ArrayList<Resource>([sub01]))
                oauthResponseException01=OAuthResponseException(response01)
                oauthResponseException02=OAuthResponseException(response02)
                @Assert(oauthResponseException01.equals(oauthResponseException01),true)
                @Assert(oauthResponseException02.equals(oauthResponseException02),true)
                if(response01.toString()==response02.toString()){
                    @Assert(oauthResponseException01.equals(oauthResponseException02),true)
                    @Assert(oauthResponseException02.equals(oauthResponseException01),true)

                }else{
                    @Assert(oauthResponseException01.equals(oauthResponseException02),false)
                    @Assert(oauthResponseException02.equals(oauthResponseException01),false)
                }
            }
        }
    }
}

