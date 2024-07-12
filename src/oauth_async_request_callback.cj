/**
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
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

