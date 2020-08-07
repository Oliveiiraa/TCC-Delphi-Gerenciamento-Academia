CREATE DATABASE TCC
USE TCC

drop database TCC
----------------------------------------------------------------------------------------------------------
------------------------------------------------ TABELAS -----------------------------------------------------
----------------------------------------------------------------------------------------------------------





----------------------------------------------------------------------------------------------------------
-------------------------------------------- Tabela Usuarios ----------------------------------------------------

CREATE TABLE TB_USUARIOS (
	COD_USU  INT IDENTITY PRIMARY KEY,
	NM_USU   VARCHAR(30) NOT NULL,
	LG_USU   VARCHAR(30) NOT NULL,
	SN_USU   VARCHAR(15) NOT NULL,
	TP_USU   BIT         NOT NULL         
)



---------------------------------------------Fim TB_Usuarios-----------------------------------------------------
----------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------
------------------------------------------ Tabela Funcionários -------------------------------------------

CREATE TABLE TB_FUNCIONARIOS (
	COD_FUNC INT IDENTITY PRIMARY KEY,
	NM_FUNC  VARCHAR(50)   NOT NULL,
	END_FUNC VARCHAR(50)   NOT NULL,
	CPF_FUNC VARCHAR(15)   NOT NULL,
	RG_FUNC  VARCHAR(15)   NOT NULL,
	TEL_FUNC VARCHAR(15)   NOT NULL,
	DTNASC_FUNC DATE       NOT NULL,
	EML_FUNC VARCHAR(50)   NOT NULL,
	SX_FUNC  VARCHAR(30)   NOT NULL,
	STA_FUNC BIT           NOT NULL,
	FT_FUNC  VARCHAR(255)  NOT NULL,
	COD_USU INT FOREIGN KEY REFERENCES TB_USUARIOS(COD_USU)
)

--------------------------------------------Fim TB_Funcionarios-------------------------------------------------------------
----------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------
--------------------------------------------Tabela Clientes----------------------------------------------

CREATE TABLE TB_CLIENTES (
	COD_CLI INT IDENTITY PRIMARY KEY,
	NM_CLI	VARCHAR(50) NOT NULL,
	END_CLI VARCHAR(50) NOT NULL,
	CPF_CLI VARCHAR(15) NOT NULL,
	RG_CLI	VARCHAR(15) NOT NULL,
	TEL_CLI VARCHAR(15) NOT NULL,
	DTMATRI_CLI DATE    NOT NULL,
	DTNASC_CLI DATE     NOT NULL,
	EML_CLI VARCHAR(50) NOT NULL,
	STA_CLI BIT			NOT NULL,
	SX_CLI  VARCHAR(30)	NOT NULL,
	FT_CLI  VARCHAR(255)NOT NULL,
	TPT_CLI VARCHAR(30) NOT NULL,
	COD_USU INT FOREIGN KEY REFERENCES TB_USUARIOS(COD_USU)
) 


-------------------------------------------Fim TB_Clientes---------------------------------------------------
----------------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------------
------------------------------------------Tabela Medidas---------------------------------------------------


CREATE TABLE TB_MEDIDAS (
	COD_MD   INT IDENTITY PRIMARY KEY,
	DTAVF_MD DATE NOT NULL,
	PS_MD    DECIMAL(9,2) NULL,
	AT_MD    DECIMAL(9,2) NULL,
	BC_MD    DECIMAL(9,2) NULL,
	TC_MD    DECIMAL(9,2) NULL,
	PT_MD    DECIMAL(9,2) NULL,
	QD_MD    DECIMAL(9,2) NULL,
	CT_MD    DECIMAL(9,2) NULL, 
	CX_MD    DECIMAL(9,2) NULL,
	OB_MD    DECIMAL(9,2) NULL,
	PTR_MD   DECIMAL(9,2) NULL,
	COD_CLI  INT FOREIGN KEY REFERENCES TB_CLIENTES(COD_CLI) 
)


