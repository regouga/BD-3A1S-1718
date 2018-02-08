create table course (
  courseno smallint,
  title varchar(80) not null,
  credits numeric(2,1) not null,
  syllabus text not null,
  primary key (courseno)
);

create table requires (
  main_course smallint,
  pre_requisite smallint,
  primary key (main_course, pre_requisite),
  foreign key (main_course) references course,
  foreign key (pre_requisite) references course
);

create table course_offering (
  courseno smallint,
  semester smallint,
  year smallint,
  primary key (courseno, semester, year),
  foreign key (courseno) references course
);

create table student (
  sid smallint,
  name varchar(80),
  primary key (sid)
);

create table enrols (
  sid smallint,
  courseno smallint,
  semester smallint,
  year smallint,
  grade numeric(2,1) not null,
  primary key (sid, courseno, semester, year),
  foreign key (courseno, semester, year) references course_offering
);

create table instructor (
  id smallint,
  name varchar(80),
  department varchar(200),
  primary key (id)
);

create table teaches (
  id smallint,
  courseno smallint,
  semester smallint,
  year smallint,
  primary key (id, courseno, semester, year),
  foreign key (id) references instructor,
  foreign key (courseno, semester, year) references course_offering
);
