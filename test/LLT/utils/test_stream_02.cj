// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import utils.*

from std import io.*

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
