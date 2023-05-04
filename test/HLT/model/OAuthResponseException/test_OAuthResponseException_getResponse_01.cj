// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*
from std import io.*
from std import fs.*
@Test
public class TestOAuthResponseExceptionV001{
    @TestCase
    func testOAuthResponseExceptionGetResponse01(): Unit {
        var response01=Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubCloseable(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream=ByteArrayStream()
        inputStream.write("hello world".toUtf8Array())
        var response02=Response(Int32(2),"message",HashMap<String,String>(),inputStream,ArrayList<Closeable>([sub01]))

        var oauthResponseException01=OAuthResponseException(response01)
        var oauthResponseException02=OAuthResponseException(response02)
        for (str in strValues) {
            for (int32Value in int32Values){
                response01=Response(int32Value,str,HashMap<String,String>(),str)
                inputStream.write("hello world".toUtf8Array())
                response02=Response(int32Value,str,HashMap<String,String>(),inputStream,ArrayList<Closeable>([sub01]))
                oauthResponseException01=OAuthResponseException(response01)
                oauthResponseException02=OAuthResponseException(response02)
                @Assert(oauthResponseException01.getResponse().toString(),response01.toString())
                @Assert(oauthResponseException02.getResponse().toString(),response02.toString())
            }
        }
    }
}

public class SubCloseable <: Closeable{
    public var file=File("newFile.txt",OpenOption.CreateOrTruncate(true))
    public static var flagClose=false
    public init(file:File){
        this.file=file
    }
    public func close(){
        this.file.close()
        flagClose=true
    }
}