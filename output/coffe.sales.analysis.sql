SELECT 
      SUM(transaction_qty)AS number_of_qty_sold,
      SUM (unit_price*transaction_qty) AS total_revenue,
      COUNT(transaction_id) AS total_number_of_sales,
      TO_CHAR(TRANSACTION_DATE,'YYYYMM') AS month_id,
      MONTHNAME(TRANSACTION_DATE) AS month_name,
      DAYNAME(TRANSACTION_DATE) AS day_name,
      
      
CASE 
WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
WHEN transaction_time BETWEEN '12:00:00' AND  '17:59:59' THEN 'Afternoon'
WHEN transaction_time BETWEEN '18:00:00' AND '20:59:59' THEN 'Evening'
ELSE 'Night '
END AS time_bucket,

 CASE 
         WHEN SUM(unit_price*transaction_qty) BETWEEN '0' AND '20' THEN 'Low'
          WHEN SUM(unit_price*transaction_qty) BETWEEN '21' AND '40' THEN 'Medium'
          WHEN SUM(unit_price*transaction_qty) BETWEEN '41' AND '60' THEN 'Hgh'
          ELSE'Very high'
          END AS sales_bucket,
        product_category,
       product_detail,
       product_type,
       store_location
FROM coffee.shop.sales
GROUP BY time_bucket,

       product_category,
       product_detail,
       product_type,
       store_location,
       month_id,
       month_name,
       day_name;

      