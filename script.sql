create database News;
use News;
#Tao bang tai khoan
#Type_account 0 :doc gia, 1: writter, 2:admin
#status_account: trang thai cua tai khoan, 0:exits, 1: not exist
#Vip : 0: not vip, 1: vip
create table ACCOUNT
(
IDAccount int auto_increment  not null,
Username nvarchar(60) not null,
Email nvarchar(60) not null,
Pass nvarchar(60) not null,
Status_account int not null,
Type_account int not null,
Vip int not null,
constraint PK_TK primary key (IDAccount)
);

insert into ACCOUNT(Username,Email,Pass,Status_account,Type_account,Vip) values('HoangDuong','duong@gmail.com','1234',0,1,0);
#Tao bang thu muc cha
#status_cate: trang thai cua muc, 0:exits, 1: not exist
create table CATE_PARENTS
(
IDCate_Parents int auto_increment  not null,
Name_parentscate nvarchar(60) not null,
Status_parentscate int not null,
constraint PK_TK primary key (IDCate_Parents)
);
insert into CATE_PARENTS(Name_parentscate,Status_parentscate) value('Culture',0);
insert into CATE_PARENTS(Name_parentscate,Status_parentscate) value('Politics',0);
insert into CATE_PARENTS(Name_parentscate,Status_parentscate) value('Science',0);
insert into CATE_PARENTS(Name_parentscate,Status_parentscate) value('Economy',0);
insert into CATE_PARENTS(Name_parentscate,Status_parentscate) value('Military',0);


#Tao bang thu muc con
#Status_childcate: trang thai cua muc, 0:exits, 1: not exist
create table CATE_CHILD
(
IDCate_Child int auto_increment  not null,
FKIDCate_Parents int not null,
Name_childcate nvarchar(60) not null,
Status_childcate int not null,
constraint PK_TK primary key (IDCate_Child)
);

insert into CATE_CHILD(FKIDCate_Parents,Name_childcate,Status_childcate) value(1,'Sport',0);
insert into CATE_CHILD(FKIDCate_Parents,Name_childcate,Status_childcate) value(1,'Healthy',0);
insert into CATE_CHILD(FKIDCate_Parents,Name_childcate,Status_childcate) value(1,'Music',0);
insert into CATE_CHILD(FKIDCate_Parents,Name_childcate,Status_childcate) value(2,'Diplomatic',0);
insert into CATE_CHILD(FKIDCate_Parents,Name_childcate,Status_childcate) value(2,'Vote',0);
insert into CATE_CHILD(FKIDCate_Parents,Name_childcate,Status_childcate) value(2,'Hot News',0);
insert into CATE_CHILD(FKIDCate_Parents,Name_childcate,Status_childcate) value(3,'Invention',0);
insert into CATE_CHILD(FKIDCate_Parents,Name_childcate,Status_childcate) value(3,'Application',0);
insert into CATE_CHILD(FKIDCate_Parents,Name_childcate,Status_childcate) value(3,'Research',0);
insert into CATE_CHILD(FKIDCate_Parents,Name_childcate,Status_childcate) value(4,'Finance',0);
insert into CATE_CHILD(FKIDCate_Parents,Name_childcate,Status_childcate) value(4,'Consumption',0);
insert into CATE_CHILD(FKIDCate_Parents,Name_childcate,Status_childcate) value(4,'Stock Exchange',0);
insert into CATE_CHILD(FKIDCate_Parents,Name_childcate,Status_childcate) value(5,'Hot News',0);
insert into CATE_CHILD(FKIDCate_Parents,Name_childcate,Status_childcate) value(5,'Weapon Contract',0);
insert into CATE_CHILD(FKIDCate_Parents,Name_childcate,Status_childcate) value(5,'Armed Coflict',0);



#Tao bang Tag
create table TAG
(
IDTAG int auto_increment  not null,
Name_tag nvarchar(60) not null,
constraint PK_TK primary key (IDTAG)
);
insert into TAG(Name_tag) values('#hospital');
insert into TAG(Name_tag) values('#mytam');
insert into TAG(Name_tag) values('#sontung');
insert into TAG(Name_tag) values('#batanvlog');
insert into TAG(Name_tag) values('#bongda');