-----------------------------------------Fim TB_Medidas---------------------------------------------------
---------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------
--------------------------------------Tabela Mensalidades------------------------------------------------


CREATE TABLE TB_MENSALIDADES (
	COD_MSD INT IDENTITY PRIMARY KEY,
	DTPAG_MSD DATE  NULL,
	DTVENC_MSD DATE NOT NULL,
	VL_MSD MONEY NOT NULL,
	COD_CLI INT FOREIGN KEY REFERENCES TB_CLIENTES(COD_CLI)
)

---------------------------------------Fim TB_Mensalidades-----------------------------------------------
---------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------
---------------------------------------Tabela Despesas--------------------------------------------------
CREATE TABLE TB_DESPESAS (
	COD_DPS INT IDENTITY PRIMARY KEY,
	DSC_DPS VARCHAR(100) NOT NULL,
	DT_DPS  DATE         NOT NULL,
	VL_DPS  MONEY        NOT NULL,
	NM_FUNC VARCHAR(50)  NOT NULL,
	COD_USU INT FOREIGN KEY REFERENCES TB_USUARIOS(COD_USU)
)

--------------------------------------Fim TB_Depesas-----------------------------------------------------
--------------------------------------------------------------------------------------------------------






---------------------------------------------------------------------------------------------------------
------------------------------------------PROCEDURES-----------------------------------------------------
---------------------------------------------------------------------------------------------------------




--------------------------------------------------------------------------------------------------------
----------------------------------------Procedures CLIENTE----------------------------------------------


/*Cadastra*/

CREATE PROCEDURE SP_CADASCLI
	@NOME VARCHAR(50),
	@END_CLI VARCHAR(50),
	@CPF_CLI VARCHAR(15),
	@RG_CLI	VARCHAR(15),
	@TEL_CLI VARCHAR(15),
	@DTMATRI_CLI DATE,
	@DTNASC_CLI DATE,
	@EML_CLI VARCHAR(50),
	@STA_CLI BIT,
	@SX_CLI  VARCHAR(30),
	@FT_CLI  VARCHAR(255),
	@TPT_CLI VARCHAR(30),
	@COD_USU INT
AS
BEGIN
	INSERT INTO TB_CLIENTES VALUES (@NOME,@END_CLI,@CPF_CLI,@RG_CLI,@TEL_CLI,@DTMATRI_CLI,@DTNASC_CLI,@EML_CLI,@STA_CLI,@SX_CLI,@FT_CLI,@TPT_CLI,@COD_USU)
END


/* ALTERA*/

CREATE PROCEDURE SP_ALTERCLI
	@COD_CLI INT,
	@NOME VARCHAR(50),
	@END_CLI VARCHAR(50),
	@CPF_CLI VARCHAR(15),
	@RG_CLI	VARCHAR(15),
	@TEL_CLI VARCHAR(15),
	@DTMATRI_CLI DATE,
	@DTNASC_CLI DATE,
	@EML_CLI VARCHAR(50),
	@STA_CLI BIT,
	@SX_CLI  VARCHAR(30),
	@FT_CLI  VARCHAR(255),
	@TPT_CLI  VARCHAR(30),
	@COD_USU INT
AS
BEGIN
	UPDATE TB_CLIENTES SET NM_CLI = @NOME, END_CLI = @END_CLI,CPF_CLI = @CPF_CLI,RG_CLI = @RG_CLI,TEL_CLI = @TEL_CLI,DTMATRI_CLI = @DTMATRI_CLI,
	DTNASC_CLI = @DTNASC_CLI,EML_CLI = @EML_CLI,STA_CLI = @STA_CLI, SX_CLI = @SX_CLI,FT_CLI = @FT_CLI,TPT_CLI = @TPT_CLI,COD_USU = @COD_USU WHERE COD_CLI = @COD_CLI
END	


