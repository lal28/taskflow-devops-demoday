# Apresentação TaskFlow DevOps

**Equipe:**
- Lucas Araujo Lopes
- Dryelli Vitoria Martins de Freitas
- Hericlys Luiz Tavares de Sá

---

## Ferramentas Utilizadas

- WSL
- VSCode
- Docker Desktop
- GitHub
- AWS

---

## Estrutura da Aplicação

Cada ferramenta DevOps está em seu próprio diretório:

```
taskflow-devops/
├── app/           → Aplicação
├── terraform/     → Infraestrutura
├── ansible/       → Automação
└── .github/       → Pipeline CI/CD
```

---

## 1. A Aplicação

API REST de To-Do List em Node.js

### Dockerfile

Tudo containerizado. Essa imagem Docker garante que o ambiente é idêntico em qualquer lugar.


---

## 2. Terraform - Infrastructure as Code

Ao invés de criar manualmente na AWS, escrevemos código.

---

## 3. Ansible - Configuration Management


### Deploy automático:
1. Copia os arquivos
2. Faz build da imagem Docker
3. Sobe PostgreSQL
4. Sobe a aplicação
5. Testa se funcionou

---

## 4. GitHub Actions - Pipeline CI/CD

### Três etapas:
1. **Test** - Valida qualidade do código
2. **Build** - Constrói imagem Docker
3. **Deploy** - Deploy automático na AWS

---

## Fechamento

**Fluxo completo:**

```
Git (código versionado)
  ↓
Terraform (infraestrutura automática)
  ↓
Ansible (configuração automática)
  ↓
GitHub Actions (deploy automático)
  ↓
Produção funcionando! ✅
```
**De 14 dias para 5 minutos** ⚡  
**De 40% falha para <5%** 📈  
**De caos para controle** 🎯

---

```
        ⭐ Obrigado por tudo!!! ⭐
```

**Equipe:**
- Lucas Araujo Lopes
- Dryelli Vitoria Martins de Freitas  
- Hericlys Luiz Tavares de Sá

```
┌─────────────────────────────────────────────────────────┐
│  💻 Código  →  ☁️  Cloud  → 🔄 Automação → ✅ Deploy  │
└─────────────────────────────────────────────────────────┘
```

---

<sub>Projeto desenvolvido para o curso DevOps - Avanti Bootcamp 2025</sub>


