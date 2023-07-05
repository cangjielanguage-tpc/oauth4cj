// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import commons.*

from compress import zlib.*
from std import io.*

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
