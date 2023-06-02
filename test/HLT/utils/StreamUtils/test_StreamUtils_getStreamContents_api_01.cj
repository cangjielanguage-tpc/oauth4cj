// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import utils.*
from std import io.*
from oauth4cj import exceptions.*
@Test
public class TestStreamUtilsB001{
    public var input=ByteArrayStream()
    public var re="not empty"

 	//is无内容,返回字符串准确
    @TestCase
    func testGetStreamContents01(): Unit {
        input=ByteArrayStream()
        var exp_flag=0
        try{
            re=StreamUtils.getStreamContents(input)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Cannot get String from a Null InputStream")){
                exp_flag=1
            }
        }
        @Assert(exp_flag,1)

        input=ByteArrayStream(1024)
        exp_flag=0
        try{
             re=StreamUtils.getStreamContents(input)
        }catch(e:OAuth4cjException){
            if(e.toString().contains("Cannot get String from a Null InputStream")){
                exp_flag=1
            }
        }
        @Assert(exp_flag,1)
    }   
}