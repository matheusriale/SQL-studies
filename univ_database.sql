CREATE TABLE Unidade_Academica(
  cod_UA VARCHAR(12) NOT NULL, -- código da Unid Acad [PK]
  nome_UA VARCHAR(100) NOT NULL, -- nome da Unid Acad
  endereco_UA VARCHAR(255) NOT NULL, -- Endereço da Unid Acad
  tel_UA VARCHAR(9) NOT NULL, -- Telefone da Unid Acad
  
  PRIMARY KEY (cod_UA)
);

CREATE TABLE Disciplina(
  cod_disc VARCHAR(12) NOT NULL, -- código da disciplina [PK]
  nome_disc VARCHAR(100) NOT NULL, -- nome da disciplina
  creditos int NOT NULL, -- creditos da disciplina

  PRIMARY KEY (cod_disc)
);

CREATE TABLE Departamento(
  cod_dpto VARCHAR(12) NOT NULL, -- código do departamento [PK]
  nome_dpto VARCHAR(100) NOT NULL,  -- nome do departamento
  endereco_dpto VARCHAR(255) NOT NULL, -- Endereço do departamento
  tel_dpto VARCHAR(9) NOT NULL, -- Telefone do departamento
  
  cod_UA VARCHAR(12) NOT NULL, --codigo da unidade academica (FK)

  PRIMARY KEY (cod_dpto),

  CONSTRAINT fk_UA
  FOREIGN KEY (cod_UA)
  REFERENCES Unidade_Academica
);

CREATE TABLE Curso(
  cod_curso VARCHAR(12) NOT NULL, -- codigo do curso [PK]
	nome_curso VARCHAR(100) NOT NULL, -- nome do Curso
	tel_curso VARCHAR(9) NOT NULL, -- telefone do Curso
	
  PRIMARY KEY (cod_curso)
);


CREATE TABLE Professor(
  matr_prof VARCHAR(7) NOT NULL, --matricula do professor [PK]
  nome_prof VARCHAR(100) NOT NULL, -- nome do professor
  endereco_prof VARCHAR(255) NOT NULL, -- endereco do professor
  rg_prof  VARCHAR(12) NOT NULL, -- RG do professor
  cpf_prof VARCHAR(12) NOT NULL, -- CPF do professor
  salario float NOT NULL, -- salário do professor
  
  chefe_cod_UA VARCHAR(12), -- se for chefe de alguma unidade academica, irá receber seu codigo
  diretor_cod_dep VARCHAR(12), -- recebe o código de um departamento se for diretor
  coordenador_cod_curso VARCHAR(12), --recebe o codigo de um curso se for coordenador
  lotacao VARCHAR(12) NOT NULL, --departamento no qual o professor está lotado

  PRIMARY KEY (matr_prof),
  UNIQUE(cpf_prof, rg_prof),

  FOREIGN KEY (lotacao)
  REFERENCES Departamento,

  FOREIGN KEY (diretor_cod_dep)
  REFERENCES Departamento,
  
  FOREIGN KEY (chefe_cod_UA)
  REFERENCES Unidade_Academica,

  FOREIGN KEY (coordenador_cod_curso)
  REFERENCES Curso
);

CREATE TABLE Aluno(
  matr_aluno VARCHAR(7) NOT NULL, --matricula do aluno [PK]
  nome_aluno VARCHAR(100) NOT NULL, -- nome do aluno
  endereco_aluno VARCHAR(255) NOT NULL, -- endereco do aluno
  rg_aluno  VARCHAR(12) NOT NULL, -- RG do aluno
  cpf_aluno VARCHAR(12) NOT NULL, -- CPF do aluno
  cod_curso VARCHAR(12) NOT NULL,

  PRIMARY KEY (matr_aluno),
  UNIQUE(cpf_aluno, rg_aluno),

  FOREIGN KEY (cod_curso)
  REFERENCES Curso
);

CREATE TABLE TelefonesUA(
  num_fone VARCHAR(12) NOT NULL,
  tipo_fone VARCHAR(9) NOT NULL,
  cod_UA VARCHAR(12) NOT NULL,

  PRIMARY KEY(num_fone),
  UNIQUE(num_fone),

  FOREIGN KEY(cod_UA)
  REFERENCES Unidade_Academica
);

-- ENTIDADES

CREATE TABLE Dep_Curso( -- Curso é OFERTADO por um departamento
  cod_curso VARCHAR(12) NOT NULL, -- curso que é ofertado
  cod_dpto VARCHAR(12) NOT NULL, --departamento que oferta
  
  FOREIGN KEY (cod_curso)
  REFERENCES Curso, 
  FOREIGN KEY (cod_dpto)
  REFERENCES Departamento
);

CREATE TABLE Cur_Disc( -- uma disciplina é OFERTADA por um curso
  cod_disc VARCHAR(12) NOT NULL, --disciplina que é ofertada
  cod_curso VARCHAR(12) NOT NULL, --curso que oferta
  
  FOREIGN KEY (cod_curso)
  REFERENCES Curso,
  FOREIGN KEY (cod_disc)
  REFERENCES Disciplina
);

CREATE TABLE Pre_Requisito( -- uma disciplina pode ter outra disciplina como pre-requisito
  cod_disc VARCHAR(12) NOT NULL, --disciplina que possui o pre-requisito
  cod_preRequisito VARCHAR(12) NOT NULL, --disciplina que é o pre-requisito
  
  CONSTRAINT fk_disc
  FOREIGN KEY (cod_disc)
  REFERENCES Disciplina,
  
  CONSTRAINT fk_prerequi
  FOREIGN KEY (cod_preRequisito)
  REFERENCES Disciplina
  ON UPDATE CASCADE
);

CREATE TABLE Aluno_Disc( -- um aluno cursa uma disciplina
  matr_aluno VARCHAR(7) NOT NULL, --aluno que cursa   
  cod_disc VARCHAR(12) NOT NULL, --disciplina que é cursada
  semestre VARCHAR(7) NOT NULL,
  AP1 float NOT NULL,
  AP2 float NOT NULL,
  AF  float DEFAULT NULL,

  FOREIGN KEY (matr_aluno)
  REFERENCES Aluno,
  
  FOREIGN KEY (cod_disc)
  REFERENCES Disciplina
);

CREATE TABLE Prof_Disc( -- uma disciplina que é ministrada por um professor 
  cod_disc VARCHAR(12) NOT NULL,
  matr_prof VARCHAR(7) NOT NULL, -- prof que ministra
  semestre VARCHAR(7) NOT NULL,
  
  FOREIGN KEY (matr_prof)
  REFERENCES Professor,
  
  FOREIGN KEY(cod_disc)
  REFERENCES Disciplina
);
