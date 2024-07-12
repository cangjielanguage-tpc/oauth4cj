/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */
package oauth4cj

from std import unicode.*

/**
 * OAuth token
 */
public open class Token {
    var rawResponse: String = ""

    /**
     * Constructor
     */
    public init() {}

    /**
     * Constructor
     *
     * @Param rawResponse raw response information
     */
    public init(rawResponse: String) {
        this.rawResponse = rawResponse
    }

    /**
     * get raw response information
     *
     * @Return String raw response information
     */
    public func getRawResponse(): String {
        return rawResponse
    }

    /**
     * gets the value of the specified parameter
     *
     * @Param parameter parameter name to find
     * @Return String the value corresponding to the parameter name
     */
    public func getParameter(parameter: String): String {
        var value:String = ""
        var valueArray:Array<String> = rawResponse.split("&")

        for (str in valueArray) {
            if (str.startsWith("${parameter}=")) {
                let paramArray:Array<String> = str.split("=")
                if (paramArray.size > 1) {
                    value = paramArray[1].trim()
                }
                break
            }
        }
        return value
    }
}