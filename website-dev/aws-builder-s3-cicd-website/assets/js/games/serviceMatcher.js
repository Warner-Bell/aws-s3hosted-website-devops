export function startServiceMatcher() {
    const gameContainer = document.getElementById('service-matcher');
    gameContainer.innerHTML = `
        <h3>AWS Service Matcher</h3>
        <div id="service-matcher-game"></div>
        <div id="service-matcher-score">Score: 0</div>
        <div id="service-matcher-timer">Time: 30s</div>
        <button id="start-service-matcher" aria-label="Start AWS Service Matcher Game">Start Game</button>
    `;

    const game = document.getElementById('service-matcher-game');
    const services = [
        { name: 'S3', description: 'Object storage service' },
        { name: 'EC2', description: 'Virtual servers in the cloud' },
        { name: 'Lambda', description: 'Serverless compute service' },
        { name: 'DynamoDB', description: 'Managed NoSQL database' },
        { name: 'CloudFront', description: 'Content delivery network' }
    ];

    let score = 0;
    let timeLeft = 30;
    let matchInterval;
    let gameStarted = false;
    let selectedService = null;

    // Shuffle array function
    function shuffleArray(array) {
        for (let i = array.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [array[i], array[j]] = [array[j], array[i]];
        }
    }

    // Create the matching game layout
    function createMatchingGame() {
        const shuffledServices = [...services];
        shuffleArray(shuffledServices);

        let html = '<div class="service-names" role="list">';
        shuffledServices.forEach((service, index) => {
            html += `<div class="service-item" tabindex="0" data-index="${index}" role="listitem" aria-label="Service: ${service.name}">${service.name}</div>`;
        });
        html += '</div><div class="service-descriptions" role="list">';
        shuffleArray(shuffledServices);
        shuffledServices.forEach((service, index) => {
            html += `<div class="description-item" tabindex="0" data-index="${index}" role="listitem" aria-label="Description: ${service.description}">${service.description}</div>`;
        });
        html += '</div>';

        game.innerHTML = html;

        const serviceItems = game.querySelectorAll('.service-item');
        const descriptionItems = game.querySelectorAll('.description-item');

        // Event listener for selecting a service
        serviceItems.forEach(item => {
            item.addEventListener('click', () => selectService(item));
            item.addEventListener('keydown', (e) => {
                if (e.key === 'Enter' || e.key === ' ') selectService(item);
            });
        });

        // Event listener for selecting a description
        descriptionItems.forEach(item => {
            item.addEventListener('click', () => matchService(item));
            item.addEventListener('keydown', (e) => {
                if (e.key === 'Enter' || e.key === ' ') matchService(item);
            });
        });
    }

    function selectService(item) {
        if (selectedService) {
            selectedService.classList.remove('selected');
        }
        item.classList.add('selected');
        selectedService = item;
    }

    function matchService(descriptionItem) {
        if (!selectedService) return;

        if (selectedService.dataset.index === descriptionItem.dataset.index) {
            // Correct match
            score++;
            selectedService.style.visibility = 'hidden';
            descriptionItem.style.visibility = 'hidden';
            selectedService.classList.remove('selected');
            selectedService = null;
            updateScore();
            if (score === services.length) {
                endGame();
            }
        } else {
            // Incorrect match
            selectedService.classList.remove('selected');
            selectedService = null;
        }
    }

    function updateScore() {
        const scoreElement = document.getElementById('service-matcher-score');
        scoreElement.textContent = `Score: ${score}`;
    }

    function updateTimer() {
        const timerElement = document.getElementById('service-matcher-timer');
        timerElement.textContent = `Time: ${timeLeft}s`;
    }

    function endGame() {
        clearInterval(matchInterval);
        game.innerHTML = `<h3>Game Over!</h3><p>Your final score: ${score}</p>`;
        const gameCompletedEvent = new CustomEvent('gameCompleted', {
            detail: { score: score, time: 30 - timeLeft }
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

    function startGame() {
        if (gameStarted) return;
        gameStarted = true;

        // Initialize score and timer
        score = 0;
        timeLeft = 30;
        updateScore();
        updateTimer();

        createMatchingGame();

        matchInterval = setInterval(() => {
            timeLeft--;
            updateTimer();
            if (timeLeft <= 0) {
                clearInterval(matchInterval);
                endGame();
            }
        }, 1000);
    }

    // Event listener to start the game
    const startButton = document.getElementById('start-service-matcher');
    startButton.addEventListener('click', startCountdown);
}
