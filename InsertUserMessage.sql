-- =======================================================
-- Create Stored Procedure Template for Azure SQL Database
-- =======================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <NShokri, Store Message>
-- Create Date: <4/18/2020>
-- Description: <Given a Username, message, and specific word(nullable) It will insert into the database>
-- =============================================
CREATE PROCEDURE dbo.InsertMessage
(
    -- Add the parameters for the stored procedure here
	@UserName varchar(100),
	@MessageText varchar(300),
	@MessageNegativity varchar(300)
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
	If ((Select UserName From Users Where UserName = @UserName) Is Null)
		Insert Into Users (UserName) Values (@UserName)

	Insert Into [Messages]
		(UserID, MessageText, MessageNegativity)
			Values (
				
				(Select Top 1 UserID From Users Where UserName = @UserName)
				, @MessageText,
				Case
					When @MessageNegativity Is Null Then Null
					Else @MessageNegativity
				End);
END
GO