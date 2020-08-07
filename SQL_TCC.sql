create database TCC 
USE TCC

--------------------------------------------Tabela e procedures dos funcionarios ------------------------------------------------------------------------------------------------------------
create table TB_FUNCIONARIOS (
codigo_func int identity primary key,
nome_func varchar(50) not null,
endereco_func varchar(60) not null,
cpf_func varchar(12) not null,
rg_func varchar(10) not null,
telefone_func varchar(15) not null,
datapagamento_func date not null,
email_func varchar(60) not null,
sexo_func bit not null,
status_func bit not null,
fotofunc varchar(255) null)

insert into TB_FUNCIONARIOS (nome_func,
endereco_func,
cpf_func,
rg_func,
telefone_func,
datapagamento_func,
email_func,
sexo_func,
status_func,
fotofunc)
values ('Josias','ruazinha','12345678','12345654','14123456789','2018-02-02','kekeke@live.com',0,0,'')



------Procedure Cadastrar Funcionario ------------------------------------------------------------------------------------------------------------------------------------------------------------
create procedure sp_cadastrafunc    @nome_func varchar(50),
									@endereco_func varchar(60),
									@cpf_func varchar (12),
									@rg_func varchar (10) ,
									@telefone_func varchar(15),
									@datapagamento_func date ,									@email_func varchar(60),
							    
									@sexo_func bit,
									@status bit,
									@fotofunc varchar(255)
as 
begin 
 insert into  TB_FUNCIONARIOS (nome_func,endereco_func,cpf_func,rg_func,telefone_func,datapagamento_func,email_func,sexo_func,status_func,fotofunc)
 values					  (@nome_func,@endereco_func,@cpf_func,@rg_func,@telefone_func,@datapagamento_func,@email_func,@sexo_func,@status,@fotofunc)


end 

exec sp_cadastrafunc 'Josias','ruazinha','12345678','12345654','14123456789','20180202','kekeke@live.com',0,0,''

------Procedure Atualizar Funcionario -------------------------------------------------------------------------------------------------------------------------------------------

create procedure sp_atualizafunc    @codigo_func int,
                                    @nome_func varchar(50),
									@endereco_func varchar(60) ,
									@cpf_func varchar (12),
									@rg_func varchar (10) ,
									@telefone_func varchar(15),
									@datapagamento_func date ,
									@email_func varchar(60),
									
									@sexo_func bit,
									@status_func bit,
									@fotofunc varchar(255)
as
begin 
	update TB_FUNCIONARIOS set nome_func=@nome_func,
								    endereco_func=@endereco_func,
						            cpf_func=@cpf_func,
						            rg_func=@rg_func,
						            telefone_func=@telefone_func,
						            datapagamento_func=@datapagamento_func,
						            email_func=@email_func,
						           
					           	    sexo_func=@sexo_func,
					           	    status_func=@status_func,
						            fotofunc=@fotofunc
	where 
						            codigo_func=@codigo_func


end	

----------------------------------------------Fim da Tabela e procedures Funcionarios -------------------------------------------------------------------------------------------
--------------------------------------------Tabela e Procedures Cadastro Usuario------------------------------------------------

create table TB_USUARIOS (
codigo_usuario int identity primary key,
nome_usuario varchar(50) not null,
login_usuario varchar(20) not null,
senha_usuario varchar(12) not null,
cod_func int foreign key references TB_FUNCIONARIOS (codigo_func) not null,
tipo_usuario bit not null)

INSERT INTO TB_USUARIOS
(
nome_usuario,
login_usuario,
senha_usuario,
cod_func,
tipo_usuario
) VALUES
('ADMIN',
'ADMIN',
'ADMIN',
1,
0)
--------------------------------------------Fim Tabela e Nenhum Procedure Usuario---------------------------------------
--------------------------------------------------Tabela e Procedures Clientes -------------------------------------------------------------------------------------------------------
 create table TB_CLIENTES (
 codigo_cliente int identity primary key,
 nome_cliente varchar(60)not null,
 datanasci_cliente date not null,
 CPF_cliente varchar(12) not null,
 RG_cliente varchar(10) not null,
 endereco_cliente varchar(70) not null,
 telefone_cliente varchar(15) not null,
 datamatricula_cliente date not null,
 email_cliente varchar(100) not null,

 sexo_cliente bit not null,
 status_cliente bit not null,
 foto_cliente varchar (255) null,
 codigo_usuario int foreign key references TB_USUARIOS(codigo_usuario))



