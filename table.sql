drop database m_project;
create database m_project;
use m_project;
create table user (
u_id varchar(20) not null,
password varchar(20),
primary key(u_id)
)
character set = 'euckr';

create table album (
a_id int not null,
album_name varchar(20) not null unique,
a_artist varchar(20) not null unique,
primary key(a_id)
)
character set = 'euckr';

create table music(
m_id int,
title varchar(40) not null unique,
m_artist varchar(20) not null,
composer varchar(20),
lyricist varchar(20),
album_name varchar(20) not null,
numbering int,
r_date date,
primary key(m_id),
FOREIGN KEY(album_name) REFERENCES album(album_name),
FOREIGN KEY(m_artist) REFERENCES album(a_artist))
character set = 'euckr'
;

create table evaluation (
music_name varchar(40),
good int,
bad int,
primary key(music_name),
foreign key(music_name) references music(title)
)
character set = 'euckr';

create table playlist (
l_id int,
u_id varchar(20) not null,
playlist_title varchar(20) not null unique,
primary key(l_id, u_id),
foreign key(u_id) references user(u_id)
)
character set = 'euckr';

create table playlist_music (
l_id int,
order_number int,
title  varchar(40) not null,
artist varchar(20) not null,
primary key(l_id, order_number),
foreign key(l_id) references playlist(l_id),
foreign key(title) references music(title),
foreign key(artist) references album(a_artist)
)
character set = 'euckr';

create table playlist_evaluation (
playlist_title varchar(20),
good int,
bad int,
primary key(playlist_title),
foreign key(playlist_title) references playlist(playlist_title)
)
character set = 'euckr';

create table own_music (
u_id varchar(20),
m_id int,
primary key(u_id, m_id),
foreign key(u_id) references user(u_id),
foreign key(m_id) references music(m_id)
)
character set = 'euckr';



insert into user values("admin", "1234");

insert into album values(1, "테스트앨범1","테스트아티스트");
insert into album values(2, "테스트앨범2","어드민");
insert into album values(3, "테스트앨범3","admin");

insert into music values(1, "테스트제목1", "테스트아티스트", "테스트작곡가", "테스트작사가", "테스트앨범1",1,'2018-11-11');
insert into music values(2, "테스트제목2", "어드민", "테스트작곡가", "테스트작사가", "테스트앨범2",2,'2018-11-11');
insert into music values(3, "테스트제목3", "테스트아티스트", "테스트작곡가", "테스트작사가", "테스트앨범1",2,'2018-11-11');
insert into music values(4, "테스트제목5", "admin", "테스트작곡가", "테스트작사가", "테스트앨범3",1,'2018-11-11');

insert into evaluation values("테스트제목1", 10, 3);
insert into evaluation values("테스트제목2", 2, 0);
insert into evaluation values("테스트제목3", 8, 7);
insert into evaluation values("테스트제목5", 0, 0);

insert into playlist values(1, "admin", "admin리스트");

insert into playlist_music values (1, 1, '테스트제목2', '어드민');
insert into playlist_music values (1, 2, "테스트제목1", "테스트아티스트");

insert into playlist_evaluation values ('admin리스트', 100, 1);

insert into own_music values("admin", 2);