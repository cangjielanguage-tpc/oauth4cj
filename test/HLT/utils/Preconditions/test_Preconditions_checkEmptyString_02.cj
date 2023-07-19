// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../../common_Values.cj


@Test
public class TestPreconditions01{
    public var params=""
    public var errorMsg=""
    @TestCase
    func testCheckEmptyString02(): Unit {
        //hasText(string)==true && hasText(errorMsg）==false不报错无任何信息
        params="rerwr"
        errorMsg=""
        var flag=1
        try{
            Preconditions.checkEmptyString(params,errorMsg)
        }catch(e:Exception){
            flag=0
        }
        @Assert(flag,1)        
    }                       
}