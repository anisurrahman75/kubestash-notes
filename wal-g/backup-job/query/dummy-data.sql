
/opt/mssql-tools/bin/sqlcmd -S mssqlserver-ag -U sa -P "Pa55w0rd!" -Q "USE agdb1; CREATE TABLE tblAuthors(Id INT IDENTITY PRIMARY KEY, Author_name NVARCHAR(50), country NVARCHAR(50)); CREATE TABLE tblBooks(Id INT IDENTITY PRIMARY KEY, Author_id INT FOREIGN KEY REFERENCES tblAuthors(Id), Price INT, Edition INT); DECLARE @Id INT; SET @Id = 1; WHILE @Id <= 20000 BEGIN INSERT INTO tblAuthors VALUES ('Author - ' + CAST(@Id AS NVARCHAR(10)), 'Country - ' + CAST(@Id AS NVARCHAR(10)) + ' name'); PRINT @Id; SET @Id = @Id + 1; END"


# Count Data:
/opt/mssql-tools/bin/sqlcmd -S mssqlserver-ag -U sa -P "Pa55w0rd!" -Q "USE agdb1; SELECT (SELECT COUNT(*) FROM tblAuthors) AS AuthorCount, (SELECT COUNT(*) FROM tblBooks) AS BookCount;"

