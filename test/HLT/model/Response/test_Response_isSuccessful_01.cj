// 3rd_party_lib:oauth4cj/build/oauth4cj:oauth4cj/build/cryptocj
// dependence: ../../common_Values.cj

from std import unittest.*
from std import unittest.testmacro.*
from encoding import base64.*
from std import collection.*
from oauth4cj import model.*
from oauth4cj import utils.*
from std import io.*
from std import math.*
from std import fs.*
@Test
public class TestResponseV001{
    //code>=200 && code <400
    @TestCase
    func testResponseIsSuccessful01(): Unit {
        var response01=Response(Int32(2),"message",HashMap<String,String>(),"body")
        var sub01=SubCloseable(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream=ByteArrayStream()
        var response02=Response(Int32(2),"message",HashMap<String,String>(),inputStream,ArrayList<Closeable>([sub01]))

        var isSuccessfuls=Array<(Int32,Bool)>([(-1,false),
                                              (0,false),
                                              (199,false),
                                              (200,true),
                                              (201,true),
                                              (300,true),
                                              (399,true),
                                              (400,false),
                                              (Int32.Max,false)])
        var str="ceshi"
        for (i in 0..isSuccessfuls.size){
            response01=Response(isSuccessfuls[i][0],str,HashMap<String,String>(),str)
            response02=Response(isSuccessfuls[i][0],str,HashMap<String,String>(),inputStream,ArrayList<Closeable>([sub01]))
            @Assert(response01.isSuccessful(),isSuccessfuls[i][1])
            @Assert(response02.isSuccessful(),isSuccessfuls[i][1])
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