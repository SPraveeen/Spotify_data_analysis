-- Advanced SQl Project -- Spotify

DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

select * from spotify
limit 10;

-- EDA
select count(*) from spotify

select count(distinct artist) from spotify;

select count(distinct album) from spotify;

select distinct album_type from spotify;

select max(duration_min) as max_min,min(duration_min) as min_minu from spotify;

select * from spotify
where duration_min=0;

delete from spotify
where duration_min=0;

select distinct channel from spotify;

select distinct most_played_on from spotify;

-- Data analysis - Easy Category

--1.Retrieve the names of all tracks that have more than 1 billion streams.
--2.List all albums along with their respective artists.
--3.Get the total number of comments for tracks where licensed = TRUE.
--4.Find all tracks that belong to the album type single.
--5.Count the total number of tracks by each artist.

--1.Retrieve the names of all tracks that have more than 1 billion streams.
select * from spotify
where stream>1000000000;

--2.List all albums along with their respective artists.
select distinct album,artist 
from spotify
order by 1 desc;

select distinct album 
from spotify
order by 1 desc;

--3.Get the total number of comments for tracks where licensed = TRUE.
select sum(comments)as total_comments 
from spotify
where licensed='true';

--4.Find all tracks that belong to the album type single.
select * from spotify
where album_type = 'single'

--5.Count the total number of tracks by each artist.
select count(track), artist
from spotify
group by artist
order by 1 desc;

------------------------------
-- Medium Level
------------------------------
--1.Calculate the average danceability of tracks in each album.
--2.Find the top 5 tracks with the highest energy values.
--3.List all tracks along with their views and likes where official_video = TRUE.
--4.For each album, calculate the total views of all associated tracks.
--5.Retrieve the track names that have been streamed on Spotify more than YouTube.


--1.Calculate the average danceability of tracks in each album.
select album,avg(danceability) as avg_danceability
from spotify
group by 1
order by 2 desc;

--2.Find the top 5 tracks with the highest energy values.
select track,
max(energy) from spotify
group by 1
order by 2 desc
limit 5;

--3.List all tracks along with their views and likes where official_video = TRUE.
select track,sum(views) as total_views,sum(likes)as total_likes 
from spotify
where official_video='true'
group by 1
order by 2 desc;

--4.For each album, calculate the total views of all associated tracks.
select album,track, sum(views) as total_views 
from spotify
group by 1,2
order by 3 desc;

--5.Retrieve the track names that have been streamed on Spotify more than YouTube.
/*
select track,count(*) as total_count from spotify
where most_played_on ='Spotify'
group by track
order by 2 desc;

select track,count(*) as total_count from spotify
where most_played_on ='Youtube'
group by track
order by 2 desc;
*/

select * from (
select track,
coalesce(sum(case when most_played_on='Youtube' then stream end ),0) as streamed_on_Youtube,
coalesce(sum(case when most_played_on='Spotify' then stream end ),0) as streamed_on_Spotify
from spotify
group by 1
) as t1
where streamed_on_Spotify > streamed_on_Youtube
and 
streamed_on_Youtube<>0;

/*
Advanced Level

Find the top 3 most-viewed tracks for each artist using window functions.
Write a query to find tracks where the liveness score is above the average.
Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
Find tracks where the energy-to-liveness ratio is greater than 1.2.
Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
*/