USE ig_clone; 

-- 1. Finding 5 Oldest Users

SELECT * 
FROM users
ORDER BY created_at
LIMIT 5;

-- 2. Most Popular Registration Date
SELECT 
    DAYNAME(created_at) AS day,
    count(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 2;

-- 3. Identify Inactive Users (users with no photos)
SELECT 
	username, image_url
FROM users
LEFT JOIN photos
	ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- 4. Identify most popular photo (and user who created it)

SELECT 
	username,
	photos.id, 
    photos.image_url, 
    COUNT(*) AS total_like
FROM photos
INNER JOIN likes
	ON likes.photo_id = photos.id
INNER JOIN users
	ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total_like DESC
LIMIT 1;

-- 5. Calculate avg number of photos per user

SELECT 
(SELECT COUNT(*) FROM photos)/
(SELECT COUNT(*) FROM users)
AS "Avg Number";

-- 6. Five Most popular hashtags

SELECT 
	tags.tag_name,
    COUNT(*) AS total
FROM photo_tags
JOIN tags
	ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total DESC
LIMIT 5;

-- 7 Finding Bots - users who have liked every single photo

SELECT 
	username,
    COUNT(*) AS num_like
FROM users
INNER JOIN likes
	ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_like = (SELECT COUNT(*) FROM photos);














-- 






 









































