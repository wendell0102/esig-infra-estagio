<<<<<<< HEAD
# esig-infra-estagio
Atividade Técnica - Estágio em Infraestrutura (ESIG Group) - Scripts para dump/restore PostgreSQL e monitoramento JBoss/Tomcat
=======
# Atividade Técnica - Estágio ESIG 🚀

Fala pessoal! Esse é o repo que eu criei pra atividade técnica do processo seletivo de estágio em Infraestrutura do ESIG Group. Bora lá!

## 📝 O que tem aqui?

Bom, basicamente eu criei uns scripts em Bash que fazem o seguinte:

- **Backup do PostgreSQL**: Scripts pra criar banco, fazer dump e restore (aquela rotina básica mesmo)
- **Monitoramento de serviços**: Uns checks no JBoss e Tomcat pra ver se tá tudo rodando certinho
- **Auto-restart esperto**: Se o serviço ficar parado por mais de 1 minuto, o script reinicia sozinho (bem útil!)

## 📂 Como tá organizado?

```
esig-infra-estagio/
├── scripts/
│   ├── create_db.sh          # Cria o banco e uma tabelinha de exemplo
│   ├── dump_db.sh            # Faz backup do banco
│   ├── restore_db.sh         # Restaura o backup
│   ├── check_jboss.sh        # Checa se o JBoss tá vivo
│   ├── check_tomcat.sh       # Checa se o Tomcat tá rodando
│   ├── monitor_jboss.sh      # Fica de olho no JBoss e reinicia se precisar
│   └── monitor_tomcat.sh     # Mesma coisa pro Tomcat
├── sql/
│   └── init.sql              # Script SQL inicial
├── .env.example              # Arquivo de configuração de exemplo
└── README.md                 # Você tá aqui! 👋
```

## ⚙️ O que você precisa ter instalado

- Linux (testei no Ubuntu, mas deve rodar no Debian/CentOS também)
- PostgreSQL 12 ou mais novo (precisa do `psql`, `pg_dump` e `createdb`)
- JBoss e/ou Tomcat (óbvio né haha)
- Bash 4.0 pra cima

## 🚀 Como usar?

### 1. Clona o repo

```bash
git clone https://github.com/wendell0102/esig-infra-estagio.git
cd esig-infra-estagio
```

### 2. Configura as variáveis

Copia o arquivo de exemplo e edita com teus dados:

```bash
cp .env.example .env
nano .env  # ou usa o editor que você preferir
```

### 3. Dá permissão pros scripts

```bash
chmod +x scripts/*.sh
```

## 📊 Rodando os scripts

### PostgreSQL

**Criar o banco:**
```bash
./scripts/create_db.sh
```

**Fazer backup:**
```bash
./scripts/dump_db.sh
# O arquivo backup_esig_infra.sql vai ser criado
```

**Restaurar backup:**
```bash
./scripts/restore_db.sh
```

### JBoss / Tomcat

**Ver se tá rodando:**
```bash
./scripts/check_jboss.sh
./scripts/check_tomcat.sh
```

Vai aparecer algo tipo:
```
JBoss status: running
JBoss uptime: 0d 2h 15m 30s
```

**Monitoramento com auto-restart:**

Esses scripts ficam de olho no serviço e reiniciam se ele ficar parado por mais de 60 segundos:

```bash
./scripts/monitor_jboss.sh
./scripts/monitor_tomcat.sh
```

### Automatizando com Cron

Pra deixar rodando o monitoramento direto, adiciona no cron:

```bash
crontab -e
```

E cola essas linhas (ajusta o caminho pro teu setup):

```
* * * * * /caminho/completo/scripts/monitor_jboss.sh >> /var/log/monitor_jboss.log 2>&1
* * * * * /caminho/completo/scripts/monitor_tomcat.sh >> /var/log/monitor_tomcat.log 2>&1
```

## 🔧 Configuração (.env)

Exemplo de como fica o arquivo `.env`:

```bash
# PostgreSQL
PG_HOST=localhost
PG_PORT=5432
PG_USER=postgres
PG_DATABASE=esig_infra
PG_DUMP_FILE=backup_esig_infra.sql

# JBoss
JBOSS_SERVICE_NAME=jboss
JBOSS_PID_FILE=/opt/jboss/standalone/tmp/startup-marker.pid
JBOSS_START_CMD="/opt/jboss/bin/standalone.sh &"

# Tomcat
TOMCAT_SERVICE_NAME=tomcat
TOMCAT_PID_FILE=/opt/tomcat/temp/tomcat.pid
TOMCAT_START_CMD="/opt/tomcat/bin/startup.sh"
```

## 💡 Features legais

### Scripts do PostgreSQL
- **create_db.sh**: Cria o banco automático e trata erro se já existir (nada de script quebrando)
- **dump_db.sh**: Backup completo em SQL plano
- **restore_db.sh**: Valida se o arquivo existe antes de tentar restaurar

### Scripts de Monitoramento
- **Compatibilidade**: Funciona com `systemctl` ou com arquivo PID direto
- **Cálculo de uptime**: Mostra há quanto tempo o serviço tá rodando
- **Auto-restart inteligente**: Espera 60 segundos antes de reiniciar (evita restart em loop)
- **Persistência**: Usa arquivos temporários pra controlar quando o serviço caiu

## 🛠️ Tecnologias

