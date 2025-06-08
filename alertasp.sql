/**
alertaSP

LUIS HENRIQUE OLIVEIRA - RM552692
SABRINA MOTA CAFÉ - 
MATHEUS DUARTE - 
**/

-- DROP TABLES (em ordem reversa de dependência)
DROP TABLE feedback_denuncia CASCADE CONSTRAINTS;
DROP TABLE historico_alerta_usuario CASCADE CONSTRAINTS;
DROP TABLE local_salvo CASCADE CONSTRAINTS;
DROP TABLE denuncia CASCADE CONSTRAINTS;
DROP TABLE alerta CASCADE CONSTRAINTS;
DROP TABLE medicao CASCADE CONSTRAINTS;
DROP TABLE sensor CASCADE CONSTRAINTS;
DROP TABLE tipo_sensor CASCADE CONSTRAINTS;
DROP TABLE endereco_usuario CASCADE CONSTRAINTS;
DROP TABLE cidade CASCADE CONSTRAINTS;
DROP TABLE estado CASCADE CONSTRAINTS;
DROP TABLE status_validacao CASCADE CONSTRAINTS;
DROP TABLE usuario CASCADE CONSTRAINTS;

-- Tabela de estados
CREATE TABLE estado (
    id INT PRIMARY KEY,
    nome VARCHAR2(50),
    uf CHAR(2)
);

-- Tabela de cidades
CREATE TABLE cidade (
    id INT PRIMARY KEY,
    nome VARCHAR2(100),
    estado_id INT,
    FOREIGN KEY (estado_id) REFERENCES estado(id)
);

-- Tabela de usuários
CREATE TABLE usuario (
    id INT PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    senha VARCHAR2(100) NOT NULL,
    telefone VARCHAR2(20)
);

-- Tabela de status das denúncias
CREATE TABLE status_validacao (
    id INT PRIMARY KEY,
    descricao VARCHAR2(50)
);

-- Endereço do usuário
CREATE TABLE endereco_usuario (
    id INT PRIMARY KEY,
    usuario_id INT,
    apelido VARCHAR2(50),
    cep VARCHAR2(10),
    logradouro VARCHAR2(100),
    numero VARCHAR2(10),
    bairro VARCHAR2(50),
    cidade_id INT,
    latitude NUMBER(10,6),
    longitude NUMBER(10,6),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (cidade_id) REFERENCES cidade(id)
);

-- Tipo de sensor
CREATE TABLE tipo_sensor (
    id INT PRIMARY KEY,
    nome VARCHAR2(50)
);

-- Sensor
CREATE TABLE sensor (
    id INT PRIMARY KEY,
    nome VARCHAR2(100),
    localizacao VARCHAR2(100),
    latitude NUMBER(10,6),
    longitude NUMBER(10,6),
    tipo_sensor_id INT,
    nivel_maximo_seguro NUMBER(5,2),
    FOREIGN KEY (tipo_sensor_id) REFERENCES tipo_sensor(id)
);

-- Medição do sensor
CREATE TABLE medicao (
    id INT PRIMARY KEY,
    sensor_id INT,
    data_hora TIMESTAMP,
    nivel_agua NUMBER(5,2),
    alerta VARCHAR2(20),
    FOREIGN KEY (sensor_id) REFERENCES sensor(id)
);

-- Alerta gerado automaticamente
CREATE TABLE alerta (
    id INT PRIMARY KEY,
    sensor_id INT,
    mensagem CLOB,
    nivel_agua NUMBER(5,2),
    nivel_alerta VARCHAR2(20),
    data_alerta DATE,
    horario_alerta VARCHAR2(10),
    FOREIGN KEY (sensor_id) REFERENCES sensor(id)
);

-- Denúncia feita pelo usuário
CREATE TABLE denuncia (
    id INT PRIMARY KEY,
    usuario_id INT,
    local VARCHAR2(100),
    latitude NUMBER(10,6),
    longitude NUMBER(10,6),
    imagem_url VARCHAR2(255),
    descricao CLOB,
    data_hora TIMESTAMP,
    status_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (status_id) REFERENCES status_validacao(id)
);

