# Projeto 03: Interfaces de I/O e Memória RAM Mapeada

## 📝 Descrição

Este projeto finaliza a implementação dos blocos periféricos do sistema, focando na comunicação externa e no armazenamento volátil de dados. Foram desenvolvidos dois módulos independentes com endereçamento específico.

## ⚙️ Componentes Desenvolvidos

### 1. Port_io (Interface de Entrada/Saída)

Módulo responsável pela interface paralela do sistema:

* **Controle de Direção:** Utilização de registradores TRIS para configurar pinos como entrada ou saída.
* **Lógica de Latch:** Implementação de travas para garantir a estabilidade dos dados de saída.
* **Estado de Alta Impedância:** Saídas configuradas com Tri-state quando desabilitadas.

### 2. RAM_mem (Memória de Acesso Aleatório)

Módulo de memória organizada em bancos mapeados:

* **Capacidade:** Implementação de bancos de 80 bytes (memo, mem1, mem2) e área comum (mem_com).
* **Endereçamento:** Mapeamento específico via barramento `abus_in` (ex: 20h a 6Fh para memo).
* **Operações:** Leitura combinacional e escrita síncrona controladas pelos sinais `rd_en` e `wr_en`.

## 📊 Ferramentas e Requisitos

* **Software:** Altera Quartus II 9.1sp2.
* **Importante:** O uso desta versão específica é mandatório para a correta síntese e simulação funcional do projeto.

## 📁 Arquivos na Pasta

* `/Port_io`: Código fonte e arquivos Quartus da interface de I/O.
* `/RAM_mem`: Código fonte e arquivos Quartus da memória RAM.
* `IO-RAM.pdf`: Documentação com diagramas equivalentes e resultados de simulação.
