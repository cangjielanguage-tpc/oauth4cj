// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj:oauth4cj/build/okhttp
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from oauth4cj import model.*

@Test
public class TestTokenB001{
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
}