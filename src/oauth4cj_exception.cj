/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */

/**
 * @file The file declars the OAuth4cjException class.
 */
package oauth4cj


public open class OAuth4cjException <: Exception {
    public init() {
        super()
    }
    public init(string: String) {
        super(string)
    }
}

public open class OAuth4cjParametersMissingException <: OAuth4cjException {
    private static let MSG: String = "Could not find oauth parameters in request: "
    private static let MSG_END: String = ". OAuth parameters must be specified with the addOAuthParameter() method"
    public init() {
        super()
    }
    public init(string: String) {
        super(MSG + string + MSG_END)
    }
}

// A private exception indicating a problem in the signature.
public open class OAuth4cjSignatureException <: OAuth4cjException {
    private static let MSG: String = "Error while signing string: "
    public init() {
        super()
    }
    public init(string: String) {
        super(MSG + string)
    }
}
