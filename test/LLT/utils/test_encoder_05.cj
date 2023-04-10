
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import utils.*

main (){
    let plain: Array<String> = ["Ladies + Gentlemen", "An encoded string!", "Dogs, Cats & Mice"]
    let encoded: Array<String> =
                        ["Ladies%20%2B%20Gentlemen", "An%20encoded%20string%21", "Dogs%2C%20Cats%20%26%20Mice"]

    for (i in 0..plain.size) {
    	if (OAuthEncoder.encode(plain[i]) != encoded[i]) {
    		println("encode: ${i} is false.")
    		return 1
    	}
    }

    for (i in 0..plain.size) {
    	if (OAuthEncoder.decode(encoded[i]) != plain[i]) {
    		println("decode: ${i} is false.")
    		return 2
    	}
    }
    return 0
}
