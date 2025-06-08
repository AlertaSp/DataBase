# 🗂️ AlertaSP - Banco de Dados (Oracle SQL)

Este repositório contém a modelagem e implementação do banco de dados relacional do projeto **AlertaSP**, criado em **Oracle SQL**.

O banco visa armazenar e organizar dados relacionados a usuários, denúncias, relatórios de alagamento, sensores, localização e eventos associados. Ele é parte fundamental do sistema, garantindo consistência e integridade na manipulação das informações.

---

## 📐 Modelo de Dados

A estrutura do banco foi projetada com base nas boas práticas de normalização (3FN), visando:

- Evitar redundâncias
- Garantir integridade referencial
- Facilitar integrações com sistemas externos e consultas analíticas

---

## 📊 Entidades principais

- **USUARIO**: armazena dados de usuários do app
- **ENDERECO_USUARIO**: vínculo de usuário com localizações
- **DENUNCIA**: denúncias registradas pelos cidadãos
- **RELATO_ALAGAMENTO**: registros de alagamentos com geolocalização
- **CHECKLIST_PREVENCAO**: itens de boas práticas em época de chuva
- **SENSOR**: sensores de IoT associados a regiões monitoradas
- **EVENTO_SENSOR**: logs recebidos dos sensores
- **RELATORIO**: histórico de ações preventivas ou ocorrências
