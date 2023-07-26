create table if not exists compilation (
compilation_id SERIAL primary key,
name VARCHAR(40) unique,
release_date date
);

create table if not exists album (
album_id SERIAL primary key,
name VARCHAR(60) unique,
release_date date
);

create table if not exists track (
track_id SERIAL primary key,
name VARCHAR(100),
duration TIME not null,
album_belonging INTEGER references album(album_id)
);

create table if not exists compilation_track (
compilation_track_id SERIAL primary key,
compilation_id INT not null,
track_id INT not null,
constraint fk_compilation foreign key(compilation_id) references compilation(compilation_id) on delete cascade,
constraint fk_track foreign key(track_id) references track(track_id) on delete cascade
);

create table if not exists artist (
artist_id SERIAL primary key,
name VARCHAR(80) unique
);

create table if not exists album_artist (
album_artist_id SERIAL primary key,
album_id INT not null,
artist_id INT not null,
constraint fk_album foreign key(album_id) references album(album_id) on delete cascade,
constraint fk_artist foreign key(artist_id) references artist(artist_id) on delete cascade
);

create table if not exists genre (
genre_id SERIAL primary key,
name VARCHAR(40) unique
);

create table if not exists artist_genre (
artist_genre_id SERIAL primary key,
artist_id INT not null,
genre_id INT not null,
constraint fk_artist foreign key(artist_id) references artist(artist_id) on delete cascade,
constraint fk_genre foreign key(genre_id) references genre(genre_id) on delete cascade
);

insert into artist(name)
values('Stuart Chatwood'), ('Christopher Larkin'), ('Carlos Viola'), ('NicolArmarfi');

insert into genre(name) 
values('Video Game Music'), ('Modern Classical'), ('Cinematic Classical'),
('Ambient'), ('Dark Ambient'), ('Martial Industrial'), ('Neoclassical Darkwave'), ('Chamber Music');

insert into album(name, release_date)
values('Darkest Dungeon OST', '2020-05-29'), ('Hollow Knight OST', '2017-02-10'),
('Blasphemous OST', '2019-09-10'), ('Katawa Shoujo: Enigmatic Box of Sound', '2012-01-20');

insert into track(name, duration, album_belonging)
values('The Hamlet', '00:02:58', '1');

insert into track(name, duration, album_belonging)
values('A Brief Respite', '00:02:18', '1'), ('Return to the Warrens', '00:01:22', '1'),
('The Final Combat', '00:05:21', '1'), ('Town in Chaos', '00:06:08', '1'),
('A Mocking Thirst', '00:00:56', '1'), ('All Things Must Come', '00:03:48', '1');

insert into track(name, duration, album_belonging)
values('Dirtmouth', '00:01:55', '2'), ('Greenpath', '00:03:37', '2'),
('Mantis Lords', '00:01:45', '2'), ('City of Tears', '00:02:58', '2'),
('Soul Sanctum', '00:04:30', '2'), ('Queen''s Gardens', '00:01:46', '2'),
('Radiance', '00:02:17', '2');

insert into track(name, duration, album_belonging)
values('Entregarás tu rostro a la señora', '00:03:25', '3'),
('Cantes de confesión', '00:05:35', '3'), ('Arpegios en ocre', '00:03:35', '3'),
('Para un mártir del compás', '00:05:30', '3'),
('Al compás de tus contornos', '00:04:48', '3'),
('Y yo fuego te daré', '00:03:42', '3'),
('Su beso de plata', '00:03:13', '3');

insert into track(name, duration, album_belonging)
values('Cold Iron', '00:03:03', '4'), ('Ease', '00:02:38', '4'), ('Hokabi', '00:02:21', '4'),
('Innocence', '00:02:59', '4'), ('Letting My Heart Speak', '00:02:37', '4');

insert into compilation(name, release_date)
values('Ambience', '2020-06-14'), ('Combat', '2020-09-06'),
('Boss Fight', '2021-02-25'), ('Favourites', '2021-07-04');

insert into album_artist(album_id, artist_id)
values('1', '1'), ('2', '2'), ('3', '3'), ('4', '4');

insert into artist_genre(artist_id, genre_id)
values('1', '1'), ('1', '2'), ('1', '3'), ('1', '5'), ('1', '6'),
('2', '1'), ('2', '3'), ('2', '4'), ('2', '7'),
('3', '1'), ('3', '7'),
('4', '1'), ('4', '2'), ('4', '4'), ('4', '8');

insert into compilation_track(compilation_id, track_id)
values('1', '1'), ('1', '2'), ('1', '8'), ('1', '9'), ('1', '11'), ('1', '12'),
('1', '13'), ('1', '15'), ('1', '16'), ('1', '17'), ('1', '18'), ('1', '19'),
('1', '22'), ('1', '23'), ('1', '24'), ('1', '25'), ('1', '26'), ('2', '3'),
('2', '5'), ('2', '6'), ('2', '7'), ('3', '4'), ('3', '10'), ('3', '12'), ('3', '14'),
('3', '20'), ('3', '21'), ('4', '7'), ('4', '10'), ('4', '19'), ('4', '25');

select name, duration from track order by duration desc limit 1;

select name from track where duration >= '00:03:30';

select name from compilation where release_date between '2018-01-01' and '2020-12-31';

select name from artist where (select split_part(name, ' ', 2)) = '';

select name from track where name ilike 'My %' or name ilike '% My'
 or name ilike '% My %' or name ilike 'My';

SELECT genre.name, COUNT(artist_id) FROM genre
  left JOIN artist_genre  
    ON artist_genre.genre_id = genre.genre_id
   group by genre.genre_id order by genre.genre_id;
    
    
SELECT COUNT(track.track_id) FROM track
  JOIN album ON track.album_belonging = album.album_id where album.release_date
  between '2019-01-01' and '2020-12-31';

SELECT album.name, avg(track.duration) FROM track
  JOIN album ON track.album_belonging = album.album_id
  group by album.album_id order by album.album_id;
    

SELECT artist.name FROM artist
  where artist.name not IN(
  select artist.name from artist 
  join album_artist on album_artist.artist_id = artist.artist_id
  join album on album_artist.album_id = album.album_id
  where album.release_date between '2020-01-01' and '2020-12-31');
  
    
SELECT compilation.name FROM compilation
  JOIN compilation_track
    ON compilation_track.compilation_id = compilation.compilation_id
  JOIN track
    ON compilation_track.track_id = track.track_id
  JOIN album 
    ON track.album_belonging = album.album_id
  JOIN album_artist
    ON album_artist.album_id = album.album_id
  JOIN artist
    ON album_artist.artist_id = artist.artist_id
   where artist.name = 'Carlos Viola'; 
    
    
    
    
    
    
    
    
    
    