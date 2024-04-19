# Trace-Based Testing Utils

Este repositório é responsável por buildar o objeto de estudo e configurá-lo de acordo com o cenário que se deseja testar. Para facilitar a reprodutibilidade e automatizar os processos de configuração do ambiente, foram criados alguns comandos no `Makefile` deste repositório.

## Como utilizar:

Primeiramente deve-se baixar todas as dependências através do comando `make install-dependencies`. Após isso, é possível utilizar o comando `make` na raíz do atual repositório para visualizar os comandos disponíveis.

### Buildar objeto de estudo:

```sh
## Builda o objeto de estudo para uso no Cenário 1
make build-first

## Builda o objeto de estudo para uso no Cenário 2
make build-second

## Builda o objeto de estudo para uso no Cenário 1, contendo os ajustes para o funcionamento da ferramenta Malabi
make build-first-malabi

## Builda o objeto de estudo para uso no Cenário 2, contendo os ajustes para o funcionamento da ferramenta Malabi
make build-second-malabi
```

> **Obs.:** A descrição dos cenários pode ser encontrada no repositório [tbt-tools](https://github.com/GabrielFVieira/tbt-tools)

### Criar cluster:

O comando abaixo irá realizar as seguintes ações:
- Criar o cluster Kubernetes utilizando o [Kind](https://kind.sigs.k8s.io/);
- Carregar as imagens docker do objeto de estudo para o Cenário 1;
- Instalar o objeto de estudo;
- Instalar o servidor do Tracetest, uma das ferramentas a ser analisada.

```sh
make cluster-kind-create
```
