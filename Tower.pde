class Tower {
    private PVector position;
    private float range;
    private float fireRate;
    private float fireTimer;
    private int damage;
    private int level;
    private float accuracy;
    private int xp;
    private int xpToNextLevel;
    
    Tower(float x, float y) {
        this.position = new PVector(x, y);
        this.range = 120;
        this.fireRate = 0.8f;
        this.fireTimer = 0;
        this.damage = 5;
        this.level = 1;
        this.xp = 0;
        this.xpToNextLevel = 10;
    }
    
    void update(List<Enemy> enemies) {
        fireTimer += 0.016f * gameSpeed;
    }
    
    boolean canShoot() {
        return fireTimer >= fireRate;
    }
    
    Enemy findTarget(List<Enemy> enemies) {
        Enemy bestTarget = null;
        float bestDistance = Float.MAX_VALUE;
        
        for (Enemy enemy : enemies) {
            float distance = position.dist(enemy.getPosition());
            if (distance <= range && distance < bestDistance) {
                bestTarget = enemy;
                bestDistance = distance;
            }
        }
        
        return bestTarget;
    }
    
    Projectile shoot(Enemy target) {
        fireTimer = 0;
        return new Projectile(position.copy(), target, damage);
    }
    
    void upgrade() {
        level++;
        damage += 2;
        range += 25;
        fireRate = max(0.3f, fireRate - 0.15f);
        xpToNextLevel = level * 15;
    }
    
    void addXP(int amount) {
        xp += amount;
        if (xp >= xpToNextLevel) {
            upgrade();
            xp = 0;
        }
    }
    
    void display() {
        fill(50, 50, 150);
        rect(position.x - 8, position.y - 8, 16, 16);                            //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
          
          
         int nivel = level; // supondo que tenha um array com nível
              PImage torreAtual = null;
              if (nivel == 1) torreAtual = torre2;
              if (nivel == 2) torreAtual = torre3;
              if (nivel == 3) torreAtual = torre4;
              if (nivel == 4) torreAtual = torre5;
              if (nivel >= 5) torreAtual = torre6;

              if (torreAtual != null) {
                imageMode(CENTER);
                image(torreAtual, position.x, position.y, 170, 75);}
          
          
        fill(0, 0, 0, 30);
        ellipse(position.x, position.y, range * 2, range * 2);
        
        fill(255, 0, 0);
        textAlign(CENTER, CENTER);
        textSize(20);
        text("Lv." + level, (position.x), (position.y-45));
        
        displayXPBar();
    }
    
    private void displayXPBar() {
        float barWidth = 30;
        float barHeight = 5;
        float barX = (position.x - barWidth/2);
        float barY = position.y + 12 + 15 +10;
        
        fill(100, 100, 100);
        rect(barX, barY, barWidth, barHeight);
        
        float xpPercent = (float)xp / xpToNextLevel;
        fill(0, 255, 255);
        rect(barX, barY, barWidth * xpPercent, barHeight);
    }
    
    PVector getPosition() {
        return position;
    }
    
    int getLevel() {
        return level;
    }
    
    int getDamage() {
        return damage;
    }
    
    float getRange() {
        return range;
    }
    
    float getFireRate() {
        return fireRate;
    }
    

    
    int getXP() {
        return xp;
    }
    
    int getXPToNextLevel() {
        return xpToNextLevel;
    }
}
