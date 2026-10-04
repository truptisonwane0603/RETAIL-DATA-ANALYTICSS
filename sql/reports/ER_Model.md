# Entity-Relationship (ER) Model

This document maps out how the tables in our retail database relate to one another.

## Core Relationships Summary
* **Orders** is the central fact table. Every order is placed by one **Customer**.
* **Order_Items** connects **Orders**, **Products**, and **Sellers**. A single order can have multiple items, each provided by a seller and linked to a product.
* **Order_Payments** and **Order_Reviews** are directly linked to the **Orders** table.
* **Category_Translation** connects to **Products** to provide English names.
* **Geolocation** acts as a standalone reference table to map zip codes (from customers or sellers) to coordinates.

## Visual ER Diagram

```mermaid
erDiagram
    CUSTOMERS ||--o{ ORDERS : "places"
    ORDERS ||--|{ ORDER_ITEMS : "contains"
    ORDERS ||--|{ ORDER_PAYMENTS : "paid via"
    ORDERS ||--o{ ORDER_REVIEWS : "receives"
    PRODUCTS ||--o{ ORDER_ITEMS : "included in"
    SELLERS ||--o{ ORDER_ITEMS : "fulfills"
    PRODUCTS }|--|| CATEGORY_TRANSLATION : "translates to"

    CUSTOMERS {
        string customer_id PK
        string customer_unique_id
        int customer_zip_code_prefix
    }
    ORDERS {
        string order_id PK
        string customer_id FK
        string order_status
    }
    ORDER_ITEMS {
        string order_id FK
        int order_item_id PK
        string product_id FK
        string seller_id FK
    }
    PRODUCTS {
        string product_id PK
        string product_category_name FK
    }
    SELLERS {
        string seller_id PK
        int seller_zip_code_prefix
    }
    ORDER_PAYMENTS {
        string order_id FK
        int payment_sequential PK
    }
    ORDER_REVIEWS {
        string review_id PK
        string order_id FK
    }
    CATEGORY_TRANSLATION {
        string product_category_name PK
        string product_category_name_english
    }