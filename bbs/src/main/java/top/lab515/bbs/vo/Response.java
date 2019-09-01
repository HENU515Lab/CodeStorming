package top.lab515.bbs.vo;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/8/27 16:11
 * @description：同一返回对象
 */
public class Response {


    private boolean success;
    private String message;
    private Object body;

    /** 响应处理是否成功 */
    public boolean isSuccess() {
        return success;
    }
    public void setSuccess(boolean success) {
        this.success = success;
    }

    /** 响应处理的消息 */
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }

    /** 响应处理的返回内容 */
    public Object getBody() {
        return body;
    }
    public void setBody(Object body) {
        this.body = body;
    }

    public Response(boolean success, String message) {
        this.success = success;
        this.message = message;
    }

    public Response(boolean success, String message, Object body) {
        this.success = success;
        this.message = message;
        this.body = body;
    }

}