create table TB_CLIENTES_DOENCAS (
  codigo int identity primary key,
  cliente int foreign key references tb_clientes (codigo_cliente),
  descricao varchar(200) not null
    
)

 ------Procedure Cadastrar Cliente------------------------------------------------------------------------------------------------------------------------------
 create procedure sp_cadastracliente
										@nome_cliente varchar(60),
										@datanasci_cliente date ,
										@CPF_cliente varchar(12),
										@RG_cliente varchar(10),
										@endereco_cliente varchar(70),
										@telefone_cliente varchar(15),
										@datamatricula_cliente date,
										@email_cliente varchar(100),
									
										@sexo_cliente bit ,
										@status_cliente bit ,
										@foto_cliente varchar (255) 
as 
begin

		insert into TB_CLIENTES (nome_cliente,datanasci_cliente,CPF_cliente,RG_cliente,endereco_cliente,
		telefone_cliente,datamatricula_cliente,email_cliente,sexo_cliente,status_cliente,foto_cliente)
		
		
		values (@nome_cliente,@datanasci_cliente,@CPF_cliente,@RG_cliente,@endereco_cliente,
		@telefone_cliente,@datamatricula_cliente,@email_cliente,@sexo_cliente,@status_cliente,@foto_cliente)
		
end	

exec sp_cadastracliente 'Pedro','1998-02-12','444444444','444444444','ruaaa','998562302','2016-02-03','aaaaaaaaaaaaaaaaa',
'1','1','c:'


select * from TB_CLIENTES


create procedure sp_grava_clientes_doencas
@cliente int ,
@descricao varchar (20)
as
begin
   insert into TB_CLIENTES_DOENCAS (cliente,descricao) 
   values (@cliente,@descricao)
end

   execute sp_grava_clientes_doencas '1','Pressão Alta'
											
	
	select * from TB_CLIENTES_DOENCAS	


select COUNT(*)
from TB_CLIENTES_DOENCAS 
where cliente=1 and descricao like 'Pressão Alta'

	
																		
 ------Procedure Altera Cliente------------------------------------------------------------------------------------------------------------------------------------
 create procedure sp_atualizacliente    @codigo_cliente int,
                                      	@nome_cliente varchar(60),
										@datanasci_cliente date ,
										@CPF_cliente varchar(12),
										@RG_cliente varchar(10),
										@endereco_cliente varchar(70),
										@telefone_cliente varchar(15),
										@datamatricula_cliente date ,
										@email_cliente varchar(100) ,
										
										@sexo_cliente bit ,
										@status_cliente bit ,
										@foto_cliente varchar (255)
as
begin 

		update TB_CLIENTES set	            nome_cliente=@nome_cliente,
							            datanasci_cliente=@datanasci_cliente,
							            CPF_cliente=@CPF_cliente,
						            	RG_cliente=@RG_cliente,
							            endereco_cliente=@endereco_cliente,
							            telefone_cliente=@telefone_cliente,
							            datamatricula_cliente=@datamatricula_cliente,
							            email_cliente=@email_cliente,
							          
							            sexo_cliente=@sexo_cliente,
							            status_cliente=@status_cliente,
							            foto_cliente=@foto_cliente
							
		where 
		                                codigo_cliente=@codigo_cliente
		
end
---------------------------------------------Fim da Tabela e Procedures Cliente ------------------------------------------------------------------------------------------------------
--------------------------------------------------Tabela e Procedures Medidas-------------------------------------------
create table TB_MEDIDAS (
codigo_medidas int identity primary key,
codigo_cliente int foreign key references TB_CLIENTES(codigo_cliente),
datavaliacaofisica date  null,
peso decimal (9,2)  null,
altura decimal (9,2) null,
biceps decimal (9,2) null,
triceps decimal (9,2) null,
peitoral decimal (9,2) null,
quadril decimal (9,2) null,
cintura decimal (9,2) null,
coxa decimal (9,2) null,
ombro decimal (9,2) null,
panturrilha decimal (9,2) null)

------Procedure Cadastra Medidas------------------------------------------------------------------------------------

create procedure sp_cadastra_medidas   @codigo_cliente int ,
								       @datavaliacaofisica date ,
									   @peso decimal (9,2) ,
									   @altura decimal (9,2) ,
								       @biceps decimal (9,2),
									   @triceps decimal (9,2),
									   @peitoral decimal (9,2),
									   @quadril decimal (9,2),
									   @cintura decimal (9,2),
									   @coxa decimal (9,2),
									   @ombro decimal (9,2),
									   @panturrilha decimal (9,2)
as
begin
		
		insert into TB_MEDIDAS (codigo_cliente,datavaliacaofisica,peso,
		altura,biceps,triceps,peitoral,quadril,cintura,coxa,ombro,panturrilha)
		
		values (@codigo_cliente,@datavaliacaofisica,@peso,
		@altura,@biceps,@triceps,@peitoral,@quadril,@cintura,@coxa,@ombro,@panturrilha)

end	

------Procedure Atualizacao-------------------------------------------------------------------------------------------

