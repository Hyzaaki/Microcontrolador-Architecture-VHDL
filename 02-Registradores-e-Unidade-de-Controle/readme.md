# Projeto 02: Registradores e Unidade de Controle (PC)

## 📝 Descrição

Este projeto foca na modelagem e simulação de circuitos lógicos sequenciais, componentes fundamentais para a construção de processadores. Foram desenvolvidos diversos blocos de registradores e controladores de fluxo, utilizando tanto lógica concorrente quanto sequencial em **VHDL**.

## ⚙️ Componentes Desenvolvidos

O trabalho consistiu na implementação de cinco blocos independentes, essenciais para a arquitetura de um microcontrolador:

1. **W_reg:** Registrador de trabalho de 8 bits utilizado para operações lógicas e aritméticas.
2. **FSR_reg:** Registrador de seleção de arquivos, responsável pelo endereçamento indireto de memória.
3. **STATUS_reg:** Registrador de estado que armazena flags de operação como Carry (C), Digit Carry (DC) e Zero (Z).
4. **PCLATH_reg:** Registrador utilizado para armazenar os bits de alta ordem para o carregamento do contador de programa (PC).
5. **PC_reg:** Unidade de controle do Contador de Programa, gerenciando saltos, chamadas de sub-rotina (Stack Push/Pop) e incrementos simples.

## 🛠️ Ferramentas Utilizadas

* **Software:** Altera Quartus II (Versão 9.1sp2).
* **Linguagem:** VHDL (IEEE std_logic_1164).

## 📊 Simulação e Resultados

Cada bloco foi simulado individualmente no ambiente Quartus para validar sua funcionalidade:

* **Lógica Sequencial:** Uso de sinais de clock (`clk_in`) e reset para controle de estado.
* **Validação:** Testes de formas de onda (Waveforms) demonstrando o correto armazenamento de dados e a resposta às instruções de controle (como `stack_push` e `stack_pop` no PC_reg).

## 📁 Estrutura da Pasta

De acordo com os requisitos do projeto, cada bloco possui sua própria subpasta com os arquivos de fonte e simulação:

* `/W_reg`
* `/FSR_reg`
* `/STATUS_reg`
* `/PCLATH_reg`
* `/PC_reg`
* `Registradores-e-Unidade-de-Controle.pdf`: Documentação técnica completa seguindo as normas ABNT.