-------------------------------------Fim Procedures CLIENTE-----------------------------------------------
---------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------
---------------------------------------Procedure MEDIDAS----------------------------------------------------


/*CADASTRA*/

CREATE PROCEDURE SP_CADASMEDIDAS
	@DTAVF_MD DATE,
	@PS_MD    DECIMAL(9,2),
	@AT_MD    DECIMAL(9,2),
	@BC_MD    DECIMAL(9,2),
	@TC_MD    DECIMAL(9,2),
	@PT_MD    DECIMAL(9,2),
	@QD_MD    DECIMAL(9,2),
	@CT_MD    DECIMAL(9,2), 
	@CX_MD    DECIMAL(9,2),
	@OB_MD    DECIMAL(9,2),
	@PTR_MD   DECIMAL(9,2),
	@COD_CLI  INT
AS
BEGIN
	INSERT INTO TB_MEDIDAS VALUES (@DTAVF_MD,@PS_MD,@AT_MD,@BC_MD,@TC_MD,@PT_MD,@QD_MD,@CT_MD,@CX_MD,@OB_MD,@PTR_MD,@COD_CLI)
END	

-------------------------------------Fim Procedure MEDIDAS------------------------------------------------
----------------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------------
------------------------------------Procedures FUNCIONÁRIOS---------------------------------------------


/* CADASTRA*/

CREATE PROCEDURE SP_CADASFUNC
	@NOME VARCHAR(50),
	@END_FUNC VARCHAR(50),
	@CPF_FUNC VARCHAR(15),
	@RG_FUNC  VARCHAR(15),
	@TEL      VARCHAR(15),
	@DTNASC_FUNC DATE,
	@EML_FUNC VARCHAR(50),
	@SX_FUNC  VARCHAR(30),
	@STA_FUNC BIT,
	@FT_FUNC VARCHAR(255),
	@COD_USU INT
AS
BEGIN
	INSERT INTO TB_FUNCIONARIOS VALUES (@NOME,@END_FUNC,@CPF_FUNC,@RG_FUNC,@TEL,@DTNASC_FUNC,@EML_FUNC,@SX_FUNC,@STA_FUNC,@FT_FUNC,@COD_USU)
END

/*ALTERA*/

CREATE PROCEDURE SP_ALTERFUNC
	@COD_FUNC INT,
	@NOME VARCHAR(50),
	@END_FUNC VARCHAR(50),
	@CPF_FUNC VARCHAR(15),
	@RG_FUNC  VARCHAR(15),
	@TEL      VARCHAR(15),
	@DTNASC_FUNC DATE,
	@EML_FUNC VARCHAR(50),
	@SX_FUNC  VARCHAR(30),	
	@STA_FUNC BIT,
	@FT_FUNC VARCHAR(255),
	@COD_USU INT
AS
BEGIN
	UPDATE TB_FUNCIONARIOS SET NM_FUNC = @NOME,END_FUNC = @END_FUNC,CPF_FUNC = @CPF_FUNC,RG_FUNC = @RG_FUNC,TEL_FUNC = @TEL,DTNASC_FUNC=@DTNASC_FUNC,EML_FUNC = @EML_FUNC,
	SX_FUNC = @SX_FUNC,STA_FUNC = @STA_FUNC,FT_FUNC = @FT_FUNC,COD_USU = @COD_USU WHERE COD_FUNC = @COD_FUNC
END

--------------------------------------Fim Procedures FUNCIONÁRIOS-----------------------------------------
----------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------
----------------------------------------Procedure USUARIOS------------------------------------------------



/*CADASTRO*/

CREATE PROCEDURE SP_CADASUSU
	@NM_USU   VARCHAR(30),
	@LG_USU   VARCHAR(30),
	@SN_USU   VARCHAR(15),
	@TP_USU   BIT
AS
BEGIN
	INSERT INTO TB_USUARIOS (NM_USU,LG_USU,SN_USU,TP_USU) VALUES (@NM_USU,@LG_USU,@SN_USU,@TP_USU)
