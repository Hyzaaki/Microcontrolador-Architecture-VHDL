# Projeto 01: Unidade Lógica Aritmética (ULA) e Multiplexador de Endereços

## 📝 Descrição

Este projeto consiste no desenvolvimento de dois circuitos digitais fundamentais utilizando a linguagem de descrição de hardware **VHDL**. Ambos os projetos foram implementados de forma totalmente **combinacional**, utilizando exclusivamente lógica concorrente e sem elementos de armazenamento (latches ou flip-flops).

## ⚙️ Circuitos Desenvolvidos

### 1. Multiplexador de Endereços (addr_mux)

Um multiplexador com saída de 9 bits responsável pela seleção de endereçamento:

* **Endereçamento Indireto:** Concatenação de `irp_in` e `ind_addr_in` (quando `dir_addr_in` é nulo).
* **Endereçamento Direto:** Concatenação de `rp_in` e `dir_addr_in`.
* **Saída:** `abus_out[8..0]`.

### 2. Unidade Lógica Aritmética (ALU)

Uma ULA robusta de 8 bits capaz de realizar **16 operações distintas**, selecionadas através de um OPCODE de 4 bits.

* **Operações Lógicas:** AND, OR, XOR, COM (Complemento), CLR (Limpar).
* **Operações Aritméticas:** Soma (ADD), Subtração (SUB), Incremento (INC), Decremento (DEC).
* **Manipulação de Bits:** Bit Set (BS), Bit Clear (BC), Permuta de Nibbles (SWAP).
* **Rotações:** Rotação para direita (RR) e esquerda (RL) passando pelo Carry.
* **Flags de Saída:** Carry out (C), Digit Carry (DC) e Zero (Z).

## 🛠️ Ferramentas Utilizadas

* **Software:** Altera Quartus II (Versão 9.1sp2).
* **Linguagem:** VHDL (IEEE Standard Logic 1164).

## 📊 Metodologia e Simulação

O projeto seguiu uma abordagem estruturada:

1. **Descrição VHDL:** Implementação das entidades e arquiteturas baseada em lógica concorrente.
2. **Simulação Funcional:** Verificação dos resultados através de formas de onda (Waveforms) no Quartus, validando cada operação lógica e aritmética conforme as tabelas de verdade.

## 📁 Estrutura da Pasta

* `/ALU`: Arquivos fonte e projeto da Unidade Lógica Aritmética.
* `/Multiplexador`: Arquivos fonte e projeto do Multiplexador `addr_mux`.
* `ALU-Mux-de-Enderecos.pdf`: Documentação detalhada contendo diagramas, códigos e capturas das simulações.
