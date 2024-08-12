-- liquibase formatted sql
-- changeset testdb:InitialSchemaCreation
CREATE TABLE TEST1
 (
                       ID INTEGER PRIMARY KEY,
                       NAME VARCHAR(24)
 );
-- rollback DROP TABLE TEST1;


-- liquibase formatted sql
-- changeset testdb:InsertData
INSERT INTO TEST1 (ID, NAME) VALUES (1, 'NAME1');
INSERT INTO TEST1 (ID,  NAME) VALUES (2, 'NAME2');
-- rollback DELETE FROM TEST1 WHERE ID in (1, 2);