- Bash Script
- PostgreSQL
- JBoss / Tomcat
- Systemd

## 👨‍💻 Sobre mim

**Wendell Nascimento**

- GitHub: [@wendell0102](https://github.com/wendell0102)
- Projeto: Atividade Técnica ESIG - Fevereiro 2026

---

⭐ Feito com café e dedicação pro processo seletivo de estágio em Infraestrutura do ESIG Group!
Repositório criado para a atividade técnica do processo seletivo de estágio em Infraestrutura do ESIG Group.

## 📝 Sobre o Projeto

Este projeto implementa scripts Bash para:

- **Gerenciamento de banco PostgreSQL**: Criação, dump e restore de banco de dados
- **Monitoramento de serviços**: Verificação de status e tempo de atividade de JBoss e Tomcat
- **Auto-restart inteligente**: Reinicia automaticamente serviços parados por mais de 60 segundos

## 📁 Estrutura do Projeto

```
esig-infra-estagio/
├── scripts/
│   ├── create_db.sh          # Cria banco PostgreSQL e tabela de exemplo
│   ├── dump_db.sh            # Gera dump do banco
│   ├── restore_db.sh         # Restaura banco a partir do dump
│   ├── check_jboss.sh        # Verifica status do JBoss
│   ├── check_tomcat.sh       # Verifica status do Tomcat
│   ├── monitor_jboss.sh      # Monitora e reinicia JBoss se necessário
│   └── monitor_tomcat.sh     # Monitora e reinicia Tomcat se necessário
├── sql/
│   └── init.sql              # Script SQL de inicialização
├── .env.example            # Exemplo de configuração
└── README.md
```

## ⚙️ Requisitos

- Linux (Ubuntu/Debian/CentOS)
- PostgreSQL 12+ (cliente: `psql`, `pg_dump`, `createdb`)
- JBoss e/ou Tomcat instalados
- Bash 4.0+

## 🚀 Instalação

### 1. Clone o repositório

```bash
git clone https://github.com/wendell0102/esig-infra-estagio.git
cd esig-infra-estagio
```

### 2. Configure as variáveis de ambiente

```bash
cp .env.example .env
# Edite o arquivo .env com suas credenciais
nano .env
```

### 3. Torne os scripts executáveis

```bash
chmod +x scripts/*.sh
```

## 📊 Uso

### PostgreSQL

#### Criar banco e tabela

```bash
./scripts/create_db.sh
```

#### Gerar dump

```bash
./scripts/dump_db.sh
# Arquivo gerado: backup_esig_infra.sql
```

#### Restaurar backup

```bash
./scripts/restore_db.sh
```

### JBoss / Tomcat

#### Verificar status

```bash
./scripts/check_jboss.sh
./scripts/check_tomcat.sh
```

**Saída esperada:**
```
JBoss status: running
JBoss uptime: 0d 2h 15m 30s
```

#### Monitoramento automático

Para monitorar e reiniciar automaticamente quando o serviço ficar parado por mais de 60s:

```bash
./scripts/monitor_jboss.sh
./scripts/monitor_tomcat.sh
```

### Automação via Cron

Adicione ao crontab para monitoramento contínuo (a cada minuto):

```bash
crontab -e
```

Adicione as linhas:

```cron
* * * * * /caminho/completo/scripts/monitor_jboss.sh >> /var/log/monitor_jboss.log 2>&1
* * * * * /caminho/completo/scripts/monitor_tomcat.sh >> /var/log/monitor_tomcat.log 2>&1
```

## 🔧 Configuração (.env)

Exemplo de arquivo `.env`:

```bash
# PostgreSQL
PG_HOST=localhost
PG_PORT=5432
PG_USER=postgres
PG_DATABASE=esig_infra
PG_DUMP_FILE=backup_esig_infra.sql

# JBoss
JBOSS_SERVICE_NAME=jboss
JBOSS_PID_FILE=/opt/jboss/standalone/tmp/startup-marker.pid
JBOSS_START_CMD="/opt/jboss/bin/standalone.sh &"

# Tomcat
TOMCAT_SERVICE_NAME=tomcat
TOMCAT_PID_FILE=/opt/tomcat/temp/tomcat.pid
TOMCAT_START_CMD="/opt/tomcat/bin/startup.sh"
```

## 💡 Funcionalidades

### Scripts PostgreSQL

- **create_db.sh**: Cria banco automaticamente, trata erros se já existir
- **dump_db.sh**: Backup completo em formato SQL plano
- **restore_db.sh**: Valida existência do arquivo antes de restaurar

### Scripts de Monitoramento

- **Compatibilidade dupla**: Funciona com `systemctl` ou arquivos PID
- **Cálculo de uptime**: Exibe tempo de atividade formatado
- **Auto-restart inteligente**: Aguarda 60s antes de tentar reiniciar
- **Persistência de estado**: Usa arquivos temporarios para rastrear downtime

## 📚 Tecnologias

- Bash Script
- PostgreSQL
- JBoss / Tomcat
- Systemd

## 👨‍💻 Autor

**Wendell Nascimento**
- GitHub: [@wendell0102](https://github.com/wendell0102)
- Projeto: Atividade Técnica ESIG - Fevereiro 2026

---

⭐ Desenvolvido para o processo seletivo de estágio em Infraestrutura do ESIG Group
>>>>>>> d82bc4e (Deixa o README mais informal e com cara de estagiário)
