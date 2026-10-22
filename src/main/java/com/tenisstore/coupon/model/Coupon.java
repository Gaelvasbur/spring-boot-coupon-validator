package com.tenisstore.coupon.model;

public class Coupon {

    private final String code;
    private final DiscountType type;
    private final double value;
    private final boolean active;

    public Coupon(String code, DiscountType type, double value, boolean active) {
        this.code = code;
        this.type = type;
        this.value = value;
        this.active = active;
    }

    public String getCode() {
        return code;
    }

    public DiscountType getType() {
        return type;
    }

    public double getValue() {
        return value;
    }

    public boolean isActive() {
        return active;
    }
}