#Tao bang bai viet
#Status_post: trang thai bai viet, 0: published, 1:accepted,2:Pendding, 3: denied
#Thubnail: luu dia chi anh thumbnail cua bai viet
#Type_of_post: loai bai viet, 0: normal, 1: VIP
#Anh trong bai viet se duoc luu trong bang khac (FK)
create table POST
(
IDPost int auto_increment  not null,
Title nvarchar(300) not null,
Thumbnail nvarchar(60) not null,
Status_post int not null,
FKCategory int not null,
FKIDWritter_post int not null,
FKTag int not null,
DateComplete datetime not null,
Content nvarchar (1000) not null,
Num_of_View int not null,
Num_of_Like int not null,
Num_of_Comment int not null,
Type_of_post int not null,
constraint PK_TK primary key (IDPost)
);

#tao bang picture
#URL : luu lien ket toi anh, de nghi la luu static file trong project
create table PICTURE
(
IDPic int auto_increment  not null,
URL nvarchar(60) not null,
FKIDPost int not null,
constraint PK_TK primary key (IDPic)
);

#tao bang comment
create table POSTCOMMENT
(
IDComment int auto_increment  not null,
FKIDPost int not null,
FKIDUser int not null,
ContentComment nvarchar(1000) not null,
Like_of_Comment int not null,
constraint PK_TK primary key (IDComment)
);

#tao bang reply of comment
create table REPLYCOMMENT
(
IDReply int auto_increment  not null,
FKIDComment int not null,
FKIDUser int not null,
ContentReplyComment nvarchar(1000) not null,
Like_of_ReplyComment int not null,
constraint PK_TK primary key (IDReply)
);

#Add foreign key mysql
ALTER TABLE REPLYCOMMENT ADD CONSTRAINT FK_RPCOMM_COMM FOREIGN KEY (FKIDComment) REFERENCES POSTCOMMENT(IDComment);
ALTER TABLE REPLYCOMMENT ADD CONSTRAINT FK_RPCOMM_ACC FOREIGN KEY (FKIDUser) REFERENCES ACCOUNT(IDAccount);

ALTER TABLE POSTCOMMENT ADD CONSTRAINT FK_COMM_ACC FOREIGN KEY (FKIDUser) REFERENCES ACCOUNT(IDAccount);
ALTER TABLE POSTCOMMENT ADD CONSTRAINT FK_COMM_POST FOREIGN KEY (FKIDPost) REFERENCES POST(IDPost);

ALTER TABLE PICTURE ADD CONSTRAINT FK_PIC_POST FOREIGN KEY (FKIDPost) REFERENCES POST(IDPost);

ALTER TABLE POST ADD CONSTRAINT FK_POST_CATE FOREIGN KEY (FKCategory) REFERENCES CATE_CHILD(IDCate_Child);
ALTER TABLE POST ADD CONSTRAINT FK_POST_ACC FOREIGN KEY (FKIDWritter_post) REFERENCES ACCOUNT(IDAccount);
ALTER TABLE POST ADD CONSTRAINT FK_POST_TAG FOREIGN KEY (FKTag) REFERENCES TAG(IDTAG);

ALTER TABLE CATE_CHILD ADD CONSTRAINT FK_CATECHILD_CATEPARENTS FOREIGN KEY (FKIDCate_Parents) REFERENCES CATE_PARENTS(IDCate_Parents);


insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/imgs/imgs/post/1/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/2/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/3/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/4/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/5/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/6/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/7/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/8/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/9/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/10/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/11/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/12/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/13/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/14/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/15/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/16/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/17/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/18/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/19/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/20/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/21/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/22/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
insert into POST(Title,Thumbnail,Status_post,FKCategory,FKIDWritter_post,FKTag,DateComplete,Content,Num_of_View,Num_of_Like,Num_of_Comment,Type_of_post)
values('Coventry City Guide Including Coventry','/img/imgs/post/23/main_thumb.jpg',0,1,1,1,'2019-01-01','Hello world',10,20,30,0);
	