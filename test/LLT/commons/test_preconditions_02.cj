// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

public import oauth4cj.*

main (){

    try {//测试包含空格的字符串
    	Preconditions.checkEmptyString("ceshi checkEmptyString function.", "empry string.")
    } catch (e: Exception) {
    	println(1)
    	return 1
    }
    return 0
}
