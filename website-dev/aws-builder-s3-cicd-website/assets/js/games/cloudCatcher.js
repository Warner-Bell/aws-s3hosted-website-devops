export function startCloudCatcher() {
    const gameContainer = document.getElementById('cloud-catcher');
    gameContainer.innerHTML = `
        <h3>Cloud Catcher Game</h3>
        <div id="cloud-catcher-game" aria-live="polite"></div>
        <div id="cloud-catcher-score">Score: 0</div>
        <div id="cloud-catcher-timer">Time: 30s</div>
        <button id="start-game" aria-label="Start Cloud Catcher Game">Start Game</button>
    `;

    const game = document.getElementById('cloud-catcher-game');
    let score = 0;
    let timeLeft = 30;
    let cloudInterval;
    let gameStarted = false;

    // Create cloud elements with better performance and smoother animations
    function createCloud() {
        const cloud = document.createElement('div');
        cloud.classList.add('cloud');
        cloud.setAttribute('role', 'button'); // Cloud is interactive, making it accessible
        cloud.setAttribute('aria-label', 'Catch the cloud');
        cloud.style.left = Math.random() * (game.clientWidth - 50) + 'px';
        cloud.style.top = '0px';
        game.appendChild(cloud);

        const fallSpeed = Math.random() * 2 + 1;
        
        function fall() {
            const currentTop = parseInt(cloud.style.top);
            if (currentTop < game.clientHeight) {
                cloud.style.top = (currentTop + fallSpeed) + 'px';
                requestAnimationFrame(fall);
            } else {
                cloud.remove();
            }
        }

        fall();

        cloud.addEventListener('click', () => {
            score++;
            updateScore();
            cloud.remove();
            // Add visual feedback on click
            const effect = document.createElement('span');
            effect.className = 'cloud-click-effect';
            cloud.appendChild(effect);
        });

        // Allow keyboard to "catch" clouds as well
        cloud.addEventListener('keydown', (e) => {
            if (e.key === 'Enter' || e.key === ' ') {
                score++;
                updateScore();
                cloud.remove();
            }
        });
    }

    function updateScore() {
        const scoreElement = document.getElementById('cloud-catcher-score');
        scoreElement.textContent = `Score: ${score}`;
    }

    function updateTimer() {
        const timerElement = document.getElementById('cloud-catcher-timer');
        timerElement.textContent = `Time: ${timeLeft}s`;
    }

    function endGame() {
        clearInterval(cloudInterval);
        game.innerHTML = `<h3>Game Over!</h3><p>Your final score: ${score}</p>`;
        // Dispatch custom event
        const gameCompletedEvent = new CustomEvent('gameCompleted', {
            detail: { score: score, time: 30 - timeLeft }
        });
        document.dispatchEvent(gameCompletedEvent);
        gameStarted = false;
    }

    // Countdown before the game starts
    function startCountdown() {
        let countdown = 3;
        const countdownElement = document.createElement('div');
        countdownElement.id = 'countdown';
        gameContainer.appendChild(countdownElement);
        const countdownInterval = setInterval(() => {
            countdownElement.textContent = `Starting in ${countdown}...`;
            countdown--;
            if (countdown < 0) {
                clearInterval(countdownInterval);
                countdownElement.remove();
                startGame();
            }
        }, 1000);
    }

    function startGame() {
        if (gameStarted) return;
        gameStarted = true;

        // Initialize score and timer
        score = 0;
        timeLeft = 30;
        updateScore();
        updateTimer();

        // Start cloud generation and timer
        cloudInterval = setInterval(createCloud, 1000);

        const timer = setInterval(() => {
            timeLeft--;
            updateTimer();
            if (timeLeft <= 0) {
                clearInterval(timer);
                endGame();
            }
        }, 1000);
    }

    // Event listener to start the game
    const startButton = document.getElementById('start-game');
    startButton.addEventListener('click', startCountdown);
}
