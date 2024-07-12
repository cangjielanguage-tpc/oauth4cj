/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the TokenExtractor interface.
 */
package oauth4cj

from std import regex.*
from std import collection.*
from encoding import json.*
from encoding import url.*


/**
 * A simple command object for extracting specific tokens from strings.
 * The specific type of T is Token.
 */
public interface TokenExtractor<T> where T <: Token {

    /**
     * Extract specific types of tokens from the content of the HTTP response.
     *
     * @Param get token from the response
     *
     * @Return T specific types of Token
     * @throws IOException problem retrieving body from response
     */
    func extract(response: OAuth4cjResponse): T
}
