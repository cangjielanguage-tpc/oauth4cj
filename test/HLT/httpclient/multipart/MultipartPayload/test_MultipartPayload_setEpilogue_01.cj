// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*
from oauth4cj import httpclient.multipart.*
@Test
public class TestMultipartPayloadB005{
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
}