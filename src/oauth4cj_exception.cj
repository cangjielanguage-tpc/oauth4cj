/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the OAuth4cjException class.
 */
package oauth4cj


public open class OAuth4cjException <: Exception {
    /**
     * Create an OAuth4cjException instance
     */
    public init() {
        super()
    }

    /**
     * Create an OAuth4cjException instance
     *
     * @param string exception message
     */
    public init(string: String) {
        super(string)
    }

    /**
     * Override toString function 
     *
     * @return String exception message
     */
    public open func toString(): String {
        let className: String = "OAuth4cjException"
        let msg: String = this.message
        if (msg.isEmpty()) {
            return className
        }
        return "${className}: ${msg}"
    }
}

public open class OAuth4cjParametersMissingException <: OAuth4cjException {
    private static let MSG: String = "Could not find oauth parameters in request."
    private static let MSG_END: String = ". OAuth parameters must be specified with the addOAuthParameter() method."
    /**
     * Create an OAuth4cjParametersMissingException instance
     */
    public init() {
        super()
    }

    /**
     * Create an OAuth4cjParametersMissingException instance
     *
     * @param string exception message
     */
    public init(string: String) {
        super(MSG + string + MSG_END)
    }
    
    /**
     * Override toString function 
     *
     * @return String exception message
     */
    public open func toString(): String {
        let className: String = "OAuth4cjParametersMissingException"
        let msg: String = this.message
        if (msg.isEmpty()) {
            return className
        }
        return "${className}: ${msg}"
    }
}

// A private exception indicating a problem in the signature.
public open class OAuth4cjSignatureException <: OAuth4cjException {
    private static let MSG: String = "Error while signing string."
    /**
     * Create an OAuth4cjSignatureException instance
     */
    public init() {
        super()
    }
    
    /**
     * Create an OAuth4cjSignatureException instance
     *
     * @param string exception message
     */
    public init(string: String) {
        super(MSG + string)
    }
    
    /**
     * Override toString function 
     *
     * @return String exception message
     */
    public open func toString(): String {
        let className: String = "OAuth4cjSignatureException"
        let msg: String = this.message
        if (msg.isEmpty()) {
            return className
        }
        return "${className}: ${msg}"
    }
}
