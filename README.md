# terraform-passmais

Criação do ambiente do passmais na aws.

## Premissas

Antes de executar o ambiente, certifique-se de que os seguintes requisitos estão atendidos:

✅ Ter o **Terraform** instalado na máquina.  
✅ Ter o **AWS CLI** instalado e configurado com a conta da AWS que deseja utilizar.

**Links úteis:**

- [Instalação do Terraform](https://developer.hashicorp.com/terraform/install)
- [Instalação e configuração do AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-version.html)

---

Após instalar o **AWS CLI**, rode o comando abaixo e preencha os campos com as credenciais da conta **AWS**:

```bash
aws configure
```

## Instalação do Pre-commit

Para garantir a formatação e validação do código Terraform antes dos commits, instale o **pre-commit**:

```bash
sudo apt-get install pre-commit
```

Dentro do diretório do projeto, execute:

```bash
pre-commit install
```

---
## Instruções de Uso

Rode os comandos abaixo para iniciar o provisionamento da infraestrutura:

**1. Clonar o repositório:**

```bash
git clone git@github.com:Guilherme549/terraform-passmais.git
```

**2. Crie o arquivo `terraform.tfvars` e edite as variaveis conforme esta no arquivo `terraform.tfvars.example`:**

```bash
cd terraform-passmais
cp terraform.tfvars.example terraform.tfvars
```

**3. Inicializar o Terraform:**

```bash
terraform init -migrate-state 
```

**4. Validar as modificações feitas no código:**

```bash
terraform plan
```

**5. Criar o ambiente na AWS:**

```bash
terraform apply
```


---