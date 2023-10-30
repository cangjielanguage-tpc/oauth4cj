// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestTokenB001{
    //本类实例: 无&,且无参数,http://www.baidu.com?
    @TestCase
    func testGetParameter01(): Unit {
        var token01=Token()
        var token02=Token("")
        var token03=Token("http://www.baidu.com?")
        @Assert(token01.getParameter(""),"")
        @Assert(token02.getParameter(""),"")
        @Assert(token03.getParameter(""),"")
    }
    //本类实例: 无&,仅有一个参数:http://www.baidu.com?userName=fly
    @TestCase
    func testGetParameter0102(): Unit {
        var token01=Token("http://www.baidu.com?userName=fly")
        var token02=Token("http://www.baidu.com?userName=")
        var token03=Token("http://www.baidu.com?=fly")
        var token04=Token("http://www.baidu.com?fly")
        @Assert(token01.getParameter("http://www.baidu.com?userName"),"fly")
        @Assert(token02.getParameter("userName"),"")
        @Assert(token03.getParameter(""),"")
        @Assert(token03.getParameter("=fly"),"")
        @Assert(token04.getParameter("fly"),"")
    }
    //本类实例: 有&,多个参数，参数重复:http://www.baidu.com?userName=fly&city=&old=128&
    @TestCase
    func testGetParameter0103(): Unit {
        var token01=Token("http://www.baidu.com?userName=fly&city=&old=128&")
        var token02=Token("http://www.baidu.com?userName=fly&city=&city=nanjing&old=128&")
        var token03=Token("http://www.baidu.com?userName=fly&city=&city=nanjing&&old=128&")//&&
        var token04=Token("http://www.baidu.com?userName==fly&city=&city=nanjing&&old=128&")//==
        @Assert(token01.getParameter("http://www.baidu.com?userName"),"fly")
        @Assert(token01.getParameter("city"),"")
        @Assert(token01.getParameter("old"),"128")
        @Assert(token02.getParameter("city"),"")
        @Assert(token03.getParameter("old"),"128")
        @Assert(token04.getParameter("http://www.baidu.com?userName"),"")
    }
    //子类实例：public open class OAuth1Token <: Token
    @TestCase
    func testGetParameter02(): Unit {
        var oauth1token01=OAuth1Token()
        var oauth1token02=OAuth1Token("123","123","http://www.baidu.com?userName=fly&city=&old=128")
        @Assert(oauth1token01.getParameter("http://www.baidu.com?userName"),"")
        @Assert(oauth1token02.getParameter("http://www.baidu.com?userName"),"fly")
    }
    //子类实例:public class OAuth1AccessToken <: OAuth1Token
    @TestCase
    func testGetParameter0202(): Unit {
        var oauth1accesstoken01=OAuth1AccessToken("123","123")
        var oauth1accesstoken02=OAuth1AccessToken("123","123","http://www.baidu.com?userName=fly&city=&old=128")
        @Assert(oauth1accesstoken01.getParameter("http://www.baidu.com?userName"),"")
        @Assert(oauth1accesstoken02.getParameter("http://www.baidu.com?userName"),"fly")
    }
    //子类实例:public class OAuth1RequestToken <: OAuth1Token
    @TestCase
    func testGetParameter0203(): Unit {
        var oauth1requesttoken01=OAuth1RequestToken("123","123")
        var oauth1requesttoken02=OAuth1RequestToken("123","123","http://www.baidu.com?userName=fly&city=&old=128")
        var oauth1requesttoken03=OAuth1RequestToken("123","123",true,"http://www.baidu.com?userName=fly&city=&old=128")

        @Assert(oauth1requesttoken01.getParameter("http://www.baidu.com?userName"),"")
        @Assert(oauth1requesttoken02.getParameter("http://www.baidu.com?userName"),"fly")
        @Assert(oauth1requesttoken03.getParameter("http://www.baidu.com?userName"),"fly")

    }
    //子类实例:public class OAuth1RequestToken <: OAuth1Token
    @TestCase
    func testGetParameter0204(): Unit {
        var oauth2accesstoken01=OAuth2AccessToken("123")
        var oauth2accesstoken02=OAuth2AccessToken("123","http://www.baidu.com?userName=fly&city=&old=128")
        var oauth2accesstoken03=OAuth2AccessToken("123","123",Int32(123),"123","123","http://www.baidu.com?userName=fly&city=&old=128")
        @Assert(oauth2accesstoken01.getParameter("http://www.baidu.com?userName"),"")
        @Assert(oauth2accesstoken02.getParameter("http://www.baidu.com?userName"),"fly")
        @Assert(oauth2accesstoken03.getParameter("http://www.baidu.com?userName"),"fly")
    }
    //本类实例
    @TestCase
    func testGetRawResponse01(): Unit {
        var token01=Token()
        var token02=Token()
        @Assert(token01.getRawResponse(),"")
        for (str in strValues) {
            token02=Token(str)
            @Assert(token02.getRawResponse(),str)
        }
    }
    //子类实例：public open class OAuth1Token <: Token
    @TestCase
    func testGetRawResponse02(): Unit {
        var oauth1token01=OAuth1Token()
        var oauth1token02=OAuth1Token()
        @Assert(oauth1token01.getRawResponse(),"")
        for (str in strValues) {
            oauth1token02=OAuth1Token(str,str,str)
            @Assert(oauth1token02.getRawResponse(),str)

        }
    }
    //子类实例：public class OAuth1AccessToken <: OAuth1Token
    @TestCase
    func testGetRawResponse0202(): Unit {
        var oauth1accesstoken01=OAuth1AccessToken("123","123")
        var oauth1accesstoken02=OAuth1AccessToken("123","123","123")
        for (str in strValues) {
            oauth1accesstoken01=OAuth1AccessToken(str,str)
            @Assert(oauth1accesstoken01.getRawResponse(),"")

            oauth1accesstoken02=OAuth1AccessToken(str,str,str)
            @Assert(oauth1accesstoken02.getRawResponse(),str)
        }
    }
    //子类实例：public class OAuth1RequestToken <: OAuth1Token
    @TestCase
    func testGetRawResponse0203(): Unit {
        var oauth1requesttoken01=OAuth1RequestToken("123","123")
        var oauth1requesttoken02=OAuth1RequestToken("123","123")
        var oauth1requesttoken03=OAuth1RequestToken("123","123")
        for (str in strValues) {
            oauth1requesttoken01=OAuth1RequestToken(str,str)
            @Assert(oauth1requesttoken01.getRawResponse(),"")

            oauth1requesttoken02=OAuth1RequestToken(str,str,str)
            @Assert(oauth1requesttoken02.getRawResponse(),str)

            for (boolValue in boolValues){
                oauth1requesttoken03=OAuth1RequestToken(str,str,boolValue,str)
                @Assert(oauth1requesttoken03.getRawResponse(),str)
            }
        }
    }
    //子类实例：public class OAuth2AccessToken <: Token
    @TestCase
    func testGetRawResponse0204(): Unit {
        var oauth2accesstoken01=OAuth2AccessToken("123")
        var oauth2accesstoken02=OAuth2AccessToken("123")
        var oauth2accesstoken03=OAuth2AccessToken("123")
        var flag=0
        for (str in strValues) {
            oauth2accesstoken01=OAuth2AccessToken(str)
            @Assert(oauth2accesstoken01.getRawResponse(),"")

            oauth2accesstoken02=OAuth2AccessToken(str,str)
            @Assert(oauth2accesstoken02.getRawResponse(),str)

            for (int32Value in int32Values){
                if(int32Value<0){
                    flag = 0
                    try {
                        oauth2accesstoken03=OAuth2AccessToken(str,str,int32Value,str,str,str)
                    } catch (e: OAuth4cjException) {
                         if(e.toString().contains("OAuth4cjException: The effective time cannot be negative")){
                            flag=1
                        }
                        @Assert(flag,1)
                    }
                }else{
                    oauth2accesstoken03=OAuth2AccessToken(str,str,int32Value,str,str,str)
                    @Assert(oauth2accesstoken03.getRawResponse(),str)
                }
            }
        }
    }
}