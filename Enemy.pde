class Enemy {
    private PVector position;
    private PVector gridPosition;
    private List<PVector> path;
    private int pathIndex;
    private int health;
    private int maxHealth;
    private float speed;
    private float moveTimer;
    private float moveDelay;
    private EnemyType type;
    private float wallDamageTimer;
    private float wallDamageDelay;
    
        Enemy(EnemyType type, PVector spawnPosition) {
        this.type = type;
        this.position = new PVector(spawnPosition.x * CELL_SIZE + CELL_SIZE/2, 
                                    spawnPosition.y * CELL_SIZE + CELL_SIZE/2);
        this.gridPosition = spawnPosition.copy();
        this.path = new ArrayList<>();
        this.pathIndex = 0;
        
        int waveNumber = gameState.getCurrentWave();
        float healthMultiplier = 1.0f + (waveNumber - 1) * 0.5f;
        
        switch (type) {
            case FAST:
                this.maxHealth = (int)(20 * healthMultiplier);
                this.speed = 20f;
                this.moveDelay = 0.2f;
                break;
            case Dragao:
                this.maxHealth = (int)(25 * healthMultiplier);
                this.speed = 19f;
                this.moveDelay = 0f;
                break;
            case DragaoArm:
                this.maxHealth = (int)(50 * healthMultiplier);
                this.speed = 7f;
                this.moveDelay = 0.8f;
                break;
            case TANK:
                this.maxHealth = (int)(200 * healthMultiplier);
                this.speed = 3f;
                this.moveDelay = 1.2f;
                break;
            default:
                this.maxHealth = (int)(25 * healthMultiplier);
                this.speed = 10f;
                this.moveDelay = 1f;
                break;
        }
        
        this.health = maxHealth;
        this.moveTimer = 0;
        this.wallDamageTimer = 0;
        this.wallDamageDelay = 2.0f;
    }
    
    void update() {
        moveTimer += speed * 0.016f * gameSpeed;
        wallDamageTimer += 0.016f * gameSpeed;
        
        if (moveTimer >= moveDelay && pathIndex < path.size() - 1) {
            moveToNextPathPoint();
            moveTimer = 0;
        }
        
        checkWallDamage();
    }
    
    private void checkWallDamage() {
        if (wallDamageTimer >= wallDamageDelay) {
            PVector currentPos = getGridPosition();
            if (gameGrid.isWallAt((int)currentPos.x, (int)currentPos.y)) {
                gameGrid.damageWall((int)currentPos.x, (int)currentPos.y);
            }
            wallDamageTimer = 0;
        }
    }
    
    private void moveToNextPathPoint() {
        pathIndex++;
        PVector nextGridPos = path.get(pathIndex);
        gridPosition = nextGridPos.copy();
        position = new PVector(nextGridPos.x * CELL_SIZE + CELL_SIZE/2, 
                              nextGridPos.y * CELL_SIZE + CELL_SIZE/2);
    }
    
    void setPath(List<PVector> newPath) {
        this.path = new ArrayList<>(newPath);
        this.pathIndex = 0;
    }
    
    void takeDamage(int damage) {
        health -= damage;
    }
    
    boolean isDead() {
        return health <= 0;
    }
    
    boolean hasReachedCore() {
        return pathIndex >= path.size() - 1 && 
               gridPosition.dist(gameGrid.getCorePosition()) < 1.0f;
    }
    
    PVector getPosition() {
        return position;
    }
    
    PVector getGridPosition() {
        return gridPosition;
    }
    
    int getHealth() {
        return health;
    }
    
    int getMaxHealth() {
        return maxHealth;
    }
    
    EnemyType getType() {
        return type;
    }
    
    List<PVector> getPath() {
        return path;
    }
    
    int getPathIndex() {
        return pathIndex;
    }
    
    float getSpeed() {
        return speed;
    }
    
    float getMoveDelay() {
        return moveDelay;
    }
    
    void display() {
        float size = CELL_SIZE * 0.8f;
        
        switch (type) {
            case FAST:                                                   /////////////////////////
                fill(0, 250, 100);
                image(fantasma, position.x,position.y, size*3, size*2);
                break;
            case Dragao:
                fill(0, 155, 255);
                image(dragao, position.x,position.y, size*4, size*3);
                break;
            case DragaoArm:
                fill(0, 250, 0);
                image(dragaobranco, position.x,position.y, size*6, size*5);                                              
                break;
            case TANK:
                size = CELL_SIZE * 1.2f;
                fill(0, 0, 255);
                image(dragaoarm, position.x,position.y, size*6, size*5);
                break;
            default:                                                  //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                fill(0, 155, 255);
                image(dragao, position.x,position.y, size*6, size*5);
                break;
        }
        
        displayHealthBar();
    }
    
    private void displayHealthBar() {
        float barWidth = CELL_SIZE * 0.6f;
        float barHeight = 4;
        float barX = position.x - barWidth/2;
        float barY = position.y - CELL_SIZE/2 - 8;
        
        fill(255, 0, 0);
        rect(barX, barY, barWidth, barHeight);
        
        float healthPercent = (float)health / maxHealth;
        fill(0, 255, 0);
        rect(barX, barY, barWidth * healthPercent, barHeight);
    }
}

enum EnemyType {
    NORMAL,
    FAST,
    Dragao,
    DragaoArm,
    TANK
}
