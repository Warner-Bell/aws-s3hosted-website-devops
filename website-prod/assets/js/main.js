// Smooth Scroll to Sections
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        document.querySelector(this.getAttribute('href')).scrollIntoView({
            behavior: 'smooth',
            block: 'start'
        });
    });
});

// Basic Form Validation with Feedback
document.querySelector('form').addEventListener('submit', function(event) {
    const name = document.getElementById('name').value.trim();
    const email = document.getElementById('email').value.trim();
    const message = document.getElementById('message').value.trim();

    let validationErrors = [];

    if (!name) {
        validationErrors.push('Name is required.');
    }

    if (!email || !validateEmail(email)) {
        validationErrors.push('A valid email is required.');
    }

    if (!message) {
        validationErrors.push('Message cannot be empty.');
    }

    if (validationErrors.length > 0) {
        alert('Please address the following issues:\n' + validationErrors.join('\n'));
        event.preventDefault();
    } else {
        alert('Message sent successfully! Builder Dave will respond soon.');
    }
});

// Email validation function
function validateEmail(email) {
    const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@(([^<>()\[\]\\.,;:\s@"]+\.)+[^<>()\[\]\\.,;:\s@"]{2,})$/i;
    return re.test(String(email).toLowerCase());
}
