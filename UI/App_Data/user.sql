USE [DataInteractionV2]
GO

INSERT INTO [dbo].[User]
           ([Username]
           ,[Password]
           ,[Email]
           ,[BlockCounter]
           ,[Status]
           ,[IsDeleted]
           ,[CreatedById]
           ,[LastModifiedById]
           ,[CreatedDate]
           ,[LastModifiedDate])
     VALUES
           (<Username, varchar(50),>
           ,<Password, varchar(64),>
           ,<Email, varchar(50),>
           ,<BlockCounter, int,>
           ,<Status, varchar(50),>
           ,<IsDeleted, bit,>
           ,<CreatedById, int,>
           ,<LastModifiedById, int,>
           ,<CreatedDate, datetime,>
           ,<LastModifiedDate, datetime,>)
GO

