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
    //name是/不是map的key之一
    @TestCase
    func testResponseGetHeader01(): Unit {
        var headers01=getHashMapByLength(10)
        var response01=Response(Int32(2),"message",headers01,"body")
        var sub01=SubCloseable(File("../../common_Values.cj",OpenOption.CreateOrTruncate(true)))
        var inputStream01=ByteArrayStream()
        var response02=Response(Int32(2),"message",headers01,inputStream01,ArrayList<Closeable>([sub01]))
        for (i in 0..headers01.size){
            @Assert(response01.getHeader(i.toString()),i.toString())
            @Assert(response02.getHeader(i.toString()),i.toString())
        }
        var flag_response01=0
        var flag_response02=0
        try{
            response01.getHeader("11")
        }catch(e:Exception){
            flag_response01=1
        }
        @Assert(flag_response01,1)
        try{
            response02.getHeader("11")
        }catch(e:Exception){
            flag_response02=1
        }
        @Assert(flag_response02,1)
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

public func getHashMapByLength(length:Int64):HashMap<String,String>{
    var hashmap=HashMap<String,String>()
    for (i in 0..length){
        hashmap.put(i.toString(),i.toString())
    }
    return hashmap
}