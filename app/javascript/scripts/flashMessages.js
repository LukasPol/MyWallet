import Toastify from 'toastify-js';

document.addEventListener('turbo:load', function() {
  const backgroundColors = {
    alert: "#f44336",
    error: "#f44336",
    notice: "#009688"
  }
console.log('asdas')
  JSON.parse(document.body.dataset.flashMessages).forEach(flashMessage => {
    const [type, msg] = flashMessage;

    Toastify({
      text: msg,
      duration: 3000,
      close: true,
      backgroundColor: backgroundColors[type],
      stopOnFocus: true
    }).showToast();
  });
});