-- Locais favoritos do usuário
CREATE TABLE local_salvo (
    id INT PRIMARY KEY,
    usuario_id INT,
    nome_local VARCHAR2(100),
    latitude NUMBER(10,6),
    longitude NUMBER(10,6),
    receber_alertas CHAR(1),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

-- Histórico de alertas enviados ao usuário
CREATE TABLE historico_alerta_usuario (
    id INT PRIMARY KEY,
    usuario_id INT,
    alerta_id INT,
    data_envio TIMESTAMP,
    visualizado CHAR(1),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (alerta_id) REFERENCES alerta(id)
);

-- Feedbacks de denúncias
CREATE TABLE feedback_denuncia (
    id INT PRIMARY KEY,
    denuncia_id INT,
    usuario_id INT,
    comentario CLOB,
    data_hora TIMESTAMP,
    FOREIGN KEY (denuncia_id) REFERENCES denuncia(id),
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);


-- Exercicio 2



-- OBS: NOSSA IDEIA É FOCADA NAS ENCHENTES DE SÃO PAULO, ENTÃO TERA APENAS 1 ESTADO
-- ESTADO
INSERT INTO estado (id, nome, uf) VALUES (1, 'São Paulo', 'SP');

-- OBS:NOSSA IDEIA É FOCADA NAS ENCHENTES DE SÃO PAULO, ENTÃO TERA APENAS 1 CIDADE
-- CIDADE
INSERT INTO cidade (id, nome, estado_id) VALUES (1, 'São Paulo', 1);

-- STATUS VALIDAÇÃO
INSERT INTO status_validacao (id, descricao) VALUES (1, 'Pendente');
INSERT INTO status_validacao (id, descricao) VALUES (2, 'Aprovado');
INSERT INTO status_validacao (id, descricao) VALUES (3, 'Recusado');
INSERT INTO status_validacao (id, descricao) VALUES (4, 'Resolvido');
INSERT INTO status_validacao (id, descricao) VALUES (5, 'Em análise');

-- TIPO SENSOR
INSERT INTO tipo_sensor (id, nome) VALUES (1, 'Ultrassônico');
INSERT INTO tipo_sensor (id, nome) VALUES (2, 'Radar');
INSERT INTO tipo_sensor (id, nome) VALUES (3, 'Pressão');
INSERT INTO tipo_sensor (id, nome) VALUES (4, 'Laser');
INSERT INTO tipo_sensor (id, nome) VALUES (5, 'Simulado');


-- USUÁRIO
INSERT INTO usuario (id, nome, email, senha, telefone) VALUES (1, 'João Silva', 'joao@email.com', '123456', '11999999991');
INSERT INTO usuario (id, nome, email, senha, telefone) VALUES (2, 'Maria Souza', 'maria@email.com', '123456', '11999999992');
INSERT INTO usuario (id, nome, email, senha, telefone) VALUES (3, 'Carlos Lima', 'carlos@email.com', '123456', '11999999993');
INSERT INTO usuario (id, nome, email, senha, telefone) VALUES (4, 'Ana Clara', 'ana@email.com', '123456', '11999999994');
INSERT INTO usuario (id, nome, email, senha, telefone) VALUES (5, 'Lucas Rocha', 'lucas@email.com', '123456', '11999999995');

-- ENDEREÇO USUÁRIO
INSERT INTO endereco_usuario (id, usuario_id, apelido, cep, logradouro, numero, bairro, cidade_id, latitude, longitude) 
VALUES (1, 1, 'Casa', '01200-000', 'Rua A', '100', 'Centro', 1, -23.5505, -46.6333);
INSERT INTO endereco_usuario (id, usuario_id, apelido, cep, logradouro, numero, bairro, cidade_id, latitude, longitude) 
VALUES (2, 2, 'Trabalho', '01300-000', 'Rua B', '200', 'Bela Vista', 1, -23.5610, -46.6555);
INSERT INTO endereco_usuario (id, usuario_id, apelido, cep, logradouro, numero, bairro, cidade_id, latitude, longitude) 
VALUES (3, 3, 'Mãe', '01400-000', 'Rua C', '300', 'Paulista', 1, -23.5632, -46.6544);
INSERT INTO endereco_usuario (id, usuario_id, apelido, cep, logradouro, numero, bairro, cidade_id, latitude, longitude) 
VALUES (4, 4, 'Tia', '01500-000', 'Rua D', '400', 'Ipiranga', 1, -23.5855, -46.6201);
INSERT INTO endereco_usuario (id, usuario_id, apelido, cep, logradouro, numero, bairro, cidade_id, latitude, longitude) 
VALUES (5, 5, 'Apartamento', '01600-000', 'Rua E', '500', 'Mooca', 1, -23.5600, -46.6100);

-- SENSORES
INSERT INTO sensor (id, nome, localizacao, latitude, longitude, tipo_sensor_id, nivel_maximo_seguro) 
VALUES (1, 'Sensor Tietê 1', 'Ponte Piqueri', -23.5200, -46.6700, 1, 3.5);
INSERT INTO sensor (id, nome, localizacao, latitude, longitude, tipo_sensor_id, nivel_maximo_seguro) 
VALUES (2, 'Sensor Aricanduva', 'Av. Aricanduva', -23.5600, -46.5600, 2, 2.5);
INSERT INTO sensor (id, nome, localizacao, latitude, longitude, tipo_sensor_id, nivel_maximo_seguro) 
VALUES (3, 'Sensor Ipiranga', 'Rua Ipiranga', -23.5800, -46.6300, 3, 3.0);
INSERT INTO sensor (id, nome, localizacao, latitude, longitude, tipo_sensor_id, nivel_maximo_seguro) 
VALUES (4, 'Sensor Mooca', 'Av. Paes de Barros', -23.5700, -46.6100, 4, 2.8);
INSERT INTO sensor (id, nome, localizacao, latitude, longitude, tipo_sensor_id, nivel_maximo_seguro) 
VALUES (5, 'Sensor Simulado', 'Teste Técnico', -23.6000, -46.6000, 5, 4.0);

-- MEDIÇÃO
INSERT INTO medicao (id, sensor_id, data_hora, nivel_agua, alerta) VALUES (1, 1, SYSTIMESTAMP, 2.0, 'normal');
INSERT INTO medicao (id, sensor_id, data_hora, nivel_agua, alerta) VALUES (2, 2, SYSTIMESTAMP, 2.6, 'alerta');
INSERT INTO medicao (id, sensor_id, data_hora, nivel_agua, alerta) VALUES (3, 3, SYSTIMESTAMP, 3.2, 'atencao');
INSERT INTO medicao (id, sensor_id, data_hora, nivel_agua, alerta) VALUES (4, 4, SYSTIMESTAMP, 3.0, 'critico');
INSERT INTO medicao (id, sensor_id, data_hora, nivel_agua, alerta) VALUES (5, 5, SYSTIMESTAMP, 1.5, 'normal');

-- ALERTA
INSERT INTO alerta (id, sensor_id, mensagem, nivel_agua, nivel_alerta, data_alerta, horario_alerta)
VALUES (1, 1, 'Nível normal', 2.0, 'normal', SYSDATE, TO_CHAR(SYSDATE, 'HH24:MI'));
INSERT INTO alerta (id, sensor_id, mensagem, nivel_agua, nivel_alerta, data_alerta, horario_alerta)
VALUES (2, 2, 'Atenção! Nível acima do seguro', 2.6, 'alerta', SYSDATE, TO_CHAR(SYSDATE, 'HH24:MI'));
INSERT INTO alerta (id, sensor_id, mensagem, nivel_agua, nivel_alerta, data_alerta, horario_alerta)
VALUES (3, 3, 'Risco iminente!', 3.2, 'critico', SYSDATE, TO_CHAR(SYSDATE, 'HH24:MI'));
INSERT INTO alerta (id, sensor_id, mensagem, nivel_agua, nivel_alerta, data_alerta, horario_alerta)
VALUES (4, 4, 'Alerta máximo na região', 3.0, 'critico', SYSDATE, TO_CHAR(SYSDATE, 'HH24:MI'));
INSERT INTO alerta (id, sensor_id, mensagem, nivel_agua, nivel_alerta, data_alerta, horario_alerta)
VALUES (5, 5, 'Simulação em andamento', 1.5, 'normal', SYSDATE, TO_CHAR(SYSDATE, 'HH24:MI'));

-- DENUNCIA
INSERT INTO denuncia (id, usuario_id, local, latitude, longitude, imagem_url, descricao, data_hora, status_id)
VALUES (1, 1, 'Rua da Lama', -23.5501, -46.6301, 'img1.jpg', 'Alagamento grave', SYSTIMESTAMP, 1);
INSERT INTO denuncia (id, usuario_id, local, latitude, longitude, imagem_url, descricao, data_hora, status_id)
VALUES (2, 2, 'Av. Inundada', -23.5511, -46.6311, 'img2.jpg', 'Via intransitável', SYSTIMESTAMP, 2);
INSERT INTO denuncia (id, usuario_id, local, latitude, longitude, imagem_url, descricao, data_hora, status_id)
VALUES (3, 3, 'Travessa Molhada', -23.5522, -46.6322, 'img3.jpg', 'Precisa de limpeza', SYSTIMESTAMP, 3);
INSERT INTO denuncia (id, usuario_id, local, latitude, longitude, imagem_url, descricao, data_hora, status_id)
VALUES (4, 4, 'Beco Encharcado', -23.5533, -46.6333, 'img4.jpg', 'Canal entupido', SYSTIMESTAMP, 4);
INSERT INTO denuncia (id, usuario_id, local, latitude, longitude, imagem_url, descricao, data_hora, status_id)
VALUES (5, 5, 'Esquina da Água', -23.5544, -46.6344, 'img5.jpg', 'Precisa de vistoria', SYSTIMESTAMP, 5);

-- LOCAL SALVO
INSERT INTO local_salvo (id, usuario_id, nome_local, latitude, longitude, receber_alertas)
VALUES (1, 1, 'Casa da Mãe', -23.5505, -46.6333, 'S');
INSERT INTO local_salvo (id, usuario_id, nome_local, latitude, longitude, receber_alertas)
VALUES (2, 2, 'Trabalho', -23.5600, -46.6500, 'S');
INSERT INTO local_salvo (id, usuario_id, nome_local, latitude, longitude, receber_alertas)
VALUES (3, 3, 'Minha Casa', -23.5700, -46.6200, 'N');
INSERT INTO local_salvo (id, usuario_id, nome_local, latitude, longitude, receber_alertas)
VALUES (4, 4, 'Estúdio', -23.5800, -46.6400, 'S');
INSERT INTO local_salvo (id, usuario_id, nome_local, latitude, longitude, receber_alertas)
VALUES (5, 5, 'Apartamento SP', -23.5900, -46.6000, 'N');

-- HISTORICO ALERTA USUARIO
INSERT INTO historico_alerta_usuario (id, usuario_id, alerta_id, data_envio, visualizado)
VALUES (1, 1, 1, SYSTIMESTAMP, 'S');
INSERT INTO historico_alerta_usuario (id, usuario_id, alerta_id, data_envio, visualizado)
VALUES (2, 2, 2, SYSTIMESTAMP, 'N');
INSERT INTO historico_alerta_usuario (id, usuario_id, alerta_id, data_envio, visualizado)
VALUES (3, 3, 3, SYSTIMESTAMP, 'S');
INSERT INTO historico_alerta_usuario (id, usuario_id, alerta_id, data_envio, visualizado)
VALUES (4, 4, 4, SYSTIMESTAMP, 'N');
INSERT INTO historico_alerta_usuario (id, usuario_id, alerta_id, data_envio, visualizado)
VALUES (5, 5, 5, SYSTIMESTAMP, 'S');

-- FEEDBACK DENUNCIA
INSERT INTO feedback_denuncia (id, denuncia_id, usuario_id, comentario, data_hora)
VALUES (1, 1, 2, 'Confirma alagamento, passei por lá.', SYSTIMESTAMP);
INSERT INTO feedback_denuncia (id, denuncia_id, usuario_id, comentario, data_hora)
VALUES (2, 2, 3, 'Situação crítica mesmo.', SYSTIMESTAMP);
INSERT INTO feedback_denuncia (id, denuncia_id, usuario_id, comentario, data_hora)
VALUES (3, 3, 4, 'Já notificaram a prefeitura?', SYSTIMESTAMP);
INSERT INTO feedback_denuncia (id, denuncia_id, usuario_id, comentario, data_hora)
VALUES (4, 4, 5, 'Vi isso na TV, é verdade.', SYSTIMESTAMP);
INSERT INTO feedback_denuncia (id, denuncia_id, usuario_id, comentario, data_hora)
VALUES (5, 5, 1, 'Denúncia válida.', SYSTIMESTAMP);


SELECT * FROM estado;
SELECT * FROM cidade;
SELECT * FROM usuario;
SELECT * FROM endereco_usuario;
SELECT * FROM tipo_sensor;
SELECT * FROM sensor;
SELECT * FROM medicao;
SELECT * FROM alerta;
SELECT * FROM status_validacao;
SELECT * FROM denuncia;
SELECT * FROM local_salvo;
SELECT * FROM historico_alerta_usuario;
SELECT * FROM feedback_denuncia;


-- Exercicio 3

-- Package procedure Cabeçalho
CREATE OR REPLACE PACKAGE alagaSp AS
  -- PROCEDURES
  PROCEDURE inserir_denuncia(
    p_usuario_id INT,
    p_local VARCHAR2,
    p_lat NUMBER,
    p_long NUMBER,
    p_img VARCHAR2,
    p_desc CLOB,
    p_status_id INT
  );

  PROCEDURE atualizar_denuncia(
    p_id INT,
    p_desc CLOB,
    p_status_id INT
  );

  PROCEDURE excluir_denuncia(
    p_id INT
  );

  -- FUNÇÃO
  FUNCTION risco_sensor(p_sensor_id INT) RETURN VARCHAR2;

  -- RELATÓRIO (JOIN + agregação)
  PROCEDURE relatorio_denuncias;

  -- CURSOR com LOOP
  PROCEDURE listar_sensores_criticos;
END alagaSp;
/







-- Sequência para gerar IDs da tabela DENUNCIA
CREATE SEQUENCE denuncia_seq
START WITH 1
INCREMENT BY 1
NOCACHE;

-- Sequência para gerar IDs da tabela ALERTA
CREATE SEQUENCE alerta_seq
START WITH 1
INCREMENT BY 1
NOCACHE;




CREATE OR REPLACE PACKAGE BODY alagaSp AS
  -- PROCEDURE: Inserir denúncia
  PROCEDURE inserir_denuncia(
    p_usuario_id INT,
    p_local VARCHAR2,
    p_lat NUMBER,
    p_long NUMBER,
    p_img VARCHAR2,
    p_desc CLOB,
    p_status_id INT
  ) IS
  BEGIN
    INSERT INTO denuncia (
      id, usuario_id, local, latitude, longitude,
      imagem_url, descricao, data_hora, status_id
    ) VALUES (
      denuncia_seq.NEXTVAL, p_usuario_id, p_local, p_lat, p_long,
      p_img, p_desc, SYSTIMESTAMP, p_status_id
    );
  END;

  -- PROCEDURE: Atualizar denúncia
  PROCEDURE atualizar_denuncia(
    p_id INT,
    p_desc CLOB,
    p_status_id INT
  ) IS
  BEGIN
    UPDATE denuncia
    SET descricao = p_desc,
        status_id = p_status_id
    WHERE id = p_id;
  END;

  -- PROCEDURE: Excluir denúncia
  PROCEDURE excluir_denuncia(p_id INT) IS
  BEGIN
    DELETE FROM denuncia
    WHERE id = p_id;
  END;

  -- FUNÇÃO: Retorna o risco de um sensor com base na última medição
  FUNCTION risco_sensor(p_sensor_id INT) RETURN VARCHAR2 IS
    v_nivel NUMBER;
    v_limite NUMBER;
    v_risco VARCHAR2(20);
  BEGIN
    SELECT nivel_agua
    INTO v_nivel
    FROM medicao
    WHERE sensor_id = p_sensor_id
    ORDER BY data_hora DESC
    FETCH FIRST ROW ONLY;

    SELECT nivel_maximo_seguro
    INTO v_limite
    FROM sensor
    WHERE id = p_sensor_id;

    IF v_nivel < v_limite * 0.7 THEN
      v_risco := 'Baixo';
    ELSIF v_nivel < v_limite THEN
      v_risco := 'Médio';
    ELSE
      v_risco := 'Alto';
    END IF;

    RETURN v_risco;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 'Sem dados';
  END;

  -- PROCEDURE: Relatório com JOIN e agregação
  PROCEDURE relatorio_denuncias IS
  BEGIN
    FOR r IN (
      SELECT s.descricao AS status,
             e.bairro,
             COUNT(*) AS total
      FROM denuncia d
      JOIN status_validacao s ON d.status_id = s.id
      JOIN endereco_usuario e ON d.usuario_id = e.usuario_id
      GROUP BY s.descricao, e.bairro
    ) LOOP
      DBMS_OUTPUT.PUT_LINE(
        'Status: ' || r.status ||
        ' | Bairro: ' || r.bairro ||
        ' | Total: ' || r.total
      );
    END LOOP;
  END;

  -- PROCEDURE: Cursor com LOOP - sensores com nível acima do permitido
  PROCEDURE listar_sensores_criticos IS
    CURSOR c_sensores IS
      SELECT s.nome, m.nivel_agua, s.nivel_maximo_seguro
      FROM sensor s
      JOIN medicao m ON m.sensor_id = s.id
      WHERE m.nivel_agua > s.nivel_maximo_seguro;

    v_nome sensor.nome%TYPE;
    v_nivel NUMBER;
    v_limite NUMBER;
  BEGIN
    OPEN c_sensores;
    LOOP
      FETCH c_sensores INTO v_nome, v_nivel, v_limite;
      EXIT WHEN c_sensores%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(
        'Sensor: ' || v_nome ||
        ' | Nível: ' || v_nivel ||
        ' | Limite: ' || v_limite
      );
    END LOOP;
    CLOSE c_sensores;
  END;

END alagaSp;
/



-- Trigger
CREATE OR REPLACE TRIGGER trg_alerta_medicao
AFTER INSERT ON medicao
FOR EACH ROW
DECLARE
  v_limite NUMBER;
BEGIN
  SELECT nivel_maximo_seguro
  INTO v_limite
  FROM sensor
  WHERE id = :NEW.sensor_id;

  IF :NEW.nivel_agua > v_limite THEN
    INSERT INTO alerta (
      id, sensor_id, mensagem, nivel_agua, nivel_alerta, data_alerta, horario_alerta
    ) VALUES (
      alerta_seq.NEXTVAL,
      :NEW.sensor_id,
      'Nível crítico detectado automaticamente',
      :NEW.nivel_agua,
      'critico',
      SYSDATE,
      TO_CHAR(SYSDATE, 'HH24:MI')
    );
  END IF;
END;
/


-- Bloco if/else
DECLARE
  v_status_id INT := 2;
BEGIN
  IF v_status_id = 1 THEN
    DBMS_OUTPUT.PUT_LINE('Denúncia ainda pendente.');
  ELSIF v_status_id = 2 THEN
    DBMS_OUTPUT.PUT_LINE('Denúncia aprovada.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Outro status.');
  END IF;
END;
/



-- Exercicio 4

-- Relatório: Total de denúncias por bairro e status
SELECT 
  e.bairro,
  s.descricao AS status,
  COUNT(d.id) AS total_denuncias
FROM 
  denuncia d
JOIN endereco_usuario e ON d.usuario_id = e.usuario_id
JOIN status_validacao s ON d.status_id = s.id
GROUP BY 
  e.bairro, s.descricao
ORDER BY 
  total_denuncias DESC;


-- Relatório: Quantidade de sensores com risco alto
SELECT 
  s.nome,
  MAX(m.nivel_agua) AS nivel_maximo,
  s.nivel_maximo_seguro,
  CASE 
    WHEN MAX(m.nivel_agua) > s.nivel_maximo_seguro THEN 'ALTO'
    ELSE 'SEGURO'
  END AS risco
FROM 
  sensor s
JOIN medicao m ON m.sensor_id = s.id
GROUP BY 
  s.nome, s.nivel_maximo_seguro
ORDER BY 
  risco DESC;


-- Relatório: Sensores com maior média de nível d’água
SELECT 
  s.nome AS sensor,
  s.localizacao,
  ROUND(AVG(m.nivel_agua), 2) AS media_nivel_agua
FROM 
  sensor s
JOIN medicao m ON m.sensor_id = s.id
GROUP BY 
  s.nome, s.localizacao
ORDER BY 
  media_nivel_agua DESC;

-- Relatório: Usuários com mais locais salvos para monitoramento
SELECT 
  u.nome AS usuario,
  COUNT(ls.id) AS total_locais_salvos
FROM 
  usuario u
LEFT JOIN local_salvo ls ON u.id = ls.usuario_id
GROUP BY 
  u.nome
HAVING 
  COUNT(ls.id) > 0
ORDER BY 
  total_locais_salvos DESC;

-- Relatório: Quantos alertas foram visualizados vs não visualizados
SELECT 
  CASE ha.visualizado 
    WHEN 'S' THEN 'Visualizado' 
    WHEN 'N' THEN 'Não Visualizado' 
    ELSE 'Indefinido' 
  END AS status_visualizacao,
  COUNT(*) AS total
FROM 
  historico_alerta_usuario ha
GROUP BY 
  ha.visualizado;

-- Relatório: Quantidade de sensores com risco alto
SELECT 
  s.nome,
  MAX(m.nivel_agua) AS nivel_maximo,
  s.nivel_maximo_seguro,
  CASE 
    WHEN MAX(m.nivel_agua) > s.nivel_maximo_seguro THEN 'ALTO'
    ELSE 'SEGURO'
  END AS risco
FROM 
  sensor s
JOIN medicao m ON m.sensor_id = s.id
GROUP BY 
  s.nome, s.nivel_maximo_seguro
ORDER BY 
  risco DESC;












