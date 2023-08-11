// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/crypto4cj:oauth4cj/build/httpclient4cj
// 3rd_party_lib_ohos:oauth4cj/build/aarch64-linux-ohos/oauth4cj:oauth4cj/build/aarch64-linux-ohos/crypto4cj:oauth4cj/build/aarch64-linux-ohos/httpclient4cj
// dependence: ../common_Values.cj

@Test
public class TestFileByteArrayBodyPartPayload{
    /***
        public func getHeaders(): HashMap<String, String>
        测试场景:返回header，根据调用源返回
        public init(payload: Array<UInt8>)
        public init(payload: Array<UInt8>, off: Int64, len: Int64)
        public init(payload: Array<UInt8>, name: String)
    ***/
    @TestCase
    func testFileByteArrayBodyPartPayloadGetHeaders01(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload(Array<UInt8>())
        var re01=fileByteArrayBodyPartPayload01.getHeaders()
        var exp_header01=HashMap<String,String>([("Content-Disposition","form-data")])
        @Assert(re01,exp_header01)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload(Array<UInt8>(),1,100)
        var re02=fileByteArrayBodyPartPayload02.getHeaders()
        var exp_header02=exp_header01
        @Assert(re02,exp_header02)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload(Array<UInt8>(),"name_value")
        var re03=fileByteArrayBodyPartPayload03.getHeaders()
        var exp_header03=HashMap<String,String>([("Content-Disposition","form-data"+"; name=\""+"name_value"+"\"")])
        @Assert(re03,exp_header03)
    }
     /***
         public func getHeaders(): HashMap<String, String>
         测试场景:返回header，根据调用源返回
         public init(payload: Array<UInt8>, off: Int64, len: Int64, name: String)
         public init(payload: Array<UInt8>, name: String, filename: String)
         public init(payload: Array<UInt8>, off: Int64, len: Int64, name: String, filename: String)
     ***/
     @TestCase
     func testFileByteArrayBodyPartPayloadGetHeaders02(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload(Array<UInt8>(),1,1,"name_value")
        var re01=fileByteArrayBodyPartPayload01.getHeaders()
        var exp_header01=HashMap<String,String>([("Content-Disposition","form-data"+"; name=\""+"name_value"+"\"")])
        @Assert(re01,exp_header01)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload(Array<UInt8>(),"name_value","filename_value")
        var re02=fileByteArrayBodyPartPayload02.getHeaders()
        var exp_header02=HashMap<String,String>([("Content-Disposition","form-data"+"; name=\""+"name_value"+"\"; filename=\""+"filename_value"+"\"")])
        @Assert(re02,exp_header02)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload(Array<UInt8>(),1,200,"name_value","filename_value")
        var re03=fileByteArrayBodyPartPayload03.getHeaders()
        var exp_header03=HashMap<String,String>([("Content-Disposition","form-data"+"; name=\""+"name_value"+"\"; filename=\""+"filename_value"+"\"")])
        @Assert(re03,exp_header03)
     }
    /***
         public func getHeaders(): HashMap<String, String>
         测试场景:返回header，根据调用源返回
         public init(contentType: String, payload: Array<UInt8>)
         public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64)
         public init(contentType: String, payload: Array<UInt8>, name: String)
     ***/
     @TestCase
     func testFileByteArrayBodyPartPayloadGetHeaders03(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload("contentType",Array<UInt8>())
        var re01=fileByteArrayBodyPartPayload01.getHeaders()
        var exp_header01=HashMap<String,String>([("Content-Type","contentType"),("Content-Disposition","form-data")])
        @Assert(re01,exp_header01)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),1,1)
        var re02=fileByteArrayBodyPartPayload02.getHeaders()
        var exp_header02=HashMap<String,String>([("Content-Type","contentType"),("Content-Disposition","form-data")])
        @Assert(re02,exp_header02)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),"name_value")
        var re03=fileByteArrayBodyPartPayload03.getHeaders()
        var exp_header03=HashMap<String,String>([("Content-Type","contentType"),("Content-Disposition","form-data"+"; name=\""+"name_value"+"\"")])
        @Assert(re03,exp_header03)
     }
    /***
         public func getHeaders(): HashMap<String, String>
         测试场景:返回header，根据调用源返回
         public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64, name: String)
         public init(contentType: String, payload: Array<UInt8>, name: String, filename: String)
         public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64, name: String, filename: String)
     ***/
     @TestCase
     func testFileByteArrayBodyPartPayloadGetHeaders04(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),1,1,"name_value")
        var re01=fileByteArrayBodyPartPayload01.getHeaders()
        var exp_header01=HashMap<String,String>([("Content-Type","contentType"),("Content-Disposition","form-data"+"; name=\""+"name_value"+"\"")])
        @Assert(re01,exp_header01)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),"name_value","filename_value")
        var re02=fileByteArrayBodyPartPayload02.getHeaders()
        var exp_header02=HashMap<String,String>([("Content-Type","contentType"),("Content-Disposition","form-data"+"; name=\""+"name_value"+"\"; filename=\""+"filename_value"+"\"")])
        @Assert(re02,exp_header02)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),1,1,"name_value","filename_value")
        var re03=fileByteArrayBodyPartPayload03.getHeaders()
        var exp_header03=HashMap<String,String>([("Content-Type","contentType"),("Content-Disposition","form-data"+"; name=\""+"name_value"+"\"; filename=\""+"filename_value"+"\"")])
        @Assert(re03,exp_header03)
     }
    /***
        public func getLen(): Int64
        测试场景:获取off，根据调用源返回
        public init(payload: Array<UInt8>)
        public init(payload: Array<UInt8>, off: Int64, len: Int64)
        public init(payload: Array<UInt8>, name: String)
    ***/
    @TestCase
    func testFileByteArrayBodyPartPayloadgetLen01(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload(Array<UInt8>())
        var re01=fileByteArrayBodyPartPayload01.getLen()
        @Assert(re01,0)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload(Array<UInt8>(),1,100)
        var re02=fileByteArrayBodyPartPayload02.getLen()
        @Assert(re02,100)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload(Array<UInt8>(),"name_value")
        var re03=fileByteArrayBodyPartPayload03.getLen()
        @Assert(re03,0)
    }
     /***
         public func getLen(): Int64
         测试场景:获取off，根据调用源返回
         public init(payload: Array<UInt8>, off: Int64, len: Int64, name: String)
         public init(payload: Array<UInt8>, name: String, filename: String)
         public init(payload: Array<UInt8>, off: Int64, len: Int64, name: String, filename: String)
     ***/
     @TestCase
     func testFileByteArrayBodyPartPayloadgetLen02(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload(Array<UInt8>(),1,1,"name_value")
        var re01=fileByteArrayBodyPartPayload01.getLen()
        @Assert(re01,1)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload(Array<UInt8>(),"name_value","filename_value")
        var re02=fileByteArrayBodyPartPayload02.getLen()
        @Assert(re02,0)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload(Array<UInt8>(),1,200,"name_value","filename_value")
        var re03=fileByteArrayBodyPartPayload03.getLen()
        @Assert(re03,200)
     }
    /***
         public func getLen(): Int64
         测试场景:获取off，根据调用源返回
         public init(contentType: String, payload: Array<UInt8>)
         public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64)
         public init(contentType: String, payload: Array<UInt8>, name: String)
     ***/
     @TestCase
     func testFileByteArrayBodyPartPayloadgetLen03(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload("contentType",Array<UInt8>())
        var re01=fileByteArrayBodyPartPayload01.getLen()
        @Assert(re01,0)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),1,100)
        var re02=fileByteArrayBodyPartPayload02.getLen()
        @Assert(re02,100)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),"name_value")
        var re03=fileByteArrayBodyPartPayload03.getLen()
        @Assert(re03,0)
     }
    /***
         public func getLen(): Int64
         测试场景:获取off，根据调用源返回
         public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64, name: String)
         public init(contentType: String, payload: Array<UInt8>, name: String, filename: String)
         public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64, name: String, filename: String)
     ***/
     @TestCase
     func testFileByteArrayBodyPartPayloadgetLen04(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),1,100,"name_value")
        var re01=fileByteArrayBodyPartPayload01.getLen()
        @Assert(re01,100)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),"name_value","filename_value")
        var re02=fileByteArrayBodyPartPayload02.getLen()
        @Assert(re02,0)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),1,100,"name_value","filename_value")
        var re03=fileByteArrayBodyPartPayload03.getLen()
        @Assert(re03,100)
     }
    /***
        public func getOff(): Int64
        测试场景:获取off，根据调用源返回
        public init(payload: Array<UInt8>)
        public init(payload: Array<UInt8>, off: Int64, len: Int64)
        public init(payload: Array<UInt8>, name: String)
    ***/
    @TestCase
    func testFileByteArrayBodyPartPayloadGetOff01(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload(Array<UInt8>())
        var re01=fileByteArrayBodyPartPayload01.getOff()
        @Assert(re01,0)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload(Array<UInt8>(),1,100)
        var re02=fileByteArrayBodyPartPayload02.getOff()
        @Assert(re02,1)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload(Array<UInt8>(),"name_value")
        var re03=fileByteArrayBodyPartPayload03.getOff()
        @Assert(re03,0)
    }
     /***
         public func getOff(): Int64
         测试场景:获取off，根据调用源返回
         public init(payload: Array<UInt8>, off: Int64, len: Int64, name: String)
         public init(payload: Array<UInt8>, name: String, filename: String)
         public init(payload: Array<UInt8>, off: Int64, len: Int64, name: String, filename: String)
     ***/
     @TestCase
     func testFileByteArrayBodyPartPayloadGetOff02(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload(Array<UInt8>(),1,1,"name_value")
        var re01=fileByteArrayBodyPartPayload01.getOff()
        @Assert(re01,1)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload(Array<UInt8>(),"name_value","filename_value")
        var re02=fileByteArrayBodyPartPayload02.getOff()
        @Assert(re02,0)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload(Array<UInt8>(),1,200,"name_value","filename_value")
        var re03=fileByteArrayBodyPartPayload03.getOff()
        @Assert(re03,1)
     }
     /***
         public func getOff(): Int64
         测试场景:获取off，根据调用源返回
         public init(contentType: String, payload: Array<UInt8>)
         public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64)
         public init(contentType: String, payload: Array<UInt8>, name: String)
     ***/
     @TestCase
     func testFileByteArrayBodyPartPayloadGetOff03(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload("contentType",Array<UInt8>())
        var re01=fileByteArrayBodyPartPayload01.getOff()
        @Assert(re01,0)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),1,100)
        var re02=fileByteArrayBodyPartPayload02.getOff()
        @Assert(re02,1)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),"name_value")
        var re03=fileByteArrayBodyPartPayload03.getOff()
        @Assert(re03,0)
     }
     /***
         public func getOff(): Int64
         测试场景:获取off，根据调用源返回
         public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64, name: String)
         public init(contentType: String, payload: Array<UInt8>, name: String, filename: String)
         public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64, name: String, filename: String)
     ***/
     @TestCase
     func testFileByteArrayBodyPartPayloadGetOff04(): Unit {
        var fileByteArrayBodyPartPayload01=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),1,100,"name_value")
        var re01=fileByteArrayBodyPartPayload01.getOff()
        @Assert(re01,1)

        var fileByteArrayBodyPartPayload02=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),"name_value","filename_value")
        var re02=fileByteArrayBodyPartPayload02.getOff()
        @Assert(re02,0)

        var fileByteArrayBodyPartPayload03=FileByteArrayBodyPartPayload("contentType",Array<UInt8>(),1,100,"name_value","filename_value")
        var re03=fileByteArrayBodyPartPayload03.getOff()
        @Assert(re03,1)
     }
}