END	


---------------------------------------Fim Procedure USUARIOS---------------------------------------------
----------------------------------------------------------------------------------------------------------

/*CREATE PROCEDURE SP_ALTERUSU
	@COD_USU INT,
	@NM_USU   VARCHAR(30),
	@LG_USU   VARCHAR(30),
	@SN_USU   VARCHAR(15),
	@TP_USU   BIT
AS
BEGIN
	UPDATE TB_USUARIOS SET NM_USU = @NM_USU,LG_USU = @LG_USU,SN_USU = @SN_USU,TP_USU = @TP_USU WHERE COD_USU = @COD_USU
END*/


---------------------------------------------------------------------------------------------------------
---------------------------------------Procedure DESPESAS------------------------------------------------

/*CADASTRA*/

CREATE PROCEDURE SP_CADASDPS
	@DSC_DPS VARCHAR(100),
	@DT_DPS  DATE,
	@VL_DPS  MONEY,
	@NM_FUNC VARCHAR(50),
	@COD_USU INT
AS
BEGIN
	INSERT INTO TB_DESPESAS VALUES (@DSC_DPS,@DT_DPS,@VL_DPS,@NM_FUNC,@COD_USU)
END	

------------------------------------Fim Procedure DESPESAS------------------------------------------------
----------------------------------------------------------------------------------------------------------

/*CREATE PROCEDURE SP_ALTERDPS
	@COD_DPS INT,
	@DSC_DPS VARCHAR(100),
	@DT_DPS DATE,
	@VL_DPS MONEY,
	@NM_FUNC VARCHAR(50)
AS
BEGIN
	UPDATE TB_DESPESAS SET DSC_DPS = @DSC_DPS,DT_DPS = @DT_DPS,VL_DPS = @VL_DPS, NM_FUNC = @NM_FUNC WHERE COD_DPS = @COD_DPS
END	*/


---------------------------------------------------------------------------------------------------------
---------------------------------------Procedure MENSALIDADES--------------------------------------------

/*CADASTRA*/

CREATE PROCEDURE SP_CADASMENSA @DTPAG_MSD DATE,
							   @DTVENC_MSD DATE,
	                           @VL_MSD MONEY,
	                           @COD_CLI INT
AS
BEGIN
	INSERT INTO TB_MENSALIDADES (DTPAG_MSD,DTVENC_MSD,VL_MSD,COD_CLI) VALUES(@DTPAG_MSD,@DTVENC_MSD,@VL_MSD,@COD_CLI)
END	  

/*ALTERA*/

CREATE PROCEDURE SP_ALTERMENSA	@COD INT,
								@DATA DATE,
								@data2 DATE,
								@VALOR MONEY
AS
BEGIN
	UPDATE TB_MENSALIDADES SET DTPAG_MSD = @DATA, DTVENC_MSD = @data2,VL_MSD = @VALOR WHERE COD_MSD = @COD
END 

----------------------------------Fim Procedures MENSALIDADES--------------------------------------------
---------------------------------------------------------------------------------------------------------




--------------------------------------------------------------------------------------------------------
--------------------------------------------Dados---------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------
 
 
 /*USUARIOS*/

select * from TB_USUARIOS

exec SP_CADASUSU 'Pedro Paulo','Pedro','123456789',1
exec SP_CADASUSU 'João Carlos','Joao','12345678',0
exec SP_CADASUSU 'Gabriela Oliveira','Gabriela','1234567',0
exec SP_CADASUSU 'Rodolfo Reis','rodolfo','123456',1
exec SP_CADASUSU 'Bruno Henrique','Bruno','1234',1
exec SP_CADASUSU 'Paulo Vinicius','ADMIN','ADMIN',0
exec SP_CADASUSU 'Rose Bergamo','Rose','12345',0
   
