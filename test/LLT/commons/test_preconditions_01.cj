// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from oauth4cj import commons.*

main (){

    try {//测试空字符串
    	Preconditions.checkEmptyString("", "empry string.")
    } catch (e: Exception) {
    	println(0)
    	return 0
    }
    return 1
}
