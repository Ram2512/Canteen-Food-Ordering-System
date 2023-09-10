--Creating table menu

CREATE TABLE Menu(Food_ID NUMBER, Food_name VARCHAR2(20), Price NUMBER, Category VARCHAR2(20),CONSTRAINT Food_ID PRIMARY KEY (Food_ID));

DECLARE

ID NUMBER:=:Id;
Name VARCHAR2(20):=:Name;
Price NUMBER:=:Price;
Cate VARCHAR2(20):=:Cate;

BEGIN

INSERT INTO Menu VALUES(ID, Name, Price, Cate);

EXCEPTION
WHEN no_data_found THEN
DBMS_OUTPUT.PUT_LINE ('PLEASE INSERT VALUES');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE ('PLEASE ENTER CORRECT VALUES');
END;
/

SELECT * FROM MENU;

--Declaring a Cursor
DECLARE F_name menu.Food_Name%type;
Food_Cat menu.Category%type;
cursor M_Food is
SELECT Food_Name, Category FROM Menu;
BEGIN
OPEN M_Food;
LOOP
FETCH M_Food INTO F_name,Food_Cat;
EXIT WHEN M_Food%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(F_name || ' ' || Food_Cat||' ');
END LOOP;
CLOSE M_Food;
END;


--Creating table Orders & bills;

CREATE TABLE Orders(Order_ID NUMBER, Food_ID NUMBER, Customer_name VARCHAR2(20), Food_name VARCHAR2(20), Quantity NUMBER, Total_Price NUMBER, CONSTRAINT Order_ID PRIMARY KEY (Order_ID), CONSTRAINT fkb_F_ID FOREIGN KEY (Food_ID) REFERENCES Menu(Food_ID));

DECLARE
Ord_ID NUMBER:=:Ord_ID;
CName varchar2(20):=:CName;
ID number:=:ID;
Quantity number:=:Quantity;
FoodName varchar2(20);
I_Price number;
T_Price number;

BEGIN
SELECT Food_name INTO FoodName FROM Menu WHERE Food_ID=ID;
SELECT Price INTO I_Price FROM Menu WHERE Food_ID=ID;

T_Price:=I_Price * Quantity;

INSERT INTO Orders VALUES(Ord_ID, ID, CName, FoodName, Quantity, T_Price);

EXCEPTION
WHEN no_data_found THEN
DBMS_OUTPUT.PUT_LINE ('PLEASE INSERT VALUES');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE ('PLEASE ENTER CORRECT VALUES');
END;
/

SELECT * FROM Orders;

--Create table Bill;

CREATE TABLE Bill(Order_ID NUMBER, Customer_name VARCHAR2(20), Total_Price NUMBER, Amt_Paid NUMBER);

DECLARE
oID NUMBER:=:oID;
Amt_Paid NUMBER:=:PayAmt;
Total_Amt NUMBER;
CName VARCHAR2(20);

BEGIN
SELECT Total_Price INTO Total_Amt from Orders WHERE Order_ID=oID;
SELECT Customer_Name INTO CName from Orders WHERE Order_ID=oID;

INSERT INTO Bill VALUES(oID, CName, Total_Amt, Amt_Paid);

IF Amt_Paid >= Total_Amt THEN

DELETE FROM Orders WHERE Order_ID=oID;

END IF;

EXCEPTION
WHEN no_data_found THEN
DBMS_OUTPUT.PUT_LINE ('PLEASE INSERT VALUES');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE ('PLEASE ENTER CORRECT VALUES');
END;
/

SELECT * FROM Bill;


####################################################################################################################################

DROP TABLE Menu;
DROP TABLE Orders;
DROP TABLE Bill;