/*FUNCIONÁRIOS*/
select * from TB_FUNCIONARIOS
EXEC SP_CADASFUNC 'João Carlos da Silva','Rua das Flores, 578','446.308.440-74','57.306.075-2','(14)99744-4883','1985-09-15','joaocarlos12@hotmail.com','Masculino',0,'C:\Sistema Bio Ritmo\Fotos Utilizadas\joao.jpeg',2
EXEC SP_CADASFUNC 'Pedro Paulo Gabriel Cruz','Rua Aurélio Gobbo, 12','043.724.950-64','25.545.235-2','(14)99695-1235','1998-10-20','ppgabrielruz@hotmail.com','Masculino',1,'C:\Sistema Bio Ritmo\Fotos Utilizadas\pedro.jpeg',1
EXEC SP_CADASFUNC 'Gabriela Oliveira Gobbo','Rua João Carniato, 108','756.388.360-63','57.306.078-2','(14)99744-4883','1996-02-13','gabrielagobbo@hotmail.com','Feminino',0,'C:\Sistema Bio Ritmo\Fotos Utilizadas\gabriela.jpeg',3
EXEC SP_CADASFUNC 'Rodolfo Reis','Rua João Pessoa, 125','818.739.080-83','65.656.998-5','(15)99856-3020','1988-10-27','rodolfo2012@hotmail.com','Masculino',0,'C:\Sistema Bio Ritmo\Fotos Utilizadas\rodolfo.jpeg',4
EXEC SP_CADASFUNC 'Bruno Henrique','Rua Marechal Floriano Peixoto, 58','924.947.030-42','63.569.989-2','(14)99956-5689','1995-09-11','brunohenrique@hotmail.com','Masculino',0,'C:\Sistema Bio Ritmo\Fotos Utilizadas\bruno.jpeg',5

/*CLIENTES*/
select * from TB_CLIENTES

EXEC SP_CADASCLI 'João Pedro Garbeloto','Rua Rio Branco, 458','591.282.250-82','56.869.987-2','(15)99652-2532','2016-11-18','1998-12-12','jpgarbeloto@live.com',0,'Masculino','C:\Sistema Bio Ritmo\Fotos Utilizadas\jpedro.jpeg','Perca de Peso',1
EXEC SP_CADASCLI 'Eduardo Ferreira Romano','Rua Santa Rita, 53','911.037.620-87','59.224.442-4','(15)99654-1122','2016-06-07','1998-12-19','eduardocoimbra@gmail.com',0,'Masculino','C:\Sistema Bio Ritmo\Fotos Utilizadas\eduardo1.jpeg','Ganho de Massa',1
EXEC SP_CADASCLI 'Matheus Francisco Mazetto','Rua Almeida Prado, 648','837.111.050-25','57.336.745-2','(14)99745-3256','2016-10-05','1990-05-24','matheus1990@hotmail.com',0,'Masculino','C:\Sistema Bio Ritmo\Fotos Utilizadas\matheus.jpeg','Perca de Peso',2
EXEC SP_CADASCLI 'Amanda Carolina Gabriel','Rua Francisco Dimas, 32','178.630.440-65','27.215.437-3','(14)99758-4502','2015-11-04','1987-11-12','amandacarolina@hotmail.com',0,'Feminino','C:\Sistema Bio Ritmo\Fotos Utilizadas\amanda.jpeg','Ganho de Massa',1
EXEC SP_CADASCLI 'Joana Camargo Meneguel','Rua Morumbi, 667','523.161.535-85','26.665.497-9','(14)99657-9896','2016-07-01','2016-01-23','joanacamargo@hotmail.com',0,'Feminino','C:\Sistema Bio Ritmo\Fotos Utilizadas\joana.jpeg','Ganho de Massa',1

