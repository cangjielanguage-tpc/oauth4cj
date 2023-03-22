/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 * Description:
 */

/**
 * @file The file declars the OAuth4cjException class.
 */
package exceptions


public open class OAuth4cjException <: Exception {
    public init() {
        super()
    }
    public init(string: String) {
        super(string)
    }
}

public open class OAuth4cjParametersMissingException <: OAuth4cjException {
    public init() {
        super()
    }
    public init(string: String) {
        super(string)
    }
}

/* A private exception indicating a problem in the signature. */
public open class OAuth4cjSignatureException <: OAuth4cjException {
    public init() {
        super()
    }
    public init(string: String) {
        super(string)
    }
}



