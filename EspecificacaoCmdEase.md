
# Especificação de Requisitos - Aplicativo CmdEase

## Descrição Geral

CmdEase é um aplicativo de bloco de notas avançado que permite ao usuário salvar e executar comandos de terminal diretamente de cada nota. O aplicativo é destinado ao Linux e macOS, oferecendo suporte a múltiplos diretórios de execução e mantendo um histórico de execuções em um banco de dados local.

## Funcionalidades Principais

1. **Cadastro, Edição e Exclusão de Notas de Comando**:
   - Cada nota deve ter um título, uma descrição e uma lista de comandos.
   - É possível adicionar, editar e remover notas e comandos dentro delas.
   - Cada nota deve permitir a seleção de um ou mais caminhos de execução.
   - O usuário pode excluir uma nota de forma permanente e editar suas informações.

2. **Gerenciamento de Caminhos de Execução**:
   - O usuário pode adicionar, editar e remover diretórios onde os comandos podem ser executados.
   - O caminho selecionado é onde o comando atual será executado, e o usuário pode selecionar o caminho antes da execução.
   - Caso nenhum caminho seja selecionado, o comando deve ser executado no diretório raiz do sistema.

3. **Execução de Comandos**:
   - O aplicativo deve ter um botão que permita executar os comandos listados em cada nota.
   - Antes da execução, o usuário deve selecionar um caminho de execução da lista disponível ou optar por executar no diretório raiz.
   - Cada comando dentro de uma nota deve ter um botão de "play" individual, permitindo execução específica para aquele comando.

4. **Histórico de Execuções**:
   - O aplicativo deve armazenar o histórico de execuções em um banco de dados local.
   - Cada execução deve registrar o comando executado, o caminho utilizado e a saída ou erro resultante.
   - O histórico deve ser consultável, permitindo que o usuário acesse detalhes das execuções passadas.

5. **Layout do Bloco de Notas**:
   - O aplicativo deve incluir um layout de bloco de notas editável onde cada nota de comando é apresentada de forma clara e organizada.
   - Cada comando dentro de uma nota é exibido como um item individual com o título, descrição e o próprio comando.
   - **Botão de Execução Individual**: Cada comando possui um botão de "play" ao lado para execução individual.
   - O usuário pode editar o conteúdo do bloco de notas diretamente, incluindo comandos, título e descrição.

## Entradas e Saídas

### Entradas

- **Nota**:
  - **Título** (String): Descrição curta da nota.
  - **Descrição** (String): Explicação detalhada da nota ou contexto dos comandos.
  - **Comandos** (Lista de Strings): Lista de comandos de terminal a serem executados.

- **Caminho de Execução**:
  - **Diretório** (String): Caminho absoluto do diretório onde os comandos serão executados.
  - **Seleção de Caminho**: Escolha do caminho específico de execução no momento da execução. Caso não seja selecionado, o comando é executado no diretório raiz.

### Saídas

- **Resultado da Execução**:
  - **Saída do Comando** (String): Retorno do terminal ao executar cada comando.
  - **Mensagens de Erro** (String): Feedback de erro, caso o comando falhe.

- **Histórico de Execuções**:
  - **Registro de Execução**: Histórico detalhado das execuções contendo:
    - Data e hora da execução.
    - Comando executado.
    - Caminho utilizado (ou diretório raiz, caso não tenha sido selecionado um caminho).
    - Saída ou erro resultante.

## Critérios de Aceite

1. **Cadastro, Edição e Exclusão de Notas de Comando**:
   - [ ] O aplicativo permite a criação de notas com título, descrição e uma lista de comandos.
   - [ ] O usuário pode editar e remover comandos dentro de cada nota.
   - [ ] Cada nota aceita múltiplos comandos e está associada a um título e descrição.
   - [ ] O usuário pode excluir notas permanentemente e editar suas informações.

2. **Gerenciamento de Caminhos de Execução**:
   - [ ] O aplicativo permite ao usuário cadastrar múltiplos caminhos de execução.
   - [ ] O usuário pode editar ou excluir qualquer caminho cadastrado.
   - [ ] Caso nenhum caminho seja selecionado, o comando é executado no diretório raiz.

3. **Execução de Comandos**:
   - [ ] O usuário pode selecionar um caminho de execução antes de executar os comandos.
   - [ ] A saída da execução de cada comando é exibida para o usuário.
   - [ ] Mensagens de erro são exibidas, caso um comando falhe.
   - [ ] Cada comando possui um botão de "play" individual para execução específica.

4. **Histórico de Execuções**:
   - [ ] Cada execução de comando é registrada no banco de dados local.
   - [ ] O usuário pode consultar o histórico das execuções passadas, visualizando detalhes como comando, saída e caminho utilizado.

5. **Layout do Bloco de Notas**:
   - [ ] Cada nota exibe o título, descrição e uma lista de comandos com um botão de "play" individual para cada comando.
   - [ ] O usuário pode editar o título, descrição e comandos diretamente no bloco de notas.
