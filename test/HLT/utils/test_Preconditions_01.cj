// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestPreconditions01{
    public var param=""
    public var params=Array<String>()
    public var errorMsg=""
    @TestCase
    func testCheckEmptyString01(): Unit {
        //hasText(string)==true && hasText(errorMsg）==true不报错无任何信息
        param="rerwr"
        errorMsg="rewrwr"
        var flag=1
        try{
            Preconditions.checkEmptyString(param,errorMsg)
        }catch(e:Exception){
            flag=0
        }
        @Assert(flag,1)
        
    }  
    @TestCase
    func testCheckEmptyString02(): Unit {
        //hasText(string)==true && hasText(errorMsg）==false不报错无任何信息
        param="rerwr"
        errorMsg=""
        var flag=1
        try{
            Preconditions.checkEmptyString(param,errorMsg)
        }catch(e:Exception){
            flag=0
        }
        @Assert(flag,1)        
    }  
    @TestCase
    func testCheckEmptyString03(): Unit {
        //hasText(string)==false && hasText(errorMsg）==true,抛异常，打印异常信息显示字符串errorMsg
        param=""
        errorMsg=""
        var act_errorMsg=""
        var flag=1
        try{
            Preconditions.checkEmptyString(param,errorMsg)
        }catch(e:IllegalArgumentException){
            act_errorMsg=e.toString()
            @Assert(act_errorMsg.contains("IllegalArgumentException: Received an invalid parameter"),true)
            flag=0
        }
        @Assert(flag,0)
    } 
    //hasText(string)==false && hasText(errorMsg）==false,抛异常，打印异常信息显示默认报错信息
    @TestCase
    func testCheckEmptyString04(): Unit {
        param=""
        errorMsg="hasText(param) is false"
        var act_errorMsg=""
        var flag=1
        try{
            Preconditions.checkEmptyString(param,errorMsg)
        }catch(e:IllegalArgumentException){
            act_errorMsg=e.toString()
            @Assert(act_errorMsg.contains("IllegalArgumentException: ${errorMsg}"),true)
            flag=0
        }
        @Assert(flag,0)
    }   
 	//str仅包含空白字符：空字符串，空格(中英文)，\n,\r,\t,\f，返回false  \v,"\b","\0","\0\0"
    @TestCase
    func testHasText01(): Unit {
        params=Array<String>([""," ","\n","\r","\t","\f","\v"])
        for (param in params){
            @Assert(Preconditions.hasText(param),false)
        }
        params=Array<String>(["\b","\0","\0\0"])
        for (param in params){
            @Assert(Preconditions.hasText(param),true)
        }
    }
 	//str中仅包含非空白字符， 返回true
    @TestCase
    func testHasText02(): Unit {
        params=Array<String>(["abc","中z~！！@#中12~!@#$%^^&&*30"])//非空白字符串
        for (param in params){
            @Assert(Preconditions.hasText(param),true)
        }
    }
 	//str中包含空白字符，也包含非空白字符， 返回true
    @TestCase
    func testHasText03(): Unit {
        params=Array<String>(["abc","中\bzhong","中\nzhong"])//空白字符+非空白字符，加非空白字符
        for (param in params){
            @Assert(Preconditions.hasText(param),true)
        }
    }
}