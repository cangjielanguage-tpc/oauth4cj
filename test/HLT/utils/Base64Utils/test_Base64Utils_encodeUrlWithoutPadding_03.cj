// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/cryptocj:oauth4cj/build/aarch64-linux-ohos/okhttp
// dependence: ../../common_Values.cj

@Test
public class TestBaseUtilsB002{
	
    public var params=Array<UInt8>()
    public var re=""
 	//验证入参数组可取值情况：长度是3的倍数
    @TestCase
    func testBase64UtilsencodeUrlWithoutPadding03(): Unit {
        params=Array<UInt8>(10000,item:0)
        var random=Random()
        for (i in 0..9){
             params[i]=random.nextUInt8()
        }
        re=Base64Utils.encodeUrlWithoutPadding(params)
        var exp_re=toBase64String(params).replace("+","-")
        exp_re=exp_re.replace("/","_")
        exp_re=exp_re.replace("=","")
        @Assert(re,exp_re)
    }
}   