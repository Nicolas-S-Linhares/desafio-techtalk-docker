## Desafio TechTalk

Um dev pede sua ajuda com um projeto simples que ele está trabalhando. Se trata de uma aplicação web que se conecta a um banco de dados MySQL.

Ele está tentando colocar no ar via Docker uma página PHP que exibe "Hello World" e o número de visitantes.
O contador é atualizado em um container de banco de dados.

O código já está pronto, mas ele não consegue fazer o container subir via `docker compose up --build -d`

Ah, originalmente o projeto era em node, mas foi alterado para PHP!

Ajude o pobre dev.

## Regras

- Nenhum arquivo no diretório `src` deve ser modificado (a página php funciona como ela está)
- Os arquivos `Dockerfile` e `docker-compose.yml` contém erros e más práticas. Quem fizer as melhores correções ganha o prêmio.

Faça um clone do projeto e depois faça um pull request da sua solução no repositório original até 2024-05-06 às 11:00 (UTF -03:00). Boa sorte!

### Critérios de Avaliação

- Site funcional
- Tempo de build
- Tamanho da imagem

## Dicas

- **Sem Código**: Você não precisa entender de programação PHP para fazer essa aplicação funcionar
- **Pacotes Desnecessários**: Nem todos os pacotes que são instalados são necessários. Avalie quais extensões PHP realmente precisam ser instaladas.
- **Variáveis de Ambiente**: Verifique se as variáveis de ambiente estão sendo passadas da melhor forma e funcionando corretamente. Use `docker compose config` para ver como as variáveis estão sendo interpretadas.
- **Conexão com o Banco**: Certifique-se de que as configurações de conexão com o banco estão corretas e que o webapp pode se comunicar com o MySQL.
- **Rede Docker**: As configurações de rede estão corretas? Utilize `docker network inspect <network_name>` para ver como os containers estão conectados.
- **Processo de Build**: Comece por um `docker compose build` seguido de um `docker compose up -d` e observe os logs para entender quaisquer falhas (sim, o tempo de build é bem alto).
- **Otimização**: Após fazer o site funcionar, otimize o Dockerfile.
- **Arquivos SRC**: Será que o diretório src precisa ser todo copiado para a imagem no Dockerfile? Avalie o uso de `.dockerignore` para excluir arquivos desnecessários.
- **Recursos Úteis**:
  - [Melhores Práticas Dockerfile](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
  - [Referência da Instrução RUN](https://docs.docker.com/engine/reference/builder/#run)
  - [Instrução COPY](https://docs.docker.com/engine/reference/builder/#copy)

## Comandos Úteis de Docker

### Comandos Básicos de Docker Compose:

- `docker compose up`: Constrói e inicia containers para um serviço.
- `docker compose up -d`: Inicia os containers em segundo plano.
- `docker compose down`: Para e remove recursos (containers, redes, etc.).
- `docker compose build`: Constrói ou reconstrói serviços definidos no docker-compose.yml.

### Gerenciamento e Inspeção:

- `docker compose ps`: Lista os containers.
- `docker compose logs <serviço>`: Visualiza os outputs dos containers.
- `docker compose stop <serviço>`: Para serviços.
- `docker compose restart <serviço>`: Reinicia serviços.
- `docker compose config`: Valida e visualiza o arquivo Compose.

### Interação e Depuração:

- `docker compose exec -it <serviço> bash`: Entra no container do serviço com um shell bash.
- `docker compose run <serviço> <comando>`: Executa um comando único para um serviço.
- `docker compose top <serviço>`: Exibe os processos em execução nos containers do serviço.

### Utilidades:

- `docker compose pause <serviço>`: Pausa serviços.
- `docker compose unpause <serviço>`: Despausa serviços.
- `docker compose pull`: Baixa as imagens dos serviços.