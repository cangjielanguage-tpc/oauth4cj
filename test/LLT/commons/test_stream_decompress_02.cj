// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

public import oauth4cj.*

import compress.zlib.*
import std.io.*

main (){
    try {
    	let bas: ByteArrayStream = ByteArrayStream(526)
    	let decoded: String = StreamUtils.getGzipStreamContents(bas)
    	println("decoded.size = ${decoded.size}")
    } catch (e: Exception) {
        //e.printStackTrace()
    	println(0)
    	return 0
    }
    return 1
}
