-- Traffic Source Analysis
-- Key Tables: Website Sessions, Pageviews & Order

USE mavenfuzzyfactory;

SELECT 
	website_sessions.utm_content,
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.order_id) AS orders,
    COUNT(DISTINCT orders.order_id)/COUNT(DISTINCT website_sessions.website_session_id) AS session_to_order_conv_rt
FROM website_sessions
	LEFT JOIN orders
		ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.website_session_id BETWEEN 1000 AND 2000 
GROUP BY
	utm_content
ORDER BY sessions DESC;-- arbitrary

-- Find out where the bulk of the website sessions are coming from.

SELECT 
	utm_source,
    utm_campaign,
    http_referer,
    COUNT(DISTINCT website_session_id) AS number_of_sessions
FROM website_sessions
WHERE created_at < '2012-04-12'
GROUP BY
	utm_source,
    utm_campaign,
    http_referer
ORDER BY number_of_sessions DESC;

-- Calculate the conversion rate (CVR) from session to order 


SELECT 	
	COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.order_id) AS orders,
    COUNT(DISTINCT orders.order_id)/COUNT(DISTINCT website_sessions.website_session_id) AS session_to_order_conv_rt
FROM website_sessions
	LEFT JOIN orders
		ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.created_at < '2012-04-14'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand';
    
-- Practice 

SELECT 
	WEEK(created_at),
    YEAR(created_at),
    MIN(DATE(created_at)) AS week_start,
	COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
WHERE website_session_id BETWEEN 100000 AND 115000 
GROUP BY 1,2;
    
SELECT 
	primary_product_id,
    order_id,
    items_purchased,
   COUNT(DISTINCT CASE WHEN items_purchased = 1 THEN order_id ELSE NULL END) AS count_single_item_orders,
   COUNT(DISTINCT CASE WHEN items_purchased = 2 THEN order_id ELSE NULL END) AS count_two_item_orders
FROM orders
WHERE order_id BETWEEN 31000 AND 320000
GROUP BY 1,2;
    
-- Pulling gsearch nonbrand trended session volume, by week

SELECT 
    MIN(DATE(created_at)) AS week_started_at,
    COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
WHERE created_at < '2012-05-12'
		AND utm_source = 'gsearch'
        AND utm_campaign = 'nonbrand'
GROUP BY 
	YEAR(created_at),
    WEEK(created_at);
    
-- Pull conversion rates from session to order - by device type

SELECT 
	website_sessions.device_type,
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
	COUNT(DISTINCT orders.order_id) AS orders,
    COUNT(DISTINCT orders.order_id)/COUNT(DISTINCT website_sessions.website_session_id) AS conv_rt
FROM website_sessions
	LEFT JOIN orders
		ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.created_at < '2012-05-11'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY 1;

-- Pull weekly trends for both desktip and mobile

SELECT 
    MIN(DATE(created_at)) AS week_start_date,
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN website_session_id ELSE NULL END) AS desktop_sessions,
	COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN website_session_id ELSE NULL END) AS mobile_sessions,
    COUNT(DISTINCT website_session_id) AS total_sessions
FROM website_sessions
WHERE website_sessions.created_at < '2012-06-09'
	AND website_sessions.created_at > '2012-04-15'
    AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY 
	YEAR(created_at),
    WEEK(created_at)




















    
    
    
    
    
    
    
    
    
    









































