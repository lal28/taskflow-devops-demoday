#TaskFlow DevOps

[![Deploy Status](https://github.com/SEU_USUARIO/taskflow-devops/actions/workflows/deploy.yml/badge.svg)](https://github.com/SEU_USUARIO/taskflow-devops/actions)

Projeto de estudo demonstrando a implementação completa de práticas DevOps, desde o provisionamento de infraestrutura até deploy automatizado com CI/CD.

## 📋 Índice

- [Sobre o Projeto](#-sobre-o-projeto)
- [O Problema](#-o-problema)
- [A Solução](#-a-solução)
- [Arquitetura](#-arquitetura)
- [Tecnologias Utilizadas](#-tecnologias-utilizadas)
- [Pré-requisitos](#-pré-requisitos)
- [Como Executar](#-como-executar)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Pipeline CI/CD](#-pipeline-cicd)
- [Resultados Alcançados](#-resultados-alcançados)
- [Escopo de Implementação](#-escopo-de-implementação)
- [Limpeza de Recursos](#-limpeza-de-recursos)
- [Referências](#-referências)

## 🎯 Sobre o Projeto

O **TaskFlow** é uma API REST de gerenciamento de tarefas (To-Do List) desenvolvida para demonstrar a aplicação prática de conceitos DevOps em um cenário real de desenvolvimento de software.

### O Caso: TaskFlow Startup

A TaskFlow é uma startup fictícia que enfrentava problemas típicos de empresas em crescimento: processos manuais de deploy, alta taxa de falhas e lentidão na entrega de novas funcionalidades.

## 😓 O Problema

### Cenário ANTES do DevOps

**Situação-Problema**: Processos manuais e burocráticos tornavam a implantação de novas funcionalidades um processo lento e doloroso.

#### Processo Manual de Deploy

1. **Desenvolvimento** (2-3 dias)
   - Desenvolvedor implementa funcionalidade
   - Testa apenas localmente
   - Commita código no repositório

2. **Aprovação** (3-5 dias)
   - Abertura de ticket
   - Aprovação do gerente (1-2 dias de espera)
   - Documentação manual
   - Agendamento para sexta à noite

3. **Deploy Manual** (sexta-feira, 22h)
   ```bash
   # Processo executado pelo desenvolvedor de plantão
   ssh servidor-producao
   systemctl stop app
   git pull
   npm install  # cruzando os dedos 🤞
   # Rodar SQLs manualmente
   systemctl start app
   # Testar manualmente cada endpoint
   ```

4. **Problemas Comuns**
   - ❌ "Funcionava na minha máquina" - ambiente diferente
   - ❌ Scripts SQL esquecidos
   - ❌ Variáveis de ambiente incorretas
   - ❌ Rollback manual e demorado
   - ❌ Sistema fora do ar por 30min a 2h

### Impacto nos Números

| Métrica | Antes do DevOps |
|---------|-----------------|
| **Tempo de deploy** | 14 dias (do código à produção) |
| **Frequência de deploy** | 2-3 por mês (apenas sextas à noite) |
| **Taxa de falha** | 40% dos deploys tinham problemas |
| **Tempo de rollback** | 1-3 horas |
| **Downtime por deploy** | 45 minutos em média |
| **Horas extras** | 8 horas/mês (plantões noturnos) |

### Depoimentos da Equipe

> "Eu tinha medo de sexta-feira. Uma vez esqueci de rodar o script do banco e tive que fazer rollback às 23h."  
> — João, Desenvolvedor

> "Os clientes reclamavam que um bug simples levava 2 semanas para ser corrigido."  
> — Maria, Líder de Projeto

## 💡 A Solução

Implementação de um pipeline completo de DevOps com:

1. **Infrastructure as Code (IaC)** - Terraform
2. **Configuration Management** - Ansible
3. **Containerização** - Docker
4. **CI/CD** - GitHub Actions

### Benefícios Alcançados

| Métrica | Depois do DevOps | Melhoria |
|---------|------------------|----------|
| **Tempo de deploy** | 5 minutos | **99.7% mais rápido** |
| **Frequência de deploy** | Múltiplos por dia | **10x mais deploys** |
| **Taxa de falha** | <5% | **88% menos falhas** |
| **Tempo de rollback** | 2 minutos | **95% mais rápido** |
| **Downtime por deploy** | ~30 segundos | **98% menos downtime** |
| **Horas extras** | 0 horas/mês | **100% eliminadas** |

## 🏗️ Arquitetura

```
┌─────────────────────────────────────────────────────────────────┐
│                         DESENVOLVEDOR                           │
│                              ↓                                  │
│                     git push (GitHub)                           │
└─────────────────────────────────────────────────────────────────┘
                               ↓
┌─────────────────────────────────────────────────────────────────┐
│                     GITHUB ACTIONS (CI/CD)                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐           │
│  │  Build       │→ │  Lint Check  │→ │  Deploy      │           │
│  │  (Docker)    │  │  (Code QA)   │  │  (Ansible)   │           │
│  └──────────────┘  └──────────────┘  └──────────────┘           │
└─────────────────────────────────────────────────────────────────┘
                               ↓
┌─────────────────────────────────────────────────────────────────┐
│                    AWS EC2 (Provisionado com Terraform)         │
│                                                                 │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │                      Docker Host                           │ │
│  │  ┌──────────────────┐       ┌──────────────────┐           │ │
│  │  │  Container App   │◄─────►│  Container DB    │           │ │
│  │  │  (Node.js API)   │       │  (PostgreSQL)    │           │ │
│  │  │  Port: 3000      │       │  Port: 5432      │           │ │
│  │  └──────────────────┘       └──────────────────┘           │ │
│  └────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
                               ↓
                      Usuários finais (API REST)
```

### Fluxo de Deploy Automatizado

```
Developer Commit → GitHub Actions Trigger → Build Docker Image → 
Code Quality Check → Push to Registry → Ansible Deploy → 
Health Check → Production Ready! ✅
```

## 🛠️ Tecnologias Utilizadas

### Aplicação
- **Node.js 18** - Runtime JavaScript
- **Express** - Framework web
- **PostgreSQL 15** - Banco de dados relacional
- **Docker** - Containerização

### DevOps Tools
- **Terraform** - Infrastructure as Code (IaC)
- **Ansible** - Configuration Management
- **GitHub Actions** - CI/CD
- **Docker** - Containerização e orquestração

### Cloud Provider
- **AWS EC2** - Instâncias de computação
- **AWS Security Groups** - Firewall
- **AWS Key Pairs** - Autenticação SSH

## 📦 Pré-requisitos

### Ferramentas Locais (WSL/Linux)
```bash
# Docker
docker --version  # Docker version 24.0+

# Terraform
terraform --version  # Terraform v1.5+

# Ansible
ansible --version  # ansible 2.9+

# Git
git --version  # git version 2.0+

# AWS CLI
aws --version  # aws-cli/2.0+

# Node.js (opcional, para testes locais)
node --version  # v18.0+
```

### Contas Necessárias
- [x] Conta AWS (free tier funciona)
- [x] Conta GitHub
- [x] Conta Docker Hub

### Credenciais Configuradas
```bash
# AWS CLI configurado
aws configure list

# Chave SSH gerada
ls ~/.ssh/taskflow-key
```

## 🚀 Como Executar

### 1️⃣ Clonar o Repositório

```bash
git clone https://github.com/SEU_USUARIO/taskflow-devops.git
cd taskflow-devops
```

### 2️⃣ Testar Localmente com Docker

```bash
# Subir aplicação local
docker-compose up -d

# Ver logs
docker-compose logs -f app

# Testar API
curl http://localhost:3000/health
curl http://localhost:3000/tasks

# Criar uma tarefa de teste
curl -X POST http://localhost:3000/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Teste local", "description": "Funciona!"}'

# Parar containers
docker-compose down
```

### 3️⃣ Provisionar Infraestrutura na AWS

```bash
# Gerar chave SSH
ssh-keygen -t rsa -b 4096 -f ~/.ssh/taskflow-key -N ""

# Configurar AWS CLI (se ainda não configurou)
aws configure

# Aplicar Terraform
cd terraform
terraform init
terraform plan
terraform apply  # Digite 'yes' para confirmar

# Anotar o IP público retornado
# Output: instance_public_ip = "X.X.X.X"

# Testar conexão SSH
ssh -i ~/.ssh/taskflow-key ubuntu@X.X.X.X
exit
```

### 4️⃣ Configurar Servidor com Ansible

```bash
cd ../ansible

# Editar inventory com o IP da sua instância
nano inventory/hosts.yml
# Substituir 'ansible_host' pelo seu IP

# Testar conectividade
ansible all -m ping

# Instalar Docker na VM
ansible-playbook playbooks/setup-docker.yml

# Fazer deploy da aplicação
ansible-playbook playbooks/deploy-app.yml

# Testar aplicação na AWS
curl http://SEU_IP:3000/health
curl http://SEU_IP:3000/tasks
```

### 5️⃣ Configurar CI/CD no GitHub

1. **Criar secrets no GitHub:**
   - Settings > Secrets and variables > Actions > New secret
   
   Adicionar:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `SSH_PRIVATE_KEY` (conteúdo de ~/.ssh/taskflow-key)
   - `SERVER_IP` (IP da instância EC2)
   - `DOCKER_HUB_USER`
   - `DOCKER_HUB_TOKEN`

2. **Fazer push e ver deploy automático:**
   ```bash
   git add .
   git commit -m "Setup CI/CD"
   git push
   
   # Acompanhar em: github.com/SEU_USUARIO/taskflow-devops/actions
   ```

### 6️⃣ Testar Mudanças Automáticas

```bash
# Editar código (exemplo: adicionar novo endpoint)
nano app/app.js

# Commit e push
git add app/app.js
git commit -m "feat: Add new endpoint"
git push

# GitHub Actions vai automaticamente:
# 1. Build da nova imagem Docker
# 2. Verificar qualidade do código
# 3. Fazer deploy na AWS
# 4. Validar com health check

# Após ~5 minutos, testar:
curl http://SEU_IP:3000/health
```

## 📁 Estrutura do Projeto

```
taskflow-devops/
│
├── app/                          # Aplicação Node.js
│   ├── app.js                    # Código principal da API
│   ├── package.json              # Dependências Node.js
│   ├── Dockerfile                # Imagem Docker da aplicação
│   ├── .dockerignore             # Arquivos ignorados no build
│   └── init.sql                  # Script de inicialização do DB
│
├── terraform/                    # Infrastructure as Code
│   ├── main.tf                   # Recursos AWS (EC2, SG, Key Pair)
│   ├── variables.tf              # Variáveis configuráveis
│   └── outputs.tf                # Outputs (IP, comandos SSH)
│
├── ansible/                      # Configuration Management
│   ├── ansible.cfg               # Configuração do Ansible
│   ├── inventory/
│   │   └── hosts.yml            # Inventário de servidores
│   └── playbooks/
│       ├── setup-docker.yml     # Instala Docker na VM
│       └── deploy-app.yml       # Deploy da aplicação
│
├── .github/
│   └── workflows/
│       └── deploy.yml           # Pipeline CI/CD GitHub Actions
│
├── docker-compose.yml           # Orquestração local
├── .gitignore                   # Arquivos ignorados pelo Git
└── README.md                    # Este arquivo
```

## 🔄 Pipeline CI/CD

### GitHub Actions Workflow

O pipeline é executado automaticamente a cada push na branch `main`:

```yaml
1. Build Job (2-3 min)
   └─ Checkout código
   └─ Setup Docker Buildx
   └─ Login Docker Hub
   └─ Build e Push imagem

2. Test Job (1 min)
   └─ Checkout código
   └─ Setup Node.js
   └─ Instalar dependências
   └─ Verificar qualidade do código

3. Deploy Job (2-3 min)
   └─ Checkout código
   └─ Configurar SSH
   └─ Instalar Ansible
   └─ Criar inventory dinâmico
   └─ Deploy com Ansible
   └─ Health check
```

### Visualizar Pipeline

```bash
# Ver status do último deploy
# Acesse: github.com/SEU_USUARIO/taskflow-devops/actions

# Ver logs detalhados de cada job
# Clique no workflow > Clique no job específico
```

## 📊 Resultados Alcançados

### Comparação Antes vs Depois

#### Velocidade de Entrega
- **Antes**: 14 dias do código à produção
- **Depois**: 5 minutos do commit ao deploy
- **Ganho**: 4.032x mais rápido

#### Confiabilidade
- **Antes**: 40% de taxa de falha nos deploys
- **Depois**: <5% de taxa de falha
- **Ganho**: 88% de redução em falhas

#### Disponibilidade
- **Antes**: 45 minutos de downtime por deploy
- **Depois**: ~30 segundos de downtime
- **Ganho**: 98% de redução em downtime

#### Produtividade
- **Antes**: 2-3 deploys por mês (apenas sextas à noite)
- **Depois**: Múltiplos deploys por dia (qualquer horário)
- **Ganho**: 10x mais deploys

#### Qualidade de Vida
- **Antes**: 8 horas/mês de plantão noturno
- **Depois**: 0 horas extras
- **Ganho**: Time mais feliz e produtivo 😊

### Métricas DORA

| Métrica | Antes | Depois | Classificação |
|---------|-------|---------|---------------|
| **Deployment Frequency** | 2-3/mês | Múltiplos/dia | 🟢 Elite |
| **Lead Time for Changes** | 14 dias | 5 minutos | 🟢 Elite |
| **Time to Restore Service** | 1-3 horas | 2 minutos | 🟢 Elite |
| **Change Failure Rate** | 40% | <5% | 🟢 Elite |

## 📝 Escopo de Implementação

### ✅ Implementado e Funcionando Completamente

Este projeto demonstra a implementação prática das principais práticas DevOps em um cenário real. **Foram implementadas de forma completa e funcional** as seguintes ferramentas e práticas:

#### Infrastructure as Code (Terraform)
- ✅ Provisionamento automático de instância EC2 na AWS
- ✅ Configuração de Security Groups (firewall)
- ✅ Gerenciamento de chaves SSH
- ✅ Infraestrutura versionada no Git
- ✅ Comandos: `terraform init`, `terraform apply`, `terraform destroy`

#### Configuration Management (Ansible)
- ✅ Instalação automática do Docker na VM
- ✅ Deploy automatizado da aplicação
- ✅ Configuração de containers (app + banco)
- ✅ Playbooks idempotentes e reutilizáveis

#### Containerização (Docker)
- ✅ Aplicação Node.js containerizada
- ✅ PostgreSQL containerizado
- ✅ Rede Docker isolada
- ✅ Volumes persistentes para dados
- ✅ Health checks configurados

#### CI/CD (GitHub Actions)
- ✅ Pipeline automático no push para main
- ✅ Build automático de imagem Docker
- ✅ Push para Docker Hub
- ✅ Deploy automático via Ansible na AWS
- ✅ Health check pós-deploy

#### Aplicação
- ✅ API REST funcional (CRUD completo)
- ✅ 5 endpoints funcionando:
  - `GET /health` - Status da aplicação
  - `GET /tasks` - Listar tarefas
  - `POST /tasks` - Criar tarefa
  - `PUT /tasks/:id` - Atualizar tarefa
  - `DELETE /tasks/:id` - Deletar tarefa
- ✅ Banco de dados PostgreSQL real com persistência
- ✅ Testável via curl ou navegador

### ⚠️ Simplificações e Melhorias Futuras

Por se tratar de um projeto educacional, alguns aspectos foram simplificados ou implementados de forma básica:

#### Testes Automatizados
- ⚠️ Verificação básica de código (placeholder para testes completos)
- 📝 **Melhoria futura**: Implementar testes unitários e de integração com Jest
- 💡 **Alternativa**: Implementar ESLint para análise estática de código

#### Segurança
- ⚠️ Credenciais de banco de dados configuradas via variáveis de ambiente
- ⚠️ Comunicação HTTP (sem SSL/TLS)
- 📝 **Melhoria futura**: AWS Secrets Manager para gerenciamento de credenciais
- 📝 **Melhoria futura**: Certificados SSL com Let's Encrypt ou AWS Certificate Manager

#### Monitoramento e Observabilidade
- ⚠️ Apenas health check básico implementado
- ⚠️ Logs disponíveis apenas via `docker logs`
- 📝 **Melhoria futura**: Prometheus + Grafana para métricas
- 📝 **Melhoria futura**: ELK Stack (Elasticsearch, Logstash, Kibana) para logs centralizados
- 📝 **Melhoria futura**: AWS CloudWatch para monitoramento de infraestrutura

#### Resiliência e Alta Disponibilidade
- ⚠️ Arquitetura single-instance (uma única VM)
- ⚠️ Sem rollback automático em caso de falha de deploy
- ⚠️ Sem backup automático do banco de dados
- 📝 **Melhoria futura**: Blue-Green deployment para zero downtime
- 📝 **Melhoria futura**: AWS RDS com backups automáticos
- 📝 **Melhoria futura**: Load Balancer + Auto Scaling Groups

#### Ambientes Múltiplos
- ⚠️ Apenas ambiente de produção configurado
- 📝 **Melhoria futura**: Ambientes separados (development, staging, production)
- 📝 **Melhoria futura**: GitOps com branches diferentes para cada ambiente

### 💬 Justificativa Técnica

Essas simplificações foram escolhas conscientes para **focar nos conceitos DevOps fundamentais**:

1. **IaC com Terraform** - Infraestrutura reproduzível e versionada
2. **Configuration Management com Ansible** - Automação de configuração
3. **Containerização com Docker** - Ambientes consistentes
4. **CI/CD com GitHub Actions** - Integração e entrega contínuas

Os recursos não implementados (testes avançados, secrets management, monitoramento completo, alta disponibilidade) representam evoluções naturais do projeto que não comprometem a demonstração dos conceitos core de DevOps, que são o objetivo principal deste trabalho acadêmico.

## 🧹 Limpeza de Recursos

**IMPORTANTE**: Para evitar custos na AWS, destrua os recursos quando terminar:

```bash
# 1. Parar aplicação local
docker-compose down -v

# 2. Destruir infraestrutura AWS
cd terraform
terraform destroy  # Digite 'yes' para confirmar

# Isso vai remover:
# - Instância EC2
# - Security Groups
# - Key Pairs
```



## 🎓 Conceitos DevOps Demonstrados

### 1. Infrastructure as Code (IaC)
- ✅ Infraestrutura versionada no Git
- ✅ Reproduzível em qualquer ambiente
- ✅ Facilita disaster recovery
- ✅ Documentação viva da infraestrutura

### 2. Configuration Management
- ✅ Configuração declarativa de servidores
- ✅ Idempotência (rodar múltiplas vezes = mesmo resultado)
- ✅ Automação de tarefas repetitivas
- ✅ Redução de erros humanos

### 3. Containerização
- ✅ Ambientes consistentes (dev = prod)
- ✅ Isolamento de aplicações
- ✅ Deploy rápido e confiável
- ✅ Facilita escalabilidade

### 4. CI/CD
- ✅ Integração contínua de código
- ✅ Deploy automatizado
- ✅ Validação automática (build + health check)
- ✅ Feedback rápido para desenvolvedores

### 5. Automação
- ✅ Pipeline end-to-end automatizado
- ✅ Redução de trabalho manual
- ✅ Maior frequência de deploys
- ✅ Menor taxa de erros

## 🔧 Troubleshooting

### Problema: Terraform não encontra credenciais AWS
```bash
# Solução
aws configure
# Informe: Access Key, Secret Key, região (us-east-1)

# Testar
aws sts get-caller-identity
```

### Problema: Ansible não conecta na VM
```bash
# Verificar chave SSH
ls -la ~/.ssh/taskflow-key
chmod 600 ~/.ssh/taskflow-key

# Testar conexão manual
ssh -i ~/.ssh/taskflow-key ubuntu@SEU_IP

# Verificar IP no inventory
cat ansible/inventory/hosts.yml
```

### Problema: GitHub Actions falha no deploy
```bash
# Verificar se todos os secrets estão configurados:
# - AWS_ACCESS_KEY_ID
# - AWS_SECRET_ACCESS_KEY
# - SSH_PRIVATE_KEY (incluindo -----BEGIN e -----END)
# - SERVER_IP
# - DOCKER_HUB_USER
# - DOCKER_HUB_TOKEN

# Ver logs detalhados no GitHub:
# Actions > Clique no workflow > Clique no job que falhou
```

### Problema: API não responde na porta 3000
```bash
# Verificar Security Group no AWS Console
# Deve ter regra: Inbound > TCP > Port 3000 > 0.0.0.0/0

# Verificar containers rodando na VM
ssh -i ~/.ssh/taskflow-key ubuntu@SEU_IP
docker ps
docker logs todo-api
docker logs todo-db
```

### Problema: Docker não sobe localmente
```bash
# Ver logs
docker-compose logs

# Reiniciar containers
docker-compose down
docker-compose up -d

# Verificar portas ocupadas
sudo netstat -tulpn | grep :3000
sudo netstat -tulpn | grep :5432
```

## 📚 Referências

### Documentação Oficial
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Ansible Documentation](https://docs.ansible.com/)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Docker Documentation](https://docs.docker.com/)
- [AWS EC2](https://docs.aws.amazon.com/ec2/)

### Conceitos DevOps
- [The DevOps Handbook](https://itrevolution.com/product/the-devops-handbook/) - Livro fundamental sobre DevOps
- [DORA Metrics](https://cloud.google.com/blog/products/devops-sre/using-the-four-keys-to-measure-your-devops-performance) - Métricas de performance DevOps
- [12 Factor App](https://12factor.net/) - Metodologia para aplicações modernas
- [Site Reliability Engineering](https://sre.google/books/) - Livros do Google sobre SRE

## 👥 Autor

**Lucas** - Projeto desenvolvido para o curso de DevOps da Avanti Bootcamp

## 📄 Licença

Este projeto é open source e está disponível sob a [MIT License](LICENSE).

---

