enum StructureType {
    WALL,
    SAND,
    TOWER
}

class UI {
    private StructureType selectedStructure;
    private final int WALL_COST = 1;
    private final int SAND_COST = 2;
    private final int TOWER_COST = 50;

    UI() {
        selectedStructure = StructureType.WALL;
    }

    void selectStructure(StructureType type) {
        selectedStructure = type;
    }

    void handleGridClick(int gridX, int gridY) {
        if (gameGrid.canBuildAt(gridX, gridY)) {
            int cost = getStructureCost(selectedStructure);

            if (player.canAfford(cost)) {
                gameGrid.buildStructure(gridX, gridY, selectedStructure);
                player.spendMoney(cost);
            }
        }
    }

    private int getStructureCost(StructureType type) {
        switch (type) {
            case WALL:  return WALL_COST;
            case SAND:  return SAND_COST;
            case TOWER: return TOWER_COST;
            default:    return 0;
        }
    }

    void display() {
        displayStructurePanel();
        displayGameSpeed();
        displayInstructions();
        player.display();
        waveManager.display();
    }

    // --- Estruturas ---
    private void displayStructurePanel() {
        float panelX = 10;
        float panelY = height - 150;
        float buttonWidth = 90;
        float buttonHeight = 35;

        // Caixa de fundo
        fill(40, 40, 40, 200);
        noStroke();
        rect(panelX, panelY, 280, 130, 15);

        // Título
        fill(255);
        textAlign(LEFT, TOP);
        textSize(14);
        text("⚒ Estruturas", panelX + 10, panelY + 8);

        // Botões principais
        displayStructureButton(" Parede ($" + WALL_COST + ")", panelX + 10, panelY + 35, 
                               StructureType.WALL, buttonWidth, buttonHeight);
        displayStructureButton(" Areia ($" + SAND_COST + ")", panelX + 105, panelY + 35, 
                               StructureType.SAND, buttonWidth, buttonHeight);
        displayStructureButton(" Torre ($" + TOWER_COST + ")", panelX + 200, panelY + 35, 
                               StructureType.TOWER, buttonWidth, buttonHeight);

        // Atalhos
        textSize(12);
        fill(200);
        text("Atalhos: 1=Parede  |  2=Areia  |  3=Torre", panelX + 100, panelY + 85);
    }

    private void displayStructureButton(String text, float x, float y, StructureType type, float w, float h) {
        if (selectedStructure == type) {
            fill(100, 180, 255);   // cor destacada
            stroke(255);
            strokeWeight(2);
        } else {
            fill(80, 80, 80);
            noStroke();
        }

        rect(x, y, w, h, 8); // botões arredondados

        fill(255);
        textAlign(CENTER, CENTER);
        textSize(12);
        text(text, x + w/2, y + h/2);
    }

    // --- Velocidade ---
    private void displayGameSpeed() {
        float panelX = width - 180;
        float panelY = height - 80;

        fill(40, 40, 40, 200);
        noStroke();
        rect(panelX, panelY, 170, 60, 12);

        fill(255);
        textAlign(CENTER, TOP);
        textSize(14);
        text("⏩ Velocidade: " + (gameSpeed == 1.0f ? "1x" : "2x"), panelX + 85, panelY + 8);

        textSize(11);
        fill(200);
        text("Pressione T para alternar", panelX + 85, panelY + 30);
    }

    // --- Instruções ---
    private void displayInstructions() {
        fill(255);
        textAlign(CENTER, BOTTOM);
        textSize(12);
        text("Clique no grid para construir • Proteja o bau • ESPAÇO = iniciar ondas", 
             width/2, height - 10);
    }

    StructureType getSelectedStructure() {
        return selectedStructure;
    }
}
