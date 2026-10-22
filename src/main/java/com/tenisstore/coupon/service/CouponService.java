package com.tenisstore.coupon.service;

import com.tenisstore.coupon.dto.ValidateCouponRequest;
import com.tenisstore.coupon.dto.ValidateCouponResponse;
import com.tenisstore.coupon.model.Coupon;
import com.tenisstore.coupon.model.DiscountType;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class CouponService {

    private final Map<String, Coupon> coupons = new HashMap<>();

    public CouponService() {
        coupons.put("CUPON10", new Coupon("CUPON10", DiscountType.PERCENTAGE, 10, true));
        coupons.put("KICKS20", new Coupon("KICKS20", DiscountType.PERCENTAGE, 20, true));
        coupons.put("FIJO15", new Coupon("FIJO15", DiscountType.FIXED, 15, true));
        coupons.put("EXPIRED", new Coupon("EXPIRED", DiscountType.PERCENTAGE, 50, false));
    }

    public ValidateCouponResponse validate(ValidateCouponRequest request) {
        double totalAmount = request.getTotalAmount();
        Coupon coupon = coupons.get(request.getCode().trim().toUpperCase());

        if (coupon == null || !coupon.isActive()) {
            return new ValidateCouponResponse(false, 0.0, totalAmount, "Cupón inválido");
        }

        double discount = calculateDiscount(coupon, totalAmount);
        double finalAmount = round(totalAmount - discount);

        return new ValidateCouponResponse(true, discount, finalAmount, "¡Cupón aplicado con éxito!");
    }

    private double calculateDiscount(Coupon coupon, double totalAmount) {
        double discount = coupon.getType() == DiscountType.PERCENTAGE
                ? totalAmount * (coupon.getValue() / 100)
                : coupon.getValue();

        return round(Math.min(discount, totalAmount));
    }

    private double round(double value) {
        return Math.round(value * 100.0) / 100.0;
    }
}