EXEC SP_CADASCLI 'Miguel Araujo Souza Prado','Rua José Trombi, 880','032.149.098-35','15.419.127-9','(14)99566-9898', '2016-07-07','1995-12-07','miguelaraujo@hotmail.com',0,'Masculino','C:\Sistema Bio Ritmo\Fotos Utilizadas\MIGUEL.jpg','Ganho de Massa',1
EXEC SP_CADASCLI 'Maria Aparecida Meneguel','Rua Padre João, 120','273.311.738-63','50.920.212-3','(14)99652-3370','2016-05-06','1996-11-08','mariaaparecida@hotmail.com',0,'Feminino','C:\Sistema Bio Ritmo\Fotos Utilizadas\MARIAAP.jpg','Perca de Peso',1
EXEC SP_CADASCLI 'Vinicius Mattos Santos','Rua Santo André, 189','983.482.598-64','45.581.018-7','(14)99596-9865','2016-09-01','1991-10-22','viniciusmattos@hotmail.com',1,'Masculino','C:\Sistema Bio Ritmo\Fotos Utilizadas\VINICIUS.jpg','Perca de Peso',2
EXEC SP_CADASCLI 'Vitor Bueno Ribeiro','Rua Floriano Peixoto, 1145','902.678.668-95','27.331.844-5','(14)99865-3236','2016-02-04','1995-12-22','vitorbeuno@hotmail.com',0,'Masculino','C:\Sistema Bio Ritmo\Fotos Utilizadas\VITOR.jpg','Ganho de Massa',1
EXEC SP_CADASCLI 'Eloise Santos Aparecida','Rua Aurélio Gobbo, 1355','768.278.488-17','38.331.724-1','(14)99699-3258','2016-07-01','1992-08-27','eloaparecida@hotmail.com',0,'Feminino','C:\Sistema Bio Ritmo\Fotos Utilizadas\ELOISE.jpg','Ganho de Massa',1
/*Medidas*/
select * from TB_MEDIDAS

EXEC SP_CADASMEDIDAS '2016-11-18','80.0','1.70','39.6','42.1','109.9','99.0','69.0','59.4','105.0','39.0',1
EXEC SP_CADASMEDIDAS '2016-06-07','104.0','1.80','36.0','36.0','109.7','98.8','68.0','59.2','120.0','40.0',2

EXEC SP_CADASMEDIDAS '2016-10-05','77.0','1.77','33.0','34.0','87.0','95.0','90.0','56.0','52.0','35.0',3
EXEC SP_CADASMEDIDAS '2016-11-05','76.0','1.77','35.0','36.0','90.0','95.0','91.0','57.0','52.0','39.0',3
EXEC SP_CADASMEDIDAS '2016-12-05','75.0','1.78','35.0','37.0','91.0','97.0','93.0','57.0','53.0','41.0',3

EXEC SP_CADASMEDIDAS '2015-11-04','56.0','1.68','25.0','24.0','78.0','78.0','78.0','69.0','49.0','40.0',4
EXEC SP_CADASMEDIDAS '2016-03-04','55.0','1.69','27.0','26.0','81.0','79.0','86.0','72.0','50.0','42.0',4

EXEC SP_CADASMEDIDAS '2016-01-23','71.0','1.70','27.0','19.0','81.0','82.0','89.0','76.0','48.0','36.0',5
EXEC SP_CADASMEDIDAS '2016-07-07','81.0','1.80','38.6','42.1','109.9','98.0','78.0','59.4','105.0','35.0',6
EXEC SP_CADASMEDIDAS '2016-05-06','84.0','1.65','34.0','36.0','119.7','93.8','90.0','53.2','110.0','46.0',7

EXEC SP_CADASMEDIDAS '2016-09-01','88.0','1.71','33.0','32.0','100.0','100.0','110.0','56.0','56.0','38.0',8
EXEC SP_CADASMEDIDAS '2016-10-01','87.0','1.71','35.0','33.0','101.0','98.0','112.0','58.0','56.0','40.0',8
EXEC SP_CADASMEDIDAS '2016-11-01','85.0','1.72','36.0','34.0','103.0','99.0','117.0','60.0','57.0','40.0',8
EXEC SP_CADASMEDIDAS '2016-12-01','84.0','1.72','38.0','36.0','105.0','96.0','118.0','63.0','58.0','41.0',8

