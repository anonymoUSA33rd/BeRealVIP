// Function to close the UI
function closeUI() {
    fetch(`https://${GetParentResourceName()}/closeUI`, { method: 'POST' });
}

// Close button listener
document.getElementById('close-button').addEventListener('click', closeUI);

// ESC key listener
document.addEventListener('keydown', function(event) {
    if (event.key === "Escape") closeUI();
});

// Listen for data from the client
window.addEventListener('message', function(event) {
    const data = event.data;
    if (data.type === 'openUI') {
        const sections = data.sections;
        const sectionsContainer = document.getElementById('sections');
        sectionsContainer.innerHTML = ''; // Clear previous sections

        // Generate sections dynamically
        sections.forEach(section => {
            const sectionElement = document.createElement('div');
            sectionElement.classList.add('section');
            sectionElement.innerHTML = `<h2>${section.label}</h2>`;

            // Generate buttons for each vehicle
            section.vehicles.forEach(vehicle => {
                const vehicleButton = document.createElement('button');
                vehicleButton.innerHTML = vehicle;
                vehicleButton.onclick = function() {
                    fetch(`https://${GetParentResourceName()}/spawnVehicle`, {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ vehicleModel: vehicle, sectionId: section.id })
                    });
                };
                sectionElement.appendChild(vehicleButton);
            });

            sectionsContainer.appendChild(sectionElement);
        });
    }
});
