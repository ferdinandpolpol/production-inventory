document.addEventListener("DOMContentLoaded", function () {
    console.log("loaded")
    // Get all submit buttons on the page
    // var submitButtons = document.querySelectorAll('input[type="submit"], button[type="submit"]');

    // // Add an event listener to each button
    // submitButtons.forEach(function (button) {
    //     button.addEventListener('click', function (event) {
    //         // Prevent the form from submitting
    //         event.preventDefault();

    //         // Get all input and select fields on the page
    //         var inputs = document.querySelectorAll('input, select');
    //         console.log('inputs', inputs)
    //         // Clear the value of each field
    //         inputs.forEach(function (input) {
    //             input.value = '';
    //         });
    //     });
    // });

    document.querySelectorAll('input[type=number]').forEach((input) => {
        input.addEventListener("click", (e) => {
            console.log("click number")
            e.preventDefault()

            e.target.value = ''
        })
    })
});