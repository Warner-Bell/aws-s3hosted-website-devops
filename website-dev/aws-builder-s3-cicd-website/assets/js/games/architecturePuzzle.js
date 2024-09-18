export function startArchitecturePuzzle() {
    const gameContainer = document.getElementById('architecture-puzzle');
    gameContainer.innerHTML = `
        <h3>Cloud Architecture Puzzle</h3>
        <div id="architecture-puzzle-game"></div>
        <div id="architecture-puzzle-score">Score: 0</div>
        <div id="architecture-puzzle-timer">Time: 60s</div>
        <button id="start-puzzle" aria-label="Start Cloud Architecture Puzzle Game">Start Game</button>
    `;
    
    const game = document.getElementById('architecture-puzzle-game');
    const architectureComponents = [
        'Web Server',
        'Application Server',
        'Database',
        'Load Balancer',
        'CDN',
        'Storage',
        'Cache',
        'Message Queue'
    ];

    let score = 0;
    let timeLeft = 60;
    let puzzleInterval;
    let gameStarted = false;

    // Function to shuffle array (used for randomizing components)
    function shuffleArray(array) {
        for (let i = array.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [array[i], array[j]] = [array[j], array[i]];
        }
    }

    // Function to create the puzzle layout
    function createPuzzle() {
        const shuffledComponents = [...architectureComponents];
        shuffleArray(shuffledComponents);

        let html = '<div class="component-container" role="list">';

        shuffledComponents.forEach(component => {
            html += `<div class="component" draggable="true" tabindex="0" data-component="${component}" role="listitem" aria-label="${component}">${component}</div>`;
        });

        html += '</div><div class="architecture-diagram">';
        for (let i = 0; i < architectureComponents.length; i++) {
            html += `<div class="diagram-slot" data-slot="${i}" role="gridcell" aria-label="Drop ${architectureComponents[i]} here"></div>`;
        }
        html += '</div>';

        game.innerHTML = html;

        const components = game.querySelectorAll('.component');
        const slots = game.querySelectorAll('.diagram-slot');

        components.forEach(component => {
            component.addEventListener('dragstart', dragStart);
            component.addEventListener('keydown', keyboardDrag);
        });

        slots.forEach(slot => {
            slot.addEventListener('dragover', dragOver);
            slot.addEventListener('drop', drop);
            slot.addEventListener('keydown', keyboardDrop);
        });
    }

    // Drag and Drop Functions
    function dragStart(e) {
        e.dataTransfer.setData('text/plain', e.target.dataset.component);
    }

    function dragOver(e) {
        e.preventDefault();
    }

    function drop(e) {
        e.preventDefault();
        const componentName = e.dataTransfer.getData('text');
        const component = document.querySelector(`[data-component="${componentName}"]`);
        e.target.appendChild(component);
        checkArchitecture();
    }

    // Keyboard Drag-and-Drop Functions
    function keyboardDrag(e) {
        if (e.key === 'Enter' || e.key === ' ') {
            e.target.classList.add('selected');
            game.dataset.selectedComponent = e.target.dataset.component;
        }
    }

    function keyboardDrop(e) {
        if (e.key === 'Enter' || e.key === ' ') {
            const selectedComponent = game.dataset.selectedComponent;
            if (selectedComponent) {
                const component = document.querySelector(`[data-component="${selectedComponent}"]`);
                e.target.appendChild(component);
                component.classList.remove('selected');
                game.dataset.selectedComponent = '';
                checkArchitecture();
            }
        }
    }

    // Check if components are placed correctly
    function checkArchitecture() {
        const slots = game.querySelectorAll('.diagram-slot');
        let correct = 0;

        slots.forEach((slot, index) => {
            if (slot.children.length > 0 && slot.children[0].dataset.component === architectureComponents[index]) {
                correct++;
            }
        });

        score = correct;
        updateScore();

        if (score === architectureComponents.length) {
            endGame();
        }
    }

    function updateScore() {
        const scoreElement = document.getElementById('architecture-puzzle-score');
        scoreElement.textContent = `Score: ${score}`;
    }

    function updateTimer() {
        const timerElement = document.getElementById('architecture-puzzle-timer');
        timerElement.textContent = `Time: ${timeLeft}s`;
    }

    function endGame() {
        clearInterval(puzzleInterval);
        game.innerHTML = `<h3>Game Over!</h3><p>Your final score: ${score}</p>`;
        const gameCompletedEvent = new CustomEvent('gameCompleted', {
            detail: { score: score, time: 60 - timeLeft }
        });
        document.dispatchEvent(gameCompletedEvent);
        gameStarted = false;
    }

    // Countdown before game starts
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

    // Start the game
    function startGame() {
        if (gameStarted) return;
        gameStarted = true;

        // Initialize score and timer
        score = 0;
        timeLeft = 60;
        updateScore();
        updateTimer();

        createPuzzle();

        puzzleInterval = setInterval(() => {
            timeLeft--;
            updateTimer();
            if (timeLeft <= 0) {
                clearInterval(puzzleInterval);
                endGame();
            }
        }, 1000);
    }

    // Event listener to start the game
    const startButton = document.getElementById('start-puzzle');
    startButton.addEventListener('click', startCountdown);
}
