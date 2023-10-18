// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj


@Test
public class TestOAuth4cjRequestB001{
    /***
        从无到有，追加header
    ***/
    @TestCase
    func testOAuth4cjRequestaddHeader01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var exp_body=HashMap<String,String>()
        for (str in strValues){
            oauth4cjRequest.addBodyParameter(str,str)
            exp_body.put(str,str)
        }
        @Assert(oauth4cjRequest.getBodyParams().asFormUrlEncodedString(),ParameterList(exp_body).asFormUrlEncodedString())
    }
    /***
        单次/多次添加，显示追加本次后的结果
    ***/
    @TestCase
    func testOAuth4cjRequestAddBodyPartPayloadInMultipartPayload01(): Unit {
        var oauth4cjRequest01=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var bodyPartPayload01=BodyPartPayload()
        oauth4cjRequest01.addBodyPartPayloadInMultipartPayload(bodyPartPayload01)
        var bodyparts=oauth4cjRequest01.getMultipartPayload().getOrThrow().getBodyParts()
        @Assert(bodyparts.size,1)

        oauth4cjRequest01.addBodyPartPayloadInMultipartPayload(bodyPartPayload01)
        var mult=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        @Assert(mult.getBodyParts().size,2)
    }
    /***
        从无到有，追加header
    ***/
    @TestCase
    func testOAuth4cjRequestaddHeader02(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var exp_headers=HashMap<String,String>()
        for (str in strValues){
            oauth4cjRequest.addHeader(str,str)
            exp_headers.put(str,str)
        }
        @Assert(oauth4cjRequest.getHeaders(),exp_headers)
    }
    /***
        添加成功
        1.key,startsWith("oauth_")
        2.key.equals("scope")
        3.key.equals("realm")
    ***/
    @TestCase
    func testOAuth4cjRequestaddOAuthParameter01(): Unit {
        var parameters=HashMap<String,String>([("oauth_1",""),("oauth_","oauth_"),("scope","scope01"),("realm","realm01")])
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        for (parameter in parameters){
            oauth4cjRequest.addOAuthParameter(parameter[0],parameter[1])
        }
        @Assert(oauth4cjRequest.getOauthParameters(),parameters)
    }
    /***
        添加异常，不满足以下条件
        1.key,startsWith("oauth_")
        2.key.equals("scope")
        3.key.equals("realm")
    ***/
    @TestCase
    func testOAuth4cjRequestaddOAuthParameter02(): Unit {
        var parameters=HashMap<String,String>([("Oauth_1",""),("oauth","oauth_"),("scope01","scope01"),("scop","scope01"),("realm01","realm01"),("rea","realm01")])
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var flag=1
        for (parameter in parameters){
            flag=1
            try{
                oauth4cjRequest.addOAuthParameter(parameter[0],parameter[1])
            }catch(e:Exception){
                flag=0
            }
            @Assert(flag,0)
        }
    }
    /***
        添加成功
        1.verb.isPermirBody()==true
        2.verb.isPermirBody()==false
    ***/
    @TestCase
    func testOAuth4cjRequestaddParameter01(): Unit {
        var parameters=HashMap<String,String>([("oauth_1",""),("oauth_","oauth_"),("scope","scope01"),("realm","realm01")])
        var oauth4cjRequest01=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var oauth4cjRequest02=OAuth4cjRequest(Verb.POST,"https://www.baidu.com")
        for (parameter in parameters){
            oauth4cjRequest01.addParameter(parameter[0],parameter[1])
            oauth4cjRequest02.addParameter(parameter[0],parameter[1])
        }
        @Assert(oauth4cjRequest01.getQueryStringParams().asFormUrlEncodedString(),ParameterList(parameters).asFormUrlEncodedString())
        @Assert(oauth4cjRequest01.getBodyParams().asFormUrlEncodedString(),"")
        @Assert(oauth4cjRequest02.getQueryStringParams().asFormUrlEncodedString(),"")
        @Assert(oauth4cjRequest02.getBodyParams().asFormUrlEncodedString(),ParameterList(parameters).asFormUrlEncodedString())
    }
    /***
        从无到有，追加QuerystringParameter
    ***/
    @TestCase
    func testOAuth4cjRequestaddQuerystringParameter01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var exp_body=HashMap<String,String>()
        for (str in strValues){
            oauth4cjRequest.addQuerystringParameter(str,str)
            exp_body.put(str,str)
        }
        @Assert(oauth4cjRequest.getQueryStringParams().asFormUrlEncodedString(),ParameterList(exp_body).asFormUrlEncodedString())
    }
    /***
        从无到有，追加header
    ***/
    @TestCase
    func testOAuth4cjRequestGetBodyParams01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        @Assert(oauth4cjRequest.getBodyParams().asFormUrlEncodedString(),"")
    }
    @TestCase
    func testOAuth4cjRequestGetByteArrayPayload01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        @Assert(oauth4cjRequest.getByteArrayPayload().size,0)
    }
    /***
        默认值
    ***/
    @TestCase
    func testOAuth4cjRequestgetCharset01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        @Assert(oauth4cjRequest.getCharset(),"UTF-8")
    }
    @TestCase
    func testOAuth4cjRequestgetCompleteUrl01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        @Assert(oauth4cjRequest.getCompleteUrl(),"https://www.baidu.com")
    }
    @TestCase
    func testOAuth4cjRequestgetCompleteUrl02(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        oauth4cjRequest.addHeader("header","header")
        oauth4cjRequest.addBodyParameter("BodyParameter","BodyParameter")
        oauth4cjRequest.addQuerystringParameter("QuerystringParameter","QuerystringParameter")
        @Assert(oauth4cjRequest.getCompleteUrl(),"https://www.baidu.com?QuerystringParameter=QuerystringParameter")
    }
    @TestCase
    func testOAuth4cjRequestgetFilePayload01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var flag=1
        try{
            oauth4cjRequest.getFilePayload().getOrThrow()
        }catch(e:NoneValueException){
            flag=0
        }
        @Assert(flag,0)
    }
    /***
        构造器默认查询
    ***/
    @TestCase
    func testOAuth4cjRequestgetHeaders01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var exp_headers=HashMap<String,String>()
        @Assert(oauth4cjRequest.getHeaders(),exp_headers)
    }
    /***
        public func getMultipartPayload(): MultipartPayload
        测试场景:初始化直接获取
    ***/
    @TestCase
    func testOAuth4cjRequestGetMultipartPayload01(): Unit {
        var oauth4cjRequest01=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var muti: MultipartPayload
        try {
            muti=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        } catch (e: Exception) {
            println(e)
            oauth4cjRequest01.initMultipartPayload()
            muti=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        }
        var boundary=muti.getBoundary()
        @Assert(boundary.contains("----OAuth4cj----"),true)
    }
    @TestCase
    func testOAuth4cjRequestetOauthgParameters01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var params=oauth4cjRequest.getOauthParameters()
        @Assert(params,HashMap<String,String>())
    }
    /***
        初始化查询：url不带参数,url有效协议
    ***/
    @TestCase
    func testOAuth4cjRequestgetQueryStringParams01(): Unit {
        var urls=Array<String>(["http://www.baidu.com","ftp://www.baidu.com"])
        for (url in urls){
            var oauth4cjRequest=OAuth4cjRequest(Verb.GET,url)
            @Assert(oauth4cjRequest.getQueryStringParams().asFormUrlEncodedString(),"")
        }
    }
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
    /***
        初始化查询：url带参数
    ***/
    @TestCase
    func testOAuth4cjRequestgetQueryStringParams02(): Unit {
        var exp_body=HashMap<String,String>([("uaser","name"),("old","23")])
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com?uaser=name&old=23")
        @Assert(oauth4cjRequest.getQueryStringParams().asFormUrlEncodedString(),ParameterList(exp_body).asFormUrlEncodedString())
    }
    @TestCase
    func testOAuth4cjRequestgetRealm01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        @Assert(oauth4cjRequest.getRealm(),"")
    }
    /***
        1.url.startWith("http://") &&  ( url.endWith(":80")  || url.contains(":80/") )---替换“:80”为空，删除“？”之后的所有字符串,包括?
    ***/
    @TestCase
    func testOAuth4cjRequestGetSanitizedUrl01(): Unit {
        var urls=Array<String>(["http://127.0.0.0:80","http://127.0.0.0:80/","http://127.0.0.0:80/index?","http://127.0.0.0:80/index?user=001&passwd=123"])
        var exp_urls=Array<String>(["http://127.0.0.0","http://127.0.0.0/","http://127.0.0.0/index","http://127.0.0.0/index"])
        for (index in 0..urls.size){
            var oauth4cjRequest=OAuth4cjRequest(Verb.GET,urls[index])
            @Assert(oauth4cjRequest.getSanitizedUrl(),exp_urls[index])
        }
    }
    /***
        2.url.startWith("https://") &&  ( url.endWith(":443")  || url.contains(":443/") )----替换“:443”为空，删除“？”之后的所有字符串,包括?
    ***/
    @TestCase
    func testOAuth4cjRequestGetSanitizedUrl02(): Unit {
        var urls=Array<String>(["https://127.0.0.0:443","https://127.0.0.0:443/","https://127.0.0.0:443/index?","https://127.0.0.0:443/index?user=001&passwd=123"])
        var exp_urls=Array<String>(["https://127.0.0.0","https://127.0.0.0/","https://127.0.0.0/index","https://127.0.0.0/index"])
        for (index in 0..urls.size){
            var oauth4cjRequest=OAuth4cjRequest(Verb.GET,urls[index])
            @Assert(oauth4cjRequest.getSanitizedUrl(),exp_urls[index])
        }
    }
    /***
        3.其他:删除？之后的所有,包括?
    ***/
    @TestCase
    func testOAuth4cjRequestGetSanitizedUrl03(): Unit {
        var urls=Array<String>(["http://127.0.0.0:443","https://127.0.0.0:80","http://wwe.kk:8080?sh=34&uaer=123"])
        var exp_urls=Array<String>(["http://127.0.0.0","https://127.0.0.0","http://wwe.kk:8080"])
        for (index in 0..urls.size){
            var oauth4cjRequest=OAuth4cjRequest(Verb.GET,exp_urls[index])
            @Assert(oauth4cjRequest.getSanitizedUrl(),exp_urls[index])
        }
    }
    @TestCase
    func testOAuth4cjRequestgetStringPayload01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        @Assert(oauth4cjRequest.getStringPayload(),"")
    }
    /***
        字符串角度验证
    ***/
    @TestCase
    func testOAuth4cjRequestgetUrl03(): Unit {
        for (str in strValues){
            var oauth4cjRequest=OAuth4cjRequest(Verb.GET,str)
            @Assert(oauth4cjRequest.getUrl(),str)
        }
    }
    /***
        返回与构造器一直
    ***/
    @TestCase
    func testOAuth4cjRequestgetVerb01(): Unit {
        var verbs=Array<Verb>([Verb.GET,Verb.POST,Verb.PUT,Verb.DELETE,Verb.HEAD,Verb.OPTIONS,Verb.TRACE,Verb.PATCH])
        for (verb in verbs){
            var oauth4cjRequest=OAuth4cjRequest(verb,"http://www.baidu.com")
            @Assert(oauth4cjRequest.getVerb().toString(),verb.toString())
        }
    }
    /***
        public func initMultipartPayload(): Unit
    ***/
    @TestCase
    func testOAuth4cjRequestInitMultipartPayload0101(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        oauth4cjRequest.initMultipartPayload()
        var multi=oauth4cjRequest.getMultipartPayload().getOrThrow()
        var boundary=multi.getBoundary()
        @Assert(boundary.contains("----OAuth4cj----"),true)
        var re=multi.getHeaders()
        var header_value="multipart/" + "form-data"+"; boundary=\"" + multi.getBoundary() + '"';
        var header_map=HashMap<String,String>([("Content-Type",header_value)])
        @Assert(re,header_map)
    }
    /***
        public func initMultipartPayload(boundary: String): Unit
    ***/
    @TestCase
    func testOAuth4cjRequestInitMultipartPayload0201(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var str="11111111111111111"
        oauth4cjRequest.initMultipartPayload(str)
        var multi=oauth4cjRequest.getMultipartPayload().getOrThrow()
        var boundary=multi.getBoundary()
        @Assert(boundary,str)
        var re=multi.getHeaders()
        var header_value="multipart/" + "form-data"+"; boundary=\"" + multi.getBoundary() + '"';
        var header_map=HashMap<String,String>([("Content-Type",header_value)])
        @Assert(re,header_map)
    }
    /***
        public func initMultipartPayload(subtype: String, boundary: String): Unit
    ***/
    @TestCase
    func testOAuth4cjRequestInitMultipartPayload0301(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var str="11111111111"
        oauth4cjRequest.initMultipartPayload(str,str)
        var multi=oauth4cjRequest.getMultipartPayload().getOrThrow()
        var boundary=multi.getBoundary()
        @Assert(boundary,str)
        var re=multi.getHeaders()
        var header_value="multipart/" + str+"; boundary=\"" + multi.getBoundary() + '"';
        var header_map=HashMap<String,String>([("Content-Type",header_value)])
        @Assert(re,header_map)
    }
    /***
        public func initMultipartPayload(headers: HashMap<String, String>): Unit
    ***/
    @TestCase
    func testOAuth4cjRequestInitMultipartPayload0401(): Unit {
        var oauth4cjRequest01=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var hashmap01=HashMap<String, String>()
        oauth4cjRequest01.initMultipartPayload(hashmap01)
        var multi=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        var boundary=multi.getBoundary()
        @Assert(boundary.contains("----OAuth4cj----"),true)
        var re=multi.getHeaders()
        var header_value="multipart/" + "form-data"+"; boundary=\"" + multi.getBoundary() + '"';
        var header_map=HashMap<String,String>([("Content-Type",header_value)])
        @Assert(re,header_map)
    }
    /***
        public func initMultipartPayload(boundary: String, headers: HashMap<String, String>): Unit
    ***/
    @TestCase
    func testOAuth4cjRequestInitMultipartPayload0501(): Unit {
        var oauth4cjRequest01=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var hashmap01=HashMap<String, String>()
        var hashmap02=HashMap<String, String>([("key01","value01"),("key02","value02")])
        var str="111111111"
        oauth4cjRequest01.initMultipartPayload(str,hashmap01)
        oauth4cjRequest01.initMultipartPayload(str,hashmap02)
        var multi=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        var re=multi.getHeaders()
        var header_value="multipart/" + "form-data"+"; boundary=\"" + multi.getBoundary() + '"';
        var header_map=hashmap02
        header_map.put("Content-Type",header_value)
        @Assert(re,header_map)
    }
    /***
        public func initMultipartPayload(subtype: String, boundary: String, headers: HashMap<String, String>): Unit
    ***/
    @TestCase
    func testOAuth4cjRequestInitMultipartPayload0601(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var str="222222222"
        var hashmap01=HashMap<String, String>()
        var hashmap02=HashMap<String, String>([("key01","value01"),("key02","value02")])
        oauth4cjRequest.initMultipartPayload(str,str,hashmap01)
        oauth4cjRequest.initMultipartPayload(str,str,hashmap02)
        var multi=oauth4cjRequest.getMultipartPayload().getOrThrow()
        var re=multi.getHeaders()
        var header_value="multipart/" + str+"; boundary=\"" + multi.getBoundary() + '"';
        var header_map=hashmap02
        header_map.put("Content-Type",header_value)
        @Assert(re,header_map)
    }
    /***
        public func setBodyPartPayloadInMultipartPayload(bodyPartPayload: BodyPartPayload): Unit
        单次/多次设置
    ***/
    @TestCase
    func testOAuth4cjRequestSetBodyPartPayloadInMultipartPayload01(): Unit {
        var oauth4cjRequest01=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var mult: MultipartPayload
        try {
            mult=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        } catch (e: Exception) {
            println(e)
            oauth4cjRequest01.initMultipartPayload()
            mult=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        }
        var boundary=mult.getBoundary()
        @Assert(boundary.contains("----OAuth4cj----"),true)
        @Assert(mult.getBodyParts().size,0)


        var bodyPartPayload01=BodyPartPayload()
        oauth4cjRequest01.setBodyPartPayloadInMultipartPayload(bodyPartPayload01)
        mult=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        @Assert(mult.getBodyParts().size,1)

        oauth4cjRequest01.setBodyPartPayloadInMultipartPayload(bodyPartPayload01)
        mult=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        @Assert(mult.getBodyParts().size,1)
    }
    /***
        可允许设置的范围：
        1.UTF-8  ||  utf-8  ||  UTF8  || utf8
    ***/
    @TestCase
    func testOAuth4cjRequestsetCharset01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var charsets=Array<String>(["UTF-8","utf-8","UTF8","utf8"])
        for (charset in charsets){
            oauth4cjRequest.setCharset(charset)
            @Assert(oauth4cjRequest.getCharset(),charset)
        }
    }
    /***
        异常设置
        可允许设置的范围：
        1.UTF-8  ||  utf-8  ||  UTF8  || utf8
    ***/
    @TestCase
    func testOAuth4cjRequestsetCharset02(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var charsets=Array<String>(["unicode","gbk ","GBK","gb2312"])
        var flag=1
        for (charset in charsets){
            flag=1
            try{
                oauth4cjRequest.setCharset(charset)
            }catch(e:OAuth4cjException){
                if(e.toString().contains("only supperd UTF-8 Character Set")){
                    flag=0
                }
            }
            @Assert(flag,0)
        }
    }
    /***
        public func setMultipartPayload(multipartPayload: MultipartPayload): Unit
        测试场景：单次设置、多次设置
    ***/
    @TestCase
    func testOAuth4cjRequestSetMultipartPayload01(): Unit {
        var oauth4cjRequest01=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        var multipartPayload=MultipartPayload("multipartPayload")
        oauth4cjRequest01.setMultipartPayload(multipartPayload)
        var muti=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        var boundary=muti.getBoundary()
        @Assert(boundary,"multipartPayload")

        multipartPayload=MultipartPayload()
        oauth4cjRequest01.setMultipartPayload(multipartPayload)

        muti=oauth4cjRequest01.getMultipartPayload().getOrThrow()
        boundary=muti.getBoundary()
        @Assert(boundary.contains("----OAuth4cj----"),true)
    }
    @TestCase
    func testOAuth4cjRequestsetPayload0101(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        for (str in strValues){
            oauth4cjRequest.setPayload(str)
            @Assert(oauth4cjRequest.getStringPayload(),str)
        }
    }
    @TestCase
    func testOAuth4cjRequestsetPayload0201(): Unit {
        var arr01=Array<UInt8>()
        var arr02=Array<UInt8>(10000,item:0)
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        oauth4cjRequest.setPayload(arr01)
        @Assert(oauth4cjRequest.getByteArrayPayload(),arr01)
        oauth4cjRequest.setPayload(arr02)
        @Assert(oauth4cjRequest.getByteArrayPayload(),arr02)

    }
    @TestCase
    func testOAuth4cjRequestsetPayload0301(): Unit {
        var file02=File("file02.txt",OpenOption.CreateOrTruncate(true))
        file02.write("hello world".toUtf8Array())
        file02.close()
        var file03=File("file02.txt",OpenOption.Open(true,false))
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        oauth4cjRequest.setPayload(file03)
        @Assert(oauth4cjRequest.getFilePayload().getOrThrow().readToEnd(),"hello world".toUtf8Array())
        var file01=File("file01.txt",OpenOption.CreateOrTruncate(true))
        oauth4cjRequest.setPayload(file01)
        @Assert(oauth4cjRequest.getFilePayload().getOrThrow().readToEnd(),Array<UInt8>())

    }
    @TestCase
    func testOAuth4cjRequestsetRealm01(): Unit {
        var oauth4cjRequest=OAuth4cjRequest(Verb.GET,"https://www.baidu.com")
        for (str in strValues){
            oauth4cjRequest.setRealm(str)
            @Assert(oauth4cjRequest.getRealm(),str)
        }
    }
    /***
        返回与构造器一直
    ***/
    @TestCase
    func testOAuth4cjRequesttoString01(): Unit {
        var verbs=Array<Verb>([Verb.GET,Verb.POST,Verb.PUT,Verb.DELETE,Verb.HEAD,Verb.OPTIONS,Verb.TRACE,Verb.PATCH])
        for (verb in verbs){
            for (url in strValues){
                var oauth4cjRequest=OAuth4cjRequest(verb,url)
                @Assert(oauth4cjRequest.toString(),"@Request(${oauth4cjRequest.getVerb()} ${oauth4cjRequest.getUrl()})")
            }
        }
    }
}