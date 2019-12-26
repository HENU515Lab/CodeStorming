package com.seriouszyx.bbs.back.util;

import java.io.Serializable;

public class JsonResult implements Serializable {

    public static final int SUCCESS = 0;
    public static final int ERROR = -1;

    private int code;
    /** 错误消息  */
    private String msg;
    /** 返回正确时候的数据 */
    private Object data;

    public JsonResult() {
    }

    public JsonResult(String error){
        code = ERROR;
        this.msg = error;
    }

    public JsonResult(Object data){
        code = SUCCESS;
        this.data = data;
    }

    public JsonResult(Throwable e) {
        code = ERROR;
        msg = e.getMessage();
    }

    public JsonResult(int state, Throwable e) {
        this.code = state;
        this.msg = e.getMessage();
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "JsonResult [code=" + code + ", message=" + msg + ", data=" + data + "]";
    }

}
