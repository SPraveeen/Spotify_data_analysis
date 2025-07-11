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