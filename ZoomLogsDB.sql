Drop Table [Messages];
Go
Drop Table Users;
Go
Drop View vUsersAndMessages
Go

Create Table dbo.Users(
	UserID int Not Null Identity,
	UserName varchar(100) Not Null,
	Constraint pkUsers Primary Key (UserID),
	Constraint uqUserName Unique (UserName)
);
Go

Create Table dbo.[Messages](
	MessageID int Identity Not Null,
	UserID int Not Null,
	MessageText varchar(300) Not Null,
	MessageTime time(0) Default Cast(GetDate() As time),
	MessageNegativity varchar(300) Null,
	Constraint pkMessages Primary Key (MessageID, UserID),
	Constraint fkUsers Foreign Key (UserID) References dbo.Users(UserID)
);
Go

--Creates view for messages
Create View vUsersAndMessages
	As Select
		Users.UserID, UserName, MessageText, MessageNegativity, MessageTime
			From Users Join [Messages]
				On Users.UserID = [Messages].UserID
Go

/*
---Inserts dummy data
Insert Into Users (UserName) Values ('Cameron'), ('Nick')
Go
Insert Into [Messages] (UserID ,MessageText, MessageNegativity)
	Values (1, 'Your a weeb', 'weeb'), (2, 'off your self', 'off your self');
Go

--Select View
Select * From vUsersAndMessages;
Go

Declare 
	@UserName varchar(300),
	@MessageText varchar(300),
	@MessageNegativity varchar(300)
Select
	@UserName = '',
	@MessageText = '',
	@MessageNegativity = ''

Execute dbo.InsertMessage @UserName, @MessageText, @MessageNegativity

Select * From vUsersAndMessages; */
