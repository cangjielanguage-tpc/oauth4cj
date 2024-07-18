// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

public import oauth4cj.*

import std.io.*

main (){
    try {
    	let bas: ByteArrayStream = ByteArrayStream(526)
    	let decoded: String = StreamUtils.getStreamContents(bas)
        println("decoded = ${decoded}")
    } catch (e: Exception) {
        //e.printStackTrace()
    	println(0)
    	return 0
    }
    return 1
}
