// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import utils.*

@Test
public class TestPreconditions03{
    public var params=Array<String>()
 	//str中包含空白字符，也包含非空白字符， 返回true
    @TestCase
    func testHasText03(): Unit {
        params=Array<String>(["abc","中\bzhong","中\nzhong"])//空白字符+非空白字符，加非空白字符
        for (param in params){
            @Assert(Preconditions.hasText(param),true)
        }
    }                      
} 