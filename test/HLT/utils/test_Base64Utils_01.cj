// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestBaseUtils{
	
    public var params=Array<UInt8>()
    public var re=""
 	//验证入参数组可取值情况：数组为空
    @TestCase
    func testEncode01(): Unit {
        params=Array<UInt8>()
        re=Base64Utils.encode(params)
        @Assert(re,toBase64String(params))
    }
 	//验证入参数组可取值情况：数组长度达10000
    @TestCase
    func testEncode02(): Unit {
        params=Array<UInt8>(10000,item:0)
        re=Base64Utils.encode(params)
        @Assert(re,toBase64String(params))
    }
 	//验证入参数组可取值情况：普通数组
    @TestCase
    func testEncode03(): Unit {
        params="hello & world".toUtf8Array()
        re=Base64Utils.encode(params)
        @Assert(re,toBase64String(params))
    }
 	//验证入参数组可取值情况：数组内元素值包含在[0,256)
    @TestCase
    func testEncode04(): Unit {
        params=Array<UInt8>(256,item:0)
        for (i in 0..params.size){
            params[i]=UInt8(i)
        }
        re=Base64Utils.encode(params)
        @Assert(re,toBase64String(params))
    }
 	//验证多次编码
    @TestCase
    func testEncode05(): Unit {
        params="hello & world".toUtf8Array()
        re=Base64Utils.encode(Base64Utils.encode(params).toUtf8Array())
        @Assert(re,toBase64String(toBase64String(params).toUtf8Array()))
    }
 	//验证入参数组可取值情况：数组长度达10000,长度不是3的倍数
    @TestCase
    func testBase64UtilsencodeUrlWithoutPadding01(): Unit {
        params=Array<UInt8>(10000,item:0)
        var random=Random()
        for (i in 0..10000){
             params[i]=random.nextUInt8()
        }
        re=Base64Utils.encodeUrlWithoutPadding(params)
        var exp_re=toBase64String(params).replace("+","-")
        exp_re=exp_re.replace("/","_")
        exp_re=exp_re.replace("=","")
        @Assert(re,exp_re)
    }
 	//验证入参数组可取值情况：数组为空
    @TestCase
    func testBase64UtilsencodeUrlWithoutPadding02(): Unit {
        params=Array<UInt8>()
        re=Base64Utils.encodeUrlWithoutPadding(params)
        @Assert(re,toBase64String(params))
    }
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