create procedure sp_atualiza_medidas   @codigo int,
                                       @datavaliacaofisica date ,
									   @peso decimal (9,2) ,
									   @altura decimal (9,2) ,
								       @biceps decimal (9,2),
									   @triceps decimal (9,2),
									   @peitoral decimal (9,2),
									   @quadril decimal (9,2),
									   @cintura decimal (9,2),
									   @coxa decimal (9,2),
									   @ombro decimal (9,2),
									   @panturrilha decimal (9,2)
									   
as
begin

	update TB_MEDIDAS set				   datavaliacaofisica=@datavaliacaofisica,
									   peso=@peso,
									   altura=@altura,
									   biceps=@biceps,
									   triceps=@triceps,
									   peitoral=@peitoral,
									   quadril=@quadril,
									   cintura=@cintura,
									   coxa=@coxa,
									   ombro=@ombro,
									   panturrilha=@panturrilha
	where                           
	                                   codigo_cliente=@codigo								   


end
----------------------------------------------Fim Tabela e Procedures Medidas---------------------------------------------- 
----------------------------------------------Tabela e Procedures Pagamento----------------------------------
create table TB_MENSALIDADES (
codigo_pagamento int identity primary key,
codigo_cliente int foreign key references TB_CLIENTES(codigo_cliente),
datapagamento date not null,
datavencimento date not null,
tipopagamento varchar (50) not null,
valor money not null,
codigo_usuario int foreign key references TB_USUARIOS(codigo_usuario))
---------------------------------------------Procedure Cadastrar Pagamento-----------------------------------------------
create procedure sp_cadas_pagamento @cod int,
                                    @data date,
                                    @datavenc date,
                                    @tipo varchar(50),
                                    @valor money,
                                    @codusu int
as
begin
	insert into TB_MENSALIDADES (codigo_cliente,datapagamento,datavencimento,tipopagamento,valor,codigo_usuario) values (@cod,@data,@datavenc,@tipo,@valor,@codusu)
end                                    

------Procedure Atualiza Pagamento-------------------------------------------------------------------------------------
create procedure sp_atuali_pagamento @cod int,
									 @codcli int,
                                     @data date,
                                     @datavenc date,
                                     @tipo varchar(50),
                                     @valor money,
                                     @codusu int
as
begin
	update TB_MENSALIDADES set codigo_cliente = @codcli, datapagamento = @data, datavencimento = @datavenc, tipopagamento = @tipo, valor = @valor, codigo_usuario=@codusu where codigo_pagamento = @cod
end
-----------------------------------------------Fim da Tabela e Procedures Pagamento------------------------------------------------------------------
------------------------------------------------Tabela e Procedure Despesas-----------------------------------------------------------------------------------------------------------------------------------------
create table TB_DESPESAS (
cod_despesa int identity primary key,
desc_despesa varchar(100) not null,
data_despesa date not null,
valor_despesa money not null,
codigo_usuario int foreign key references TB_USUARIOS (codigo_usuario))
------Procedure Cadastra Despesas-------------------------------------------------------------------------------------
create procedure sp_cadastradespesa       @desc varchar(100),
                                          @data date,
                                          @valor money
as
begin
	insert into TB_DESPESAS (desc_despesa,data_despesa,valor_despesa)
	values (@desc,@data,@valor)
end                            
------Procedure Atualiza Despesas-------------------------------------------------------------------------------------
create procedure sp_atu_despesa		      @cod_despesa int,
									      @desc varchar(100),
                                          @data date,
                                          @valor money,
                                          @codigo_usuario int
as
begin
	update TB_DESPESAS set desc_despesa = @desc, data_despesa = @data, valor_despesa = @valor, codigo_usuario=@codigo_usuario where cod_despesa = @cod_despesa
end

-----Procedure Exlui Despesas-----------------------------------------------------------------------------------------
create procedure sp_excluidespesas @codigo int 
as
begin

	delete from TB_DESPESAS
	
	where cod_despesa=@codigo
end 

---------------------------------------------Fim da Tabela e Procedure Despesas---------------------------------------- 
----------------------------------------------------------------------------------------------------------------------         
SELECT*FROM TB_CLIENTES
SELECT*FROM TB_FUNCIONARIOS
SELECT*FROM TB_MEDIDAS
SELECT*FROM TB_MENSALIDADES
SELECT*FROM TB_USUARIOS 
SELECT*FROM TB_DESPESAS

DROP TABLE TB_CLIENTES
DROP TABLE TB_FUNCIONARIOS
DROP TABLE TB_MEDIDAS
DROP TABLE TB_MENSALIDADES
DROP TABLE TB_USUARIOS
DROP TABLE TB_DESPESAS

DROP DATABASE TCC
--------------------------------
alter authorization on database::TCC to sa             		