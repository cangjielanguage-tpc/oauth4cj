/**
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */
package oauth4cj

/**
 * OAuth Async Request Callback
 */
public interface OAuthAsyncRequestCallback {

    /**
     * Implementations of this method should close provided response in case it implements Response.Closeable
     *
     * @param response Response Object
     */
    func onCompleted(response: Any): Unit

    /**
     * Call this method when an exception occurs
     *
     * @param e Exception Object
     */
    func onThrowable(e: Exception): Unit
}

