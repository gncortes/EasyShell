# Tarefas Detalhadas para o CmdEase

## 1. Cadastro, Edição e Exclusão de Notas de Comando

### 1.1 Implementar criação de notas com título, descrição e lista de comandos

- **Cenário de Entrada**
  - Título preenchido, descrição opcional e pelo menos um comando válido na lista.

- **Cenário de Saída**
  - Nova nota é salva no banco de dados com os campos de título, descrição e lista de comandos.

- **Critérios de Aceite**
  - [ ] A criação de uma nova nota deve salvar corretamente no banco de dados.
  - [ ] O aplicativo deve exibir mensagem de erro caso o título ou comando estejam ausentes.
  - [ ] Após salvar, a nota aparece na lista de notas.

### 1.2 Implementar edição de notas (modificação de título, descrição e comandos)

- **Cenário de Entrada**
  - Nota existente com alterações nos campos de título, descrição ou lista de comandos.

- **Cenário de Saída**
  - Atualização correta dos dados no banco de dados e exibição das alterações na interface.

- **Critérios de Aceite**
  - [ ] As mudanças feitas na UI devem refletir no banco de dados.
  - [ ] O aplicativo deve exibir mensagem de erro se o título ou comando estiverem vazios.
  - [ ] A nota atualizada deve ser exibida corretamente na lista de notas.

### 1.3 Implementar exclusão de notas

- **Cenário de Entrada**
  - Seleção de uma nota para exclusão e confirmação pelo usuário.

- **Cenário de Saída**
  - Nota removida permanentemente do banco de dados e da interface.

- **Critérios de Aceite**
  - [ ] A nota deve ser removida do banco de dados e da lista de notas.
  - [ ] Um diálogo de confirmação deve aparecer antes da exclusão.
  - [ ] A lista de notas deve atualizar automaticamente após a exclusão.


## 2. Gerenciamento de Caminhos de Execução

### 2.1 Criar interface para adicionar e editar diretórios de execução

- **Cenário de Entrada**
  - Novo caminho de execução ou edição de um caminho existente.

- **Cenário de Saída**
  - Caminho novo ou atualizado salvo no banco de dados e exibido na interface.

- **Critérios de Aceite**
  - [ ] O aplicativo permite adicionar um novo caminho ou editar um existente.
  - [ ] O caminho é salvo corretamente no banco de dados.
  - [ ] O aplicativo exibe uma mensagem de erro se o caminho estiver vazio ou inválido.

### 2.2 Implementar lógica de exclusão de diretórios

- **Cenário de Entrada**
  - Seleção de um caminho para exclusão e confirmação pelo usuário.

- **Cenário de Saída**
  - Caminho removido permanentemente do banco de dados e da interface.

- **Critérios de Aceite**
  - [ ] O caminho é removido do banco de dados e da interface.
  - [ ] Um diálogo de confirmação deve aparecer antes da exclusão.
  - [ ] A lista de caminhos deve atualizar automaticamente após a exclusão.

### 2.3 Implementar seleção do diretório de execução, com opção de executar no diretório raiz caso nenhum seja selecionado

- **Cenário de Entrada**
  - Seleção de um caminho específico ou escolha de executar no diretório raiz.

- **Cenário de Saída**
  - O comando é executado no caminho escolhido ou no diretório raiz.

- **Critérios de Aceite**
  - [ ] A execução do comando considera o caminho selecionado, ou o diretório raiz se nenhum for escolhido.
  - [ ] A interface reflete a seleção atual do caminho.
  - [ ] Mensagem de erro caso o caminho selecionado seja inválido.
