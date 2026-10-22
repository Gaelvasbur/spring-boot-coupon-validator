# Spring Boot Coupon Validator (Tennis Store)

A lightweight REST API microservice built with **Java 17** and **Spring Boot 3** to validate e-commerce promo codes and calculate cart discounts in real-time.

There is no external database setup required. Four sample coupons live in a `HashMap` in memory. The service automatically checks if a coupon exists, verifies its active status, and applies either a percentage or a fixed discount.

---

## Technical Features

* **Case-Insensitive Blueprint:** Coupon codes are checked regardless of casing (e.g., `cupon10` matches `CUPON10`).
* **Edge-Case Validation:** Business logic guarantees that the discount value never exceeds the `totalAmount`.
* **Zero Database Overhead:** Runs entirely in memory using standard Java collections, ensuring immediate execution.

---

## Core Endpoint

`POST /api/coupons/validate`

### 1. Request Body
```json
{
  "code": "CUPON10",
  "totalAmount": 100.0
}
```

### 2. Expected Responses

#### Valid Coupon
```json
{
  "valid": true,
  "discount": 10.0,
  "finalAmount": 90.0,
  "message": "¡Cupón aplicado con éxito!"
}
```

#### Invalid or Inactive Coupon
```json
{
  "valid": false,
  "discount": 0.0,
  "finalAmount": 100.0,
  "message": "Cupón inválido"
}
```

---

## Sample In-Memory Data

| Code | Type | Value | Active |
| :--- | :--- | :--- | :--- |
| **CUPON10** | Percentage | 10% | Yes |
| **KICKS20** | Percentage | 20% | Yes |
| **FIJO15** | Fixed Amount | \$15.00 | Yes |
| **EXPIRED** | Percentage | 50% | No |

---

## Tech Stack

* **Language:** Java 17 (LTS)
* **Framework:** Spring Boot 3.3.5
* **Core Modules:** Spring Web, Bean Validation
* **Build System:** Maven 3.9+ (includes Maven Wrapper)

---

## Requirements & Setup

### Environment
* JDK 17 installed
* Set `JAVA_HOME` pointing to your JDK 17 installation

### Run the API Locally

Navigate to the project root directory and execute:

**On Linux / macOS:**
```bash
./mvnw spring-boot:run
```

**On Windows:**
```bash
.\mvnw.cmd spring-boot:run
```

The server will initialize and listen for requests at: `http://localhost:8080`

---

## Automated Testing via cURL

### 1. Test 10% Off (`CUPON10`)
**Windows (Command Prompt):**
```cmd
curl -X POST http://localhost:8080/api/coupons/validate ^
  -H "Content-Type: application/json" ^
  -d "{\"code\":\"CUPON10\",\"totalAmount\":100.0}"
```
* **Expected Result:** `discount: 10.0`, `finalAmount: 90.0`

### 2. Test 20% Off (`KICKS20`)
**Windows (Command Prompt):**
```cmd
curl -X POST http://localhost:8080/api/coupons/validate ^
  -H "Content-Type: application/json" ^
  -d "{\"code\":\"KICKS20\",\"totalAmount\":100.0}"
```
* **Expected Result:** `discount: 20.0`, `finalAmount: 80.0`

### 3. Test Fixed \$15 Off (`FIJO15`)
**Windows (Command Prompt):**
```cmd
curl -X POST http://localhost:8080/api/coupons/validate ^
  -H "Content-Type: application/json" ^
  -d "{\"code\":\"FIJO15\",\"totalAmount\":100.0}"
```
* **Expected Result:** `discount: 15.0`, `finalAmount: 85.0`

### 4. Test Invalid Code
**Windows (Command Prompt):**
```cmd
curl -X POST http://localhost:8080/api/coupons/validate ^
  -H "Content-Type: application/json" ^
  -d "{\"code\":\"NOEXISTE\",\"totalAmount\":100.0}"
```
* **Expected Result:** `valid: false`, `discount: 0.0`, `finalAmount: 100.0`

### 5. Test Inactive Coupon (`EXPIRED`)
**Windows (Command Prompt):**
```cmd
curl -X POST http://localhost:8080/api/coupons/validate ^
  -H "Content-Type: application/json" ^
  -d "{\"code\":\"EXPIRED\",\"totalAmount\":100.0}"
```
* **Expected Result:** Returns the standard invalid schema (same as a missing code).

### Unix Syntax (Linux / macOS / WSL)
For execution on Unix-based shells, format your request with single quotes:
```bash
curl -X POST http://localhost:8080/api/coupons/validate \
  -H "Content-Type: application/json" \
  -d '{"code":"CUPON10","totalAmount":100.0}'
```
