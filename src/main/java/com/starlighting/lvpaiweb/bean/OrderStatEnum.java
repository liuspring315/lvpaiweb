package com.starlighting.lvpaiweb.bean;

/**
 * @功能说明：订单状态
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-16
 */
public enum OrderStatEnum {
    WAIT_APPROVE("未审核",0),
    APPROVE_YES("审核通过",1),
    APPROVE_NO("审核不通过",2)
    ;
    //资源编码
    private Integer code;
    //资源名称
    private String name;
    private OrderStatEnum(String name, Integer code) {
        this.code = code;
        this.name = name;
    }
    public static String getName(Integer code) {
        for (OrderStatEnum c : OrderStatEnum.values()) {
            if (c.getCode() == code) {
                return c.name;
            }
        }
        return null;
    }


    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
