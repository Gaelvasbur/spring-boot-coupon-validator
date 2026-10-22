package com.tenisstore.coupon.controller;

import com.tenisstore.coupon.dto.ValidateCouponRequest;
import com.tenisstore.coupon.dto.ValidateCouponResponse;
import com.tenisstore.coupon.service.CouponService;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/coupons")
public class CouponController {

    private final CouponService couponService;

    public CouponController(CouponService couponService) {
        this.couponService = couponService;
    }

    @PostMapping("/validate")
    public ValidateCouponResponse validate(@Valid @RequestBody ValidateCouponRequest request) {
        return couponService.validate(request);
    }
}
