// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestMultipartUtils{
    /***
        public static func checkBoundarySyntax(boundary: String): Unit
        测试场景:不匹配正则:[0-9a-zA-Z'()+_,-./:=? ]{0,69}[0-9a-zA-Z'()+_,-./:=?]
    ***/
    @TestCase
    func testMultipartUtilsCheckBoundarySyntax01(): Unit {
        var flag=1
        var str="@"
        var errorMsg=""
        try{
            MultipartUtils.checkBoundarySyntax(str)
        }catch(e:IllegalArgumentException){
            errorMsg=#"{'boundary'='"# + str + #"'} has invalid syntax. Should be '[0-9a-zA-Z'()+_,-./:=? ]{0,69}[0-9a-zA-Z'()+_,-./:=?]"# + #"'."#
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains(errorMsg)){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public static func checkBoundarySyntax(boundary: String): Unit
        测试场景:匹配正则一次:[0-9a-zA-Z'()+_,-./:=? ]{0,69}[0-9a-zA-Z'()+_,-./:=?]
    ***/
    @TestCase
    func testMultipartUtilsCheckBoundarySyntax02(): Unit {
        var flag=1
        var str="11111111111111111"
        var errorMsg=""
        try{
            MultipartUtils.checkBoundarySyntax(str)
        }catch(e:IllegalArgumentException){
            errorMsg=#"{'boundary'='"# + str + #"'} has invalid syntax. Should be '[0-9a-zA-Z'()+_,-./:=? ]{0,69}[0-9a-zA-Z'()+_,-./:=?]"# + #"'."#
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains(errorMsg)){
                flag=0
            }
        }
        @Assert(flag,1)
    }
    /***
        public static func checkBoundarySyntax(boundary: String): Unit
        测试场景:匹配正则多次:[0-9a-zA-Z'()+_,-./:=? ]{0,69}[0-9a-zA-Z'()+_,-./:=?]
    ***/
    @TestCase
    func testMultipartUtilsCheckBoundarySyntax03(): Unit {
        var flag=1
        var str="111111111@11111111"
        var errorMsg=""
        try{
            MultipartUtils.checkBoundarySyntax(str)
        }catch(e:IllegalArgumentException){
            errorMsg=#"{'boundary'='"# + str + #"'} has invalid syntax. Should be '[0-9a-zA-Z'()+_,-./:=? ]{0,69}[0-9a-zA-Z'()+_,-./:=?]"# + #"'."#
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains(errorMsg)){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public static func checkBoundarySyntax(boundary: String): Unit
        测试场景:全匹配:[0-9a-zA-Z'()+_,-./:=? ]{0,69}[0-9a-zA-Z'()+_,-./:=?]
    ***/
    @TestCase
    func testMultipartUtilsCheckBoundarySyntax04(): Unit {
        var flag=1
        var str="11111111111111111111111111111111111111111111111111111111111111111111111"
        var errorMsg=""
        try{
            MultipartUtils.checkBoundarySyntax(str)
        }catch(e:IllegalArgumentException){
            errorMsg=#"{'boundary'='"# + str + #"'} has invalid syntax. Should be '[0-9a-zA-Z'()+_,-./:=? ]{0,69}[0-9a-zA-Z'()+_,-./:=?]"# + #"'."#
            if(e.toString().contains("IllegalArgumentException") && e.toString().contains(errorMsg)){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public static func generateDefaultBoundary(): String
        测试场景:返回值准确
    ***/
    @TestCase
    func testMultipartUtilsGenerateDefaultBoundary01(): Unit {
        var defaultboundary=MultipartUtils.generateDefaultBoundary()
        @Assert(defaultboundary.contains("----OAuth4cj----"),true)
    }
    /***
        public static func getPayload(multipartPayload: MultipartPayload): ByteArrayStream
        测试场景:返回值准确-bodypart为空
    ***/
    @TestCase
    func testMultipartUtilsGetPayload01(): Unit {
        var  header=HashMap<String,String>([("key01","value01")])
        var  multipartPayload=MultipartPayload("subtype","boundary",header)
        var  payload=MultipartUtils.getPayload(multipartPayload)
        var  re=payload.readToEnd()
        payload=getExpByteArrayStream(multipartPayload)
        var  exp_re=payload.readToEnd()
        @Assert(exp_re,re)
    }
    /***
        public static func getPayload(multipartPayload: MultipartPayload): ByteArrayStream
        测试场景:返回值准确-bodypart为ByteArrayBodyPartPayload
    ***/
    @TestCase
    func testMultipartUtilsGetPayload02(): Unit {
        var  headers=HashMap<String,String>([("headers","header_value")])
        var  multipartPayload=MultipartPayload("subtype","boundary",headers)

        var bodypayload01=ByteArrayBodyPartPayload(Array<UInt8>(10,item:0),1,1,headers)
        var bodypayload02=ByteArrayBodyPartPayload(Array<UInt8>(10,item:0),headers)
        var bodypayload03=ByteArrayBodyPartPayload(Array<UInt8>(10,item:0),"content-type")
        var bodypayload04=ByteArrayBodyPartPayload(Array<UInt8>(10,item:0),1,1,"content-type")
        var bodypayload05=ByteArrayBodyPartPayload(Array<UInt8>(10,item:0))
        var bodypayload06=ByteArrayBodyPartPayload(Array<UInt8>(10,item:0),1,1)

        multipartPayload.addBodyPart(bodypayload01)
        multipartPayload.addBodyPart(bodypayload02)
        multipartPayload.addBodyPart(bodypayload03)
        multipartPayload.addBodyPart(bodypayload04)
        multipartPayload.addBodyPart(bodypayload05)
        multipartPayload.addBodyPart(bodypayload06)

        var  payload=MultipartUtils.getPayload(multipartPayload)
        var  re=payload.readToEnd()
        payload=getExpByteArrayStream(multipartPayload)
        var  exp_re=payload.readToEnd()
        @Assert(exp_re,re)
    }
    /***
        public static func getPayload(multipartPayload: MultipartPayload): ByteArrayStream
        测试场景:返回值准确-bodypart为MultipartPayload
    ***/
    @TestCase
    func testMultipartUtilsGetPayload03(): Unit {
        var header=HashMap<String,String>([("key01","value01")])
        var multipartPayload=MultipartPayload("subtype","boundary",header)
        var multipartPayload01=MultipartPayload()
        var multipartPayload02=MultipartPayload("boundary01")
        var multipartPayload03=MultipartPayload("subtype","boundary02")
        var map01=HashMap<String,String>([("Content-Type","; boundary=\"?(1111)\"")])
        var multipartPayload04=MultipartPayload(map01)
        var multipartPayload05=MultipartPayload("?(1111)",map01)
        var multipartPayload06=MultipartPayload("subtype","?(1111)",map01)


        multipartPayload.addBodyPart(multipartPayload01)
        multipartPayload.addBodyPart(multipartPayload02)
        multipartPayload.addBodyPart(multipartPayload03)
        multipartPayload.addBodyPart(multipartPayload04)
        multipartPayload.addBodyPart(multipartPayload05)
        multipartPayload.addBodyPart(multipartPayload06)
        var  payload=MultipartUtils.getPayload(multipartPayload)
        var  re=payload.readToEnd()
        payload=getExpByteArrayStream(multipartPayload)
        var  exp_re=payload.readToEnd()
        @Assert(exp_re,re)
    }
    /***
        public static func getPayload(multipartPayload: MultipartPayload): ByteArrayStream
        测试场景:返回值准确-bodypart不是ByteArrayBodyPartPayload，也不是MultipartPayload
    ***/
    @TestCase
    func testMultipartUtilsGetPayload04(): Unit {
        var  header=HashMap<String,String>([("key01","value01")])
        var  multipartPayload=MultipartPayload("subtype","boundary",header)
        multipartPayload.addBodyPart(BodyPartPayload())
        multipartPayload.addBodyPart(BodyPartPayload("contentType"))
        multipartPayload.addBodyPart(BodyPartPayload(HashMap<String,String>([("key01","value01")])))
        var flag=0
        try{
            MultipartUtils.getPayload(multipartPayload)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("OAuth4cjException") && e.toString().contains("the class type is not MultipartPayload and not ByteArrayBodyPartPayload.")){
                 flag=1
            }
        }
        @Assert(flag,1)
    }
    /***
        public static func parseBoundaryFromHeader(contentTypeHeader: String): String
        测试场景:能匹配:"; boundary="?([0-9a-zA-Z'()+_,-./:=? ]{0,69}[0-9a-zA-Z'()+_,-./:=?])"?"
    ***/
    @TestCase
    func testMultipartUtilsParseBoundaryFromHeader01(): Unit {
        var contentTypeHeader="; boundary=\"?(1111)\""
        var parseboundary=MultipartUtils.parseBoundaryFromHeader(contentTypeHeader)
        @Assert(parseboundary,"?(1111)")
    }
    /***
        public static func parseBoundaryFromHeader(contentTypeHeader: String): String
        测试场景:不能匹配:"; boundary="?([0-9a-zA-Z'()+_,-./:=? ]{0,69}[0-9a-zA-Z'()+_,-./:=?])"?"
    ***/
    @TestCase
    func testMultipartUtilsParseBoundaryFromHeader02(): Unit {
        var contentTypeHeader="; boundary="
        var parseboundary=MultipartUtils.parseBoundaryFromHeader(contentTypeHeader)
        @Assert(parseboundary,"")
    }
}