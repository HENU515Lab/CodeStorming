package top.lab515.bbs.vo;

/**
 * @author ：Yixiang Zhao
 * @date ：Created in 2019/9/1 16:05
 * @description：Tag 值对象
 */
public class TagVO {

    private String name;
    private Long count;

    public TagVO(String name, Long count) {
        this.name = name;
        this.count = count;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }

}
