// Password toggle functionality
function togglePassword(inputId) {
  const input = document.getElementById(inputId)
  const button = input.nextElementSibling
  const icon = button.querySelector(".eye-icon")

  if (input.type === "password") {
    input.type = "text"
    // Change to eye-off icon
    icon.innerHTML = `
            <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/>
            <line x1="1" y1="1" x2="23" y2="23"/>
        `
  } else {
    input.type = "password"
    // Change back to eye icon
    icon.innerHTML = `
            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
            <circle cx="12" cy="12" r="3"/>
        `
  }
}

// Form submission handlers (customize these for your Spring Boot backend)
document.addEventListener("DOMContentLoaded", () => {
  // Login form
  const loginForm = document.getElementById("loginForm")
  if (loginForm) {
    loginForm.addEventListener("submit", function (e) {
      e.preventDefault()
      const formData = new FormData(this)

      // Example: Send to Spring Boot login endpoint
      // fetch('/api/auth/login', {
      //     method: 'POST',
      //     headers: {
      //         'Content-Type': 'application/json',
      //     },
      //     body: JSON.stringify({
      //         email: formData.get('email'),
      //         password: formData.get('password'),
      //         remember: formData.get('remember') === 'on'
      //     })
      // })
      // .then(response => response.json())
      // .then(data => {
      //     if (data.success) {
      //         window.location.href = '/dashboard';
      //     } else {
      //         alert('Login failed: ' + data.message);
      //     }
      // });

      console.log("Login form submitted", Object.fromEntries(formData))
    })
  }

  // Register form
    //const registerForm = document.getElementById("registerForm")
    //if (registerForm) {
       // registerForm.addEventListener("submit", function (e) {
         //   e.preventDefault()
           // const formData = new FormData(this)

      // Validate password confirmation
      //const password = formData.get("password")
      //const confirmPassword = formData.get("confirmPassword")

      //if (password !== confirmPassword) {
        //alert("Passwords do not match")
        //return
      //}

      // Example: Send to Spring Boot register endpoint
      // fetch('/api/auth/register', {
      //     method: 'POST',
      //     headers: {
      //         'Content-Type': 'application/json',
      //     },
      //     body: JSON.stringify({
      //         name: formData.get('name'),
      //         email: formData.get('email'),
      //         password: formData.get('password')
      //     })
      // })
      // .then(response => response.json())
      // .then(data => {
      //     if (data.success) {
      //         alert('Registration successful! Please check your email.');
      //         window.location.href = '';
      //     } else {
      //         alert('Registration failed: ' + data.message);
      //     }
      // });

      //console.log("Register form submitted", Object.fromEntries(formData))
    //})
  //}

  // Forgot password form
  //const forgotForm = document.getElementById("forgotForm")
  //if (forgotForm) {
    //forgotForm.addEventListener("submit", function (e) {
      //e.preventDefault()
      //const formData = new FormData(this)

      // Example: Send to Spring Boot forgot password endpoint
      // fetch('/api/auth/forgot-password', {
      //     method: 'POST',
      //     headers: {
      //         'Content-Type': 'application/json',
      //     },
      //     body: JSON.stringify({
      //         email: formData.get('email')
      //     })
      // })
      // .then(response => response.json())
      // .then(data => {
      //     if (data.success) {
      //         alert('Reset link sent to your email!');
      //         window.location.href = '/';
      //     } else {
      //         alert('Failed to send reset link: ' + data.message);
      //     }
      // });

      //console.log("Forgot password form submitted", Object.fromEntries(formData))
    //})
  //}
})
