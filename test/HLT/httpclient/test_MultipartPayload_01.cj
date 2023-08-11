// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestMultipartPayload{
    /***
        public func addBodyPart(bodyPartPayload: BodyPartPayload): Unit
        测试场景:单次添加
    ***/
    @TestCase
    func testMultipartPayloadAddBodyPart0101(): Unit {
        var multipartPayload01=MultipartPayload()
        var multipartPayload02=MultipartPayload("boundary")
        var multipartPayload03=MultipartPayload("subtype","boundary")
        var multipartPayload04=MultipartPayload(HashMap<String,String>())
        var multipartPayload05=MultipartPayload("boundary",HashMap<String,String>())
        var multipartPayload06=MultipartPayload("subtype","boundary",HashMap<String,String>())
        var bodypayload=BodyPartPayload()
        multipartPayload01.addBodyPart(bodypayload)
        multipartPayload02.addBodyPart(bodypayload)
        multipartPayload03.addBodyPart(bodypayload)
        multipartPayload04.addBodyPart(bodypayload)
        multipartPayload05.addBodyPart(bodypayload)
        multipartPayload06.addBodyPart(bodypayload)
        @Assert(multipartPayload01.getBodyParts().size,1)
        @Assert(multipartPayload02.getBodyParts().size,1)
        @Assert(multipartPayload03.getBodyParts().size,1)
        @Assert(multipartPayload04.getBodyParts().size,1)
        @Assert(multipartPayload05.getBodyParts().size,1)
        @Assert(multipartPayload06.getBodyParts().size,1)
    }
    /***
        public func addBodyPart(bodyPartPayload: BodyPartPayload): Unit
        测试场景:多次添加
    ***/
    @TestCase
    func testMultipartPayloadAddBodyPart0102(): Unit {
        var multipartPayload01=MultipartPayload()
        var bodypayload01=BodyPartPayload()
        var contentType="contentType"
        var bodypayload02=BodyPartPayload(contentType)
        var map01=HashMap<String,String>([("token","token_value"),("token02","token_value02")])
        var bodypayload03=BodyPartPayload(map01)
        multipartPayload01.addBodyPart(bodypayload01)
        multipartPayload01.addBodyPart(bodypayload02)
        multipartPayload01.addBodyPart(bodypayload03)
        @Assert(multipartPayload01.getBodyParts().size,3)

    }
    /***
        public func addBodyPart(multipartPayload: MultipartPayload): Unit
        测试场景:单次添加入参MultipartPayload.getBoundary()等于本身的boundary
    ***/
    @TestCase
    func testMultipartPayloadAddBodyPart0201(): Unit {
        var multipartPayload01=MultipartPayload()
        var boundary_value="boundary_value"
        var multipartPayload02=MultipartPayload(boundary_value)
        var flag=1
        try{
            multipartPayload01.addBodyPart(multipartPayload01)
        }catch(e:IllegalArgumentException){

            if(e.toString().contains("----OAuth4cj----")){
                flag=0
            }
        }
        @Assert(flag,0)

        flag=1
        try{
            multipartPayload02.addBodyPart(multipartPayload02)
        }catch(e:IllegalArgumentException){
            if(e.toString().contains("{\'boundary\'}={\'${boundary_value}\'} is the same for parent MultipartPayload and child")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
    /***
        public func addBodyPart(multipartPayload: MultipartPayload): Unit
        测试场景:单次添加入参MultipartPayload.getBoundary()不等于本身的boundary
    ***/
    @TestCase
    func testMultipartPayloadAddBodyPart0202(): Unit {
        var multipartPayload01=MultipartPayload()
        var multipartPayload02=MultipartPayload("boundary")
        multipartPayload01.addBodyPart(multipartPayload02)
        @Assert(multipartPayload01.getBodyParts().size,1)

    }
    /***
        public func addBodyPart(multipartPayload: MultipartPayload): Unit
        测试场景:多次添加
    ***/
    @TestCase
    func testMultipartPayloadAddBodyPart0203(): Unit {
        var multipartPayload01=MultipartPayload()
        var multipartPayload02=MultipartPayload("boundary01")
        var multipartPayload03=MultipartPayload("boundary02")
        var multipartPayload04=MultipartPayload("boundary03")
        multipartPayload01.addBodyPart(multipartPayload02)
        multipartPayload01.addBodyPart(multipartPayload03)
        multipartPayload01.addBodyPart(multipartPayload04)
        @Assert(multipartPayload01.getBodyParts().size,3)

    }
    /***
        public func getBodyParts(): ArrayList<BodyPartPayload>
        测试场景:默认构造器调用
    ***/
    @TestCase
    func testMultipartPayloadGetBodyParts01(): Unit {
        var multipartPayload01=MultipartPayload()
        var multipartPayload02=MultipartPayload("boundary")
        var multipartPayload03=MultipartPayload("subtype","boundary")
        var multipartPayload04=MultipartPayload(HashMap<String,String>())
        var multipartPayload05=MultipartPayload("boundary",HashMap<String,String>())
        var multipartPayload06=MultipartPayload("subtype","boundary",HashMap<String,String>())
        @Assert(multipartPayload01.getBodyParts().size,0)
        @Assert(multipartPayload02.getBodyParts().size,0)
        @Assert(multipartPayload03.getBodyParts().size,0)
        @Assert(multipartPayload04.getBodyParts().size,0)
        @Assert(multipartPayload05.getBodyParts().size,0)
        @Assert(multipartPayload06.getBodyParts().size,0)
    }
    /***
        public func getBoundary(): String
        测试场景:默认构造器调用
    ***/
    @TestCase
    func testMultipartPayloadGetBoundary01(): Unit {
        var multipartPayload01=MultipartPayload()
        @Assert(multipartPayload01.getBoundary().contains("----OAuth4cj----"),true)

        var multipartPayload02=MultipartPayload("boundary")
        @Assert(multipartPayload02.getBoundary(),"boundary")

        var multipartPayload03=MultipartPayload("subtype","boundary")
        @Assert(multipartPayload03.getBoundary(),"boundary")

        var multipartPayload04=MultipartPayload(HashMap<String,String>())
        @Assert(multipartPayload04.getBoundary().contains("----OAuth4cj----"),true)

        var multipartPayload0401=MultipartPayload(HashMap<String,String>([("Content-Type","; boundary=\"?(1111)\"")]))
        @Assert(multipartPayload0401.getBoundary(),"?(1111)")

        var multipartPayload05=MultipartPayload("boundary",HashMap<String,String>())
        @Assert(multipartPayload05.getBoundary(),"boundary")

        var multipartPayload06=MultipartPayload("subtype","boundary",HashMap<String,String>())
        @Assert(multipartPayload06.getBoundary(),"boundary")

        var multipartPayload0601=MultipartPayload("subtype","boundary",HashMap<String,String>([("key02","value02")]))
        @Assert(multipartPayload0601.getBoundary(),"boundary")

    }
    /***
        public func getEpilogue(): String
        测试场景:默认构造器调用
    ***/
    @TestCase
    func testMultipartPayloadGetEpilogue01(): Unit {
        var multipartPayload01=MultipartPayload()
        @Assert(multipartPayload01.getEpilogue(),"")

        var multipartPayload02=MultipartPayload("boundary")
        @Assert(multipartPayload02.getEpilogue(),"")

        var multipartPayload03=MultipartPayload("subtype","boundary")
        @Assert(multipartPayload03.getEpilogue(),"")

        var multipartPayload04=MultipartPayload(HashMap<String,String>())
        @Assert(multipartPayload04.getEpilogue(),"")

        var multipartPayload05=MultipartPayload("boundary",HashMap<String,String>())
        @Assert(multipartPayload05.getEpilogue(),"")

        var multipartPayload06=MultipartPayload("subtype","boundary",HashMap<String,String>())
        @Assert(multipartPayload06.getEpilogue(),"")
    }
    /***
        public func getHeaders(): HashMap<String, String>
        public init()
        测试场景:调用父类方法,确保传给父类的值准确--
    ***/
    @TestCase
    func testMultipartPayloadGetHeaders01(): Unit {
        var multipartPayload01=MultipartPayload()
        var re=multipartPayload01.getHeaders()
        var header_value="multipart/" + "form-data"+"; boundary=\"" + multipartPayload01.getBoundary() + '"';
        var header_map=HashMap<String,String>([("Content-Type",header_value)])
        @Assert(re,header_map)
    }
    /***
        public func getHeaders(): HashMap<String, String>
        public init(boundary: String)
        测试场景:调用父类方法,确保传给父类的值准确
    ***/
    @TestCase
    func testMultipartPayloadGetHeaders02(): Unit {
        var multipartPayload02=MultipartPayload("boundary")
        var re=multipartPayload02.getHeaders()
        var header_value="multipart/" + "form-data"+"; boundary=\"" + multipartPayload02.getBoundary() + '"';
        var header_map=HashMap<String,String>([("Content-Type",header_value)])
        @Assert(re,header_map)
    }
    /***
        public func getHeaders(): HashMap<String, String>
        public init(subtype: String, boundary: String)
        测试场景:调用父类方法,确保传给父类的值准确
    ***/
    @TestCase
    func testMultipartPayloadGetHeaders03(): Unit {
        var multipartPayload03=MultipartPayload("subtype","boundary")
        var re=multipartPayload03.getHeaders()
        var header_value="multipart/" + "subtype" +"; boundary=\"" + multipartPayload03.getBoundary() + '"';
        var header_map=HashMap<String,String>([("Content-Type",header_value)])
        @Assert(re,header_map)
    }
    /***
        public func getHeaders(): HashMap<String, String>
        public init(headers: HashMap<String, String>)
        测试场景:调用父类方法,确保传给父类的值准确--hashMap空
    ***/
    @TestCase
    func testMultipartPayloadGetHeaders04(): Unit {
        var multipartPayload04=MultipartPayload(HashMap<String,String>())
        var re=multipartPayload04.getHeaders()
        var header_value="multipart/" + "form-data"+"; boundary=\"" + multipartPayload04.getBoundary() + '"';
        var header_map=HashMap<String,String>([("Content-Type",header_value)])
        @Assert(re,header_map)
    }
    /***
        public func getHeaders(): HashMap<String, String>
        public init(headers: HashMap<String, String>)
        测试场景:调用父类方法,确保传给父类的值准确--hashMap非空，但key不包含Content-Type
    ***/
    @TestCase
    func testMultipartPayloadGetHeaders0402(): Unit {
        var map01=HashMap<String,String>([("key01","value01"),("key02","value02")])
        var multipartPayload04=MultipartPayload(map01)
        var re=multipartPayload04.getHeaders()
        var header_value="multipart/" + "form-data"+"; boundary=\"" + multipartPayload04.getBoundary() + '"';
        var header_map=map01
        header_map.put("Content-Type",header_value)
        @Assert(re,header_map)
    }
    /***
        public func getHeaders(): HashMap<String, String>
        public init(headers: HashMap<String, String>)
        测试场景:调用父类方法,确保传给父类的值准确--hashMap非空，且key包含Content-Type
    ***/
    @TestCase
    func testMultipartPayloadGetHeaders0403(): Unit {
        var map01=HashMap<String,String>([("key01","value01"),("Content-Type","Content-Type")])
        var multipartPayload04=MultipartPayload(map01)
        var re=multipartPayload04.getHeaders()
        var header_value="Content-Type"+"; boundary=\"" + multipartPayload04.getBoundary() + '"'
        var header_map=map01
        header_map.put("Content-Type",header_value)
        @Assert(re,header_map)
    }
    /***
        public func getHeaders(): HashMap<String, String>
        public init(boundary: String, headers: HashMap<String, String>)
        测试场景:调用父类方法,确保传给父类的值准确
    ***/
    @TestCase
    func testMultipartPayloadGetHeaders05(): Unit {
        var multipartPayload05=MultipartPayload("boundary",HashMap<String,String>())
        var re=multipartPayload05.getHeaders()
        var header_value="multipart/" + "form-data"+"; boundary=\"" + multipartPayload05.getBoundary() + '"';
        var header_map=HashMap<String,String>([("Content-Type",header_value)])
        @Assert(re,header_map)
    }
    /***
        public func getHeaders(): HashMap<String, String>
        public init(boundary: String, headers: HashMap<String, String>)
        测试场景:调用父类方法,确保传给父类的值准确--hashMap非空，且key包含Content-Type
    ***/
    @TestCase
    func testMultipartPayloadGetHeaders0502(): Unit {
        var map01=HashMap<String,String>([("key01","value01"),("Content-Type","; boundary=\"?(1adsaffecz)\"")])
        var flag=0
        try{
            var multipartPayload04=MultipartPayload("boundary",map01)
            println(multipartPayload04.getEpilogue())
        }catch(e:IllegalArgumentException){

            if(e.toString().contains("Different boundaries was passed in constructors. One as argument, second as header")){
                flag=1
            }
        }
        @Assert(flag,1)
    }
    /***
        public func getHeaders(): HashMap<String, String>
        public init(subtype: String, boundary: String, headers: HashMap<String, String>)
        测试场景:调用父类方法,确保传给父类的值准确
    ***/
    @TestCase
    func testMultipartPayloadGetHeaders06(): Unit {
        var multipartPayload06=MultipartPayload("subtype","boundary",HashMap<String,String>())
        var re=multipartPayload06.getHeaders()
        var header_value="multipart/" + "subtype"+"; boundary=\"" + multipartPayload06.getBoundary() + '"';
        var header_map=HashMap<String,String>([("Content-Type",header_value)])
        @Assert(re,header_map)
    }
    /***
        public func getPreamble(): String
        测试场景:默认构造器调用
    ***/
    @TestCase
    func testMultipartPayloadGetPreamble01(): Unit {
        var multipartPayload01=MultipartPayload()
        @Assert(multipartPayload01.getPreamble(),"")

        var multipartPayload02=MultipartPayload("boundary")
        @Assert(multipartPayload02.getPreamble(),"")

        var multipartPayload03=MultipartPayload("subtype","boundary")
        @Assert(multipartPayload03.getPreamble(),"")

        var multipartPayload04=MultipartPayload(HashMap<String,String>())
        @Assert(multipartPayload04.getPreamble(),"")

        var multipartPayload05=MultipartPayload("boundary",HashMap<String,String>())
        @Assert(multipartPayload05.getPreamble(),"")

        var multipartPayload06=MultipartPayload("subtype","boundary",HashMap<String,String>())
        @Assert(multipartPayload06.getPreamble(),"")
    }
    /***
        public func setEpilogue(Epilogue: String): Unit
        测试场景:单次/多次设置
    ***/
    @TestCase
    func testMultipartPayloadSetEpilogue01(): Unit {
        var multipartPayload01=MultipartPayload()
        multipartPayload01.setEpilogue("Epilogue")
        @Assert(multipartPayload01.getEpilogue(),"Epilogue")
        multipartPayload01.setEpilogue("Epilogue02")
        @Assert(multipartPayload01.getEpilogue(),"Epilogue02")

        var multipartPayload02=MultipartPayload("boundary")
        multipartPayload02.setEpilogue("Epilogue")
        @Assert(multipartPayload02.getEpilogue(),"Epilogue")
        multipartPayload02.setEpilogue("Epilogue02")
        @Assert(multipartPayload02.getEpilogue(),"Epilogue02")

        var multipartPayload03=MultipartPayload("subtype","boundary")
        multipartPayload03.setEpilogue("Epilogue")
        @Assert(multipartPayload03.getEpilogue(),"Epilogue")
        multipartPayload03.setEpilogue("Epilogue02")
        @Assert(multipartPayload03.getEpilogue(),"Epilogue02")

        var multipartPayload04=MultipartPayload(HashMap<String,String>())
        multipartPayload04.setEpilogue("Epilogue")
        @Assert(multipartPayload04.getEpilogue(),"Epilogue")
        multipartPayload04.setEpilogue("Epilogue02")
        @Assert(multipartPayload04.getEpilogue(),"Epilogue02")

        var multipartPayload05=MultipartPayload("boundary",HashMap<String,String>())
        multipartPayload05.setEpilogue("Epilogue")
        @Assert(multipartPayload05.getEpilogue(),"Epilogue")
        multipartPayload05.setEpilogue("Epilogue02")
        @Assert(multipartPayload05.getEpilogue(),"Epilogue02")

        var multipartPayload06=MultipartPayload("subtype","boundary",HashMap<String,String>())
        multipartPayload06.setEpilogue("Epilogue")
        @Assert(multipartPayload06.getEpilogue(),"Epilogue")
        multipartPayload06.setEpilogue("Epilogue02")
        @Assert(multipartPayload06.getEpilogue(),"Epilogue02")
    }
    /***
        public func setPreamble(preamble: String): Unit
        测试场景:单次、多次设置
    ***/
    @TestCase
    func testMultipartPayloadSetPreamble01(): Unit {
        var multipartPayload01=MultipartPayload()
        multipartPayload01.setPreamble("Preamble")
        @Assert(multipartPayload01.getPreamble(),"Preamble")
        multipartPayload01.setPreamble("Preamble02")
        @Assert(multipartPayload01.getPreamble(),"Preamble02")

        var multipartPayload02=MultipartPayload("boundary")
        multipartPayload02.setPreamble("Preamble")
        @Assert(multipartPayload02.getPreamble(),"Preamble")
        multipartPayload02.setPreamble("Preamble02")
        @Assert(multipartPayload02.getPreamble(),"Preamble02")

        var multipartPayload03=MultipartPayload("subtype","boundary")
        multipartPayload03.setPreamble("Preamble")
        @Assert(multipartPayload03.getPreamble(),"Preamble")
        multipartPayload03.setPreamble("Preamble02")
        @Assert(multipartPayload03.getPreamble(),"Preamble02")

        var multipartPayload04=MultipartPayload(HashMap<String,String>())
        multipartPayload04.setPreamble("Preamble")
        @Assert(multipartPayload04.getPreamble(),"Preamble")
        multipartPayload04.setPreamble("Preamble02")
        @Assert(multipartPayload04.getPreamble(),"Preamble02")

        var multipartPayload05=MultipartPayload("boundary",HashMap<String,String>())
        multipartPayload05.setPreamble("Preamble")
        @Assert(multipartPayload05.getPreamble(),"Preamble")
        multipartPayload05.setPreamble("Preamble02")
        @Assert(multipartPayload05.getPreamble(),"Preamble02")

        var multipartPayload06=MultipartPayload("subtype","boundary",HashMap<String,String>())
        multipartPayload06.setPreamble("Preamble")
        @Assert(multipartPayload06.getPreamble(),"Preamble")
        multipartPayload06.setPreamble("Preamble02")
        @Assert(multipartPayload06.getPreamble(),"Preamble02")
    }
}