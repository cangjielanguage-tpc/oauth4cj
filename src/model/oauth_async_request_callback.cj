/**
 * Copyright (c) Cangjie Library Team 2023-2023. All rights reserved.
 */
package model

/**
 * OAuth Async Request Callback
 */
public interface OAuthAsyncRequestCallback<T> {

    /**
     * Implementations of this method should close provided response in case it implements Response.Closeable
     *
     * @param response Response Object
     */
    func onCompleted(response: T): Unit

    /**
     * Call this method when an exception occurs
     *
     * @param e Exception Object
     */
    func onThrowable(e: Exception): Unit
}