EXEC SP_CADASMEDIDAS '2016-02-04','58.0','1.88','25.0','19.0','88.0','75.0','98.0','67.0','49.0','42.0',9
EXEC SP_CADASMEDIDAS '2016-07-01','73.0','1.60','29.0','18.0','81.0','82.0','90.0','77.0','48.0','34.0',10

/*DESPESAS*/
select * from TB_DESPESAS

exec SP_CADASDPS 'Água ','2016-12-10','20.00','João Carlos da Silva',1
exec SP_CADASDPS 'Energia ','2016-12-01','60.00','Pedro Paulo Gabriel Cruz',2
exec SP_CADASDPS 'Manutenção ','2016-12-03','25.00','Gabriela Oliveira Gobbo',3
exec SP_CADASDPS 'Funcionários ','2016-11-29','1200.00','Gabriela Oliveira Gobbo',4
exec SP_CADASDPS 'Propaganda ','2016-12-01','40.00','Bruno Henrique',5

/*MENSALIDADES*/

select * from TB_MENSALIDADES

exec SP_CADASMENSA '2016-11-18','2016-12-18','60.00',1
exec SP_CADASMENSA '2016-11-07','2016-12-07','60.00',2
exec SP_CADASMENSA '2016-12-05','2017-01-05','60.00',3
exec SP_CADASMENSA '2016-12-04','2017-01-04','60.00',4
exec SP_CADASMENSA '2016-11-23','2016-12-23','60.00',5
exec SP_CADASMENSA '2016-11-07','2016-12-07','60.00',6
exec SP_CADASMENSA '2016-12-06','2017-01-06','60.00',7
exec SP_CADASMENSA '2016-12-01','2017-01-01','60.00',8
exec SP_CADASMENSA '2016-12-04','2017-01-04','60.00',9
exec SP_CADASMENSA '2016-12-01','2017-01-01','60.00',10





-------------------------------------------------------------------------------------------------------------
----------------------------------------------Fim----------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------










































































































