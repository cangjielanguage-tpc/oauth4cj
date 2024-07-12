/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights resvered.
 */

/**
 * @file The file declars the OkHttpProvider class.
 */
package oauth4cj

from std import sync.*
from std import io.*

/**
 * Provide HttpClient based on HttpClient configuration.
 */
class OAuthAsyncCompletionHandler <: Callback {

    private let callback: Option<OAuthAsyncRequestCallback>
    private let converter: Option<ResponseConverter>

    private var future: Option<Future<Any>> = None
    private var exception: Exception = Exception()

    private let m: MultiConditionMonitor = MultiConditionMonitor()
    private var notEmpty: ConditionID

    init(callback: Option<OAuthAsyncRequestCallback>, converter: Option<ResponseConverter>) {
        this.callback = callback
        this.converter = converter
        synchronized(m) {
            this.notEmpty = m.newCondition()
        }
    }

    public func onFailure(call: Call, exception: Exception): Unit {
        synchronized(m) {
            this.exception = exception
            match (callback) {
                case Some(v) => v.onThrowable(exception)
                case None => ()
            }
            let nowFuture: Future<Any> = spawn {
                return exception
            }
            this.future = Option<Future<Any>>.Some(nowFuture)
            m.notify(notEmpty)
        }
    }

    public func onResponse(call: Call, okHttpResponse: httpclient4cj.Response): Unit {
        synchronized(m) {
            let response: OAuth4cjResponse = OkHttpHttpClient.convertResponse(okHttpResponse)

            try {
                let t: Any = match (converter) {
                    case Some(v) => v.convert(response)
                    case None => response
                }

                let nowFuture: Future<Any> = spawn {
                    return t
                }
                this.future = Option<Future<Any>>.Some(nowFuture)
                m.notify(notEmpty)

                match (callback) {
                    case Some(v) => v.onCompleted(t)
                    case None => ()
                }
            } catch (e: Exception) {
                this.exception = e
                match (callback) {
                    case Some(v) => v.onThrowable(e)
                    case None => ()
                }

                let nowFuture: Future<Any> = spawn {
                    return e
                }
                this.future = Option<Future<Any>>.Some(nowFuture)
                m.notify(notEmpty)
            }
        }
    }

    func getFuture(): Future<Any> {
        synchronized(m) {
            var res: Future<Any> = spawn { return () }
            while (true) {
                match (this.future) {
                    case Some(v) =>
                        res = v
                        break
                    case None => m.wait(notEmpty)
                }
            }
            return res
        }
    }
}

