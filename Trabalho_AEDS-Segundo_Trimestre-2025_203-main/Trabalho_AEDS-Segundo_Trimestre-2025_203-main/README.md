# Tower Defense - Trabalho Prático

## Descrição
Jogo Tower Defense desenvolvido em Processing que implementa conceitos de Teoria dos Grafos, algoritmo de Dijkstra para pathfinding e uso de Filas para gerenciamento de ondas de inimigos.

## Funcionalidades Implementadas

### Requisitos Obrigatórios ✅
- **Grid 2D**: Jogo ocorre em um grid 40x30 células
- **Algoritmo de Dijkstra**: Inimigos calculam o caminho mais curto até o núcleo
- **Fila (Queue)**: Gerenciamento das ondas de inimigos
- **Estruturas Defensivas**:
  - Parede (custo: $1) - Bloqueia completamente a passagem
  - Areia (custo: $2) - Reduz a velocidade dos inimigos pela metade
  - Torre (custo: $50) - Atira automaticamente nos inimigos próximos com tiro preciso e predição de movimento

### Mecânicas do Jogo
- **Núcleo de Energia**: Posicionado na coluna mais à esquerda
- **Spawn de Inimigos**: Surgem na coluna mais à direita
- **Sistema de Recursos**: Jogador começa com $150 e ganha recompensas que aumentam com a onda
- **Condições de Vitória/Derrota**: 
  - Vitória: Sobreviver a 20 ondas
  - Derrota: Um inimigo alcançar o núcleo
 
  - 
## Controles

### Mouse
- **Clique esquerdo**: Construir estrutura selecionada no grid

### Teclado
- **1**: Selecionar Parede
- **2**: Selecionar Areia  
- **3**: Selecionar Torre
- **ESPAÇO**: Iniciar próxima onda
- **T**: Alternar velocidade do jogo (1x/2x)
- **R**: Reiniciar jogo

## Como Jogar

1. **Preparação**: Use o mouse para construir estruturas defensivas
2. **Estratégia**: Force os inimigos a tomar caminhos mais longos
3. **Iniciar Onda**: Pressione ESPAÇO quando estiver pronto
4. **Sobrevivência**: Proteja o núcleo vermelho a qualquer custo!

## Conceitos Implementados

### Teoria dos Grafos
- Grid modelado como grafo onde cada célula é um nó
- Arestas entre nós adjacentes representam possibilidade de movimento
- Custos das arestas modificados pelas estruturas do jogador

### Algoritmo de Dijkstra
- Calcula o caminho de menor custo do spawn até o núcleo
- Recalcula automaticamente quando o jogador constrói estruturas
- Considera custos diferentes para diferentes tipos de terreno

### Estrutura de Dados - Fila
- Inimigos são enfileirados no início de cada onda
- Desenfileiramento controlado por tempo para spawn gradual
- Permite gerenciamento eficiente de múltiplas ondas

### Sistema de XP das Torres
- Torres ganham XP ao matar inimigos
- Cada inimigo morto dá 2 XP
- Torres evoluem automaticamente ao atingir XP suficiente
- Melhorias: +2 dano, +25 alcance, +0.15s taxa de tiro
- Sistema de tiro inteligente com predição de movimento

### Sistema de Tiro Inteligente
- Torres calculam a trajetória predita do inimigo
- Dano aplicado instantaneamente quando a torre atira
- Sistema 100% confiável - sem dependência de colisão
- Visualização da linha de predição em tempo real
- Algoritmo baseado em física de movimento

### Sistema de Progressão de Dificuldade
- **Vida dos Inimigos**: Aumenta 50% a cada onda
- **Recompensas**: Aumentam $2 por onda para compensar a dificuldade
- **Quantidade de Inimigos**: Mais inimigos por onda (5 + onda × 4)
- **Frequência de Tipos Especiais**: Maior chance de inimigos difíceis aparecerem

### Sistema de Paredes Danificáveis
- **Paredes Normais**: 3 pontos de vida, cor cinza
- **Paredes Danificadas**: 1 ponto de vida, cor vermelha escura
- **Dano de Inimigos**: Inimigos danificam paredes a cada 2 segundos
- **Caminho Forçado**: Sistema garante que sempre há um caminho possível

### Velocidade do Jogo
- Pressione T para alternar entre velocidade normal (1x) e rápida (2x)
- Afeta movimento de inimigos, tiros das torres e spawn de ondas

