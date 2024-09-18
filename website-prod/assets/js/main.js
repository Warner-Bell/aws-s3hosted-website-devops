// Toggle menu visibility for mobile
document.getElementById('menu-toggle').addEventListener('click', function() {
    const menu = document.getElementById('menu');
    menu.classList.toggle('show');
});

// Form validation for contact form
document.querySelector('form').addEventListener('submit', function(event) {
    const name = document.getElementById('name').value;
    const email = document.getElementById('email').value;
    const message = document.getElementById('message').value;

    if (name === "" || email === "" || message === "") {
        alert("All fields are required!");
        event.preventDefault();
    } else if (!validateEmail(email)) {
        alert("Please enter a valid email address!");
        event.preventDefault();
    }
});

function validateEmail(email) {
    const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
}

// Lightbox functionality
document.querySelectorAll('.gallery-img').forEach(img => {
    img.addEventListener('click', function() {
        const lightbox = document.getElementById('lightbox');
        const lightboxImg = document.getElementById('lightbox-img');
        lightbox.style.display = "block";
        lightboxImg.src = this.src;
        lightbox.setAttribute('aria-hidden', 'false');
    });
});

document.querySelector('.close').addEventListener('click', function() {
    const lightbox = document.getElementById('lightbox');
    lightbox.style.display = "none";
    lightbox.setAttribute('aria-hidden', 'true');
});

// Testimonial slider functionality
let currentSlide = 0;
const slides = document.querySelectorAll('.testimonial-slide');
const prevButton = document.getElementById('prev-slide');
const nextButton = document.getElementById('next-slide');
let sliderInterval;

function showSlide(index) {
}

function prevSlide() {
    currentSlide = (currentSlide - 1 + slides.length) % slides.length;
    showSlide(currentSlide);
}

function nextSlide() {
    currentSlide = (currentSlide + 1) % slides.length;
    showSlide(currentSlide);
}

document.addEventListener('DOMContentLoaded', function() {
    showSlide(currentSlide);

    prevButton.addEventListener('click', prevSlide);
    nextButton.addEventListener('click', nextSlide);

    // Auto slide every 5 seconds
    sliderInterval = setInterval(nextSlide, 5000);
});

// Pause slider on hover
slides.forEach(slide => {
    slide.addEventListener('mouseover', function() {
        clearInterval(sliderInterval);
    });

    slide.addEventListener('mouseout', function() {
        sliderInterval = setInterval(nextSlide, 5000);
    });
});

// Back-to-top button functionality
const backToTop = document.querySelector('.back-to-top');


backToTop.addEventListener('click', function(e) {
    e.preventDefault();
    window.scrollTo({ top: 0, behavior: 'smooth' });
});

// Dark mode toggle functionality
const darkModeSwitch = document.getElementById('dark-mode-switch');
if (darkModeSwitch) {
    darkModeSwitch.addEventListener('change', function() {
        document.body.classList.toggle('dark-mode');
    });
}

// Build Your Cloud Mini-Game
const components = document.querySelectorAll('.cloud-component');
const dropzone = document.querySelector('.cloud-dropzone');

components.forEach(component => {
    component.addEventListener('dragstart', dragStart);
    component.addEventListener('dragend', dragEnd);
});

dropzone.addEventListener('dragover', dragOver);
dropzone.addEventListener('drop', dropItem);

function dragStart(event) {
    event.dataTransfer.setData('text/plain', event.target.id);
    setTimeout(() => {
        event.target.style.display = 'none';
    }, 0);
}

function dragEnd(event) {
    event.target.style.display = 'block';
}

function dragOver(event) {
    event.preventDefault();
    event.target.style.borderColor = '#4682b4';
}

function dropItem(event) {
    event.preventDefault();
    const id = event.dataTransfer.getData('text/plain');
    const component = document.getElementById(id);
    event.target.appendChild(component.cloneNode(true));
    event.target.style.borderColor = '#87ceeb';
    const promptText = event.target.querySelector('p');
    if (promptText) {
        promptText.style.display = 'none';
    }
}


const counter = document.querySelector(".counter-number");

async function updateCounter() {
  try {
    const response = await fetch("https://xjieaidaaocbryn7b2vmo63ir40nahpy.lambda-url.us-east-1.on.aws/");
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const data = await response.json();
    
    // Assuming the API returns an object with a 'views' property
    // If it returns just the number, use 'data' directly instead of 'data.views'
    const views = typeof data === 'object' ? data.views : data;
    
    counter.innerHTML = `<b>Visits</b> = ${views} ✌🏽`;
    console.log('View count updated:', views);
  } catch (error) {
    console.error("Failed to update counter:", error);
    counter.innerHTML = "<b>Visits</b> = --";
  }
}

// Update counter when DOM is fully loaded
document.addEventListener('DOMContentLoaded', () => {
  updateCounter();
  
  // Your existing scroll animation code
  const scroller = document.querySelector('.certifications-list');
  const speed = 50; // Change this value to adjust scroll speed (seconds)
  
  if (scroller) {
    scroller.style.animationDuration = `${speed}s`;
  }
});

// Optionally, update the counter periodically
// setInterval(updateCounter, 300000); // Uncomment to update every 5 minutes