/*

EXEC SP_CADASFUNC 'Josias','Rua das Flores','463.609.078-02','57.306.078-2','(14)99744-4883','2016-09-15','josiasjose@hotmail.com','Feminino',0,'C:\Sistema Bio Ritmo\Fotos Utilizadas\Desert.jpeg',1
EXEC SP_CADASUSU 'ADMINISTRADOR','ADMIN','ADMIN',0
EXEC SP_CADASUSU 'USUÁRIO COMUM','COMUM','1234',1
EXEC SP_CADASUSU 'BRUNO','1','1234',0
EXEC SP_CADASCLI 'Pedro','Rua do Bosque','472.659.068-02','58.215.497-2','(15)99856-2302','1998-02-12','2016-02-03','PedroCampos@live.com',1,'Masculino','C:\Sistema Bio Ritmo\Fotos Utilizadas\Penguins.jpeg','Perca de Peso',1
EXEC SP_CADASMEDIDAS '2016-10-10',5,5,5,5,5,5,5,5,5,5,1
EXEC SP_CADASMEDIDAS '2016-10-10',5,5,5,5,5,5,5,5,5,5,2
EXEC SP_CADASMEDIDAS '2016-10-10',5,5,5,5,5,5,5,5,5,5,3
EXEC SP_CADASMEDIDAS '2016-10-10',5,5,5,5,5,5,5,5,5,5,4
EXEC SP_CADASCLI 'Rodrigo','Rua da Florzinha','451.578.120-01','57.305.847-1','(14)99744-4883','2016-09-21','1999-07-19','RodrigoRORO@live.com',0,'Feminino','C:\Sistema Bio Ritmo\Fotos Utilizadas\Koala.jpeg','Ganho de Massa',2
EXEC SP_CADASMEDIDAS
execute SP_CADASDCCLI '1','Pressão Alta'
EXEC SP_ALTERCLI 1,'Pedro','Rua do Bosque','472.659.068-02','58.215.497-2','(15)99856-2302','1998-02-12','2016-02-03','PedroCampos@live.com',0,'Feminino','C:\Sistema Bio Ritmo\Fotos Utilizadas\Koala.jpeg','Ganho de Massa',1
---------------
SELECT*FROM TB_CLIENTES

SELECT*FROM TB_FUNCIONARIOS

SELECT*FROM TB_MEDIDAS

SELECT*FROM TB_MENSALIDADES

SELECT*FROM TB_USUARIOS 

SELECT*FROM TB_DESPESAS

SELECT*FROM TB_CLIENTES_DOENCAS

select COUNT(*)
from TB_CLIENTES_DOENCAS 
where COD_CLI=1 and DSC_DC like 'Pressão Alta'

DROP TABLE TB_CLIENTES

DROP TABLE TB_FUNCIONARIOS

DROP TABLE TB_MEDIDAS

DROP TABLE TB_MENSALIDADES

DROP TABLE TB_USUARIOS

DROP TABLE TB_DESPESAS

DROP TABLE TB_CLIENTES_DOENCAS

DROP PROCEDURE sp_cadasusu

DROP DATABASE TCC

DROP PROCEDURE SP_ALTERUSU

ALTER AUTHORIZATION ON DATABASE::TCC TO SA     

select  *
from    tb_usuarios
where   tp_usu = 0

SELECT*FROM TB_CLIENTES,TB_MENSALIDADES WHERE TB_MENSALIDADES.COD_CLI = TB_CLIENTES.COD_CLI




select DATEADD(MONTH,1,DTMATRI_CLI) FROM TB_CLIENTES WHERE COD_CLI = 1

select DATEPART(MONTH,DTMATRI_CLI) from TB_CLIENTES WHERE COD_CLI = 1


SELECT*FROM TB_CLIENTES WHERE MONTH(DTNASC_CLI) = MONTH(GETDATE()) AND DAY(DTNASC_CLI) = DAY(GETDATE())

SELECT * FROM TB_CLIENTES  WHERE EXTRACT(DAY FROM DTNASC_CLI) = '+FormatDateTime('d', Date)+ ' AND EXTRACT(MONTH from DTNASC_CLI) = '+FormatDateTime('m', Date)'

select NM_CLI,DTNASC_CLI,Extract(day  DTNASC_CLI) FROM TB_CLIENTES Where Extract( Month From DTNASC_CLI) = DATEPART(MONTH,GETDATE())  


select count (*)[QTD]
from TB_CLIENTES 
 
 
select count (*)[QTDA]
from TB_CLIENTES
where STA_CLI = 0 

select count (*)[QTDI]
from TB_CLIENTES
where STA_CLI = 1

select SUM(VL_DPS) [totald]
from TB_DESPESAS
where  MONTH( DT_DPS) = MONTH(GETDATE())

select SUM(VL_MSD) [total]
from TB_MENSALIDADES 
where  MONTH( DTPAG_MSD) = MONTH(GETDATE())


/*bruno */



SELECT*FROM TB_MENSALIDADES WHERE MONTH(DTPAG_MSD) = MONTH(GETDATE())

SELECT*FROM TB_CLIENTES,TB_MEDIDAS WHERE TB_CLIENTES.COD_CLI=TB_MEDIDAS.COD_CLI



------------------------------------------------------

backup database ReportServer to disk = 'C:\pastapendrive\oi.bak'


restore database ReportServer from disk = 'C:\pastapendrive\oi.bak' 

SELECT*FROM TB_CLIENTES WHERE MONTH(DTNASC_CLI) = MONTH(GETDATE())  ORDER BY DAY(DTNASC_CLI) ASC
