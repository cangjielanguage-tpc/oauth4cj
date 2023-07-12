// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj


@Test
public class TestPreconditions01{
    public var params=""
    public var errorMsg=""
    //hasText(string)==false && hasText(errorMsg）==false,抛异常，打印异常信息显示默认报错信息
    @TestCase
    func testCheckEmptyString04(): Unit {
        params=""
        errorMsg="hasText(params) is false"
        var act_errorMsg=""
        var flag=1
        try{
            Preconditions.checkEmptyString(params,errorMsg)
        }catch(e:Exception){
            flag=0
            act_errorMsg=e.toString()
        }
        @Assert(flag,0)
        @Assert(act_errorMsg.contains(errorMsg),true)
        
    }                        
}