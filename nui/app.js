window.addEventListener('message', function(event) {
  let data = event.data;
  if (data.type === 'openUI') {
    let sections = data.sections;
    let sectionsContainer = document.getElementById('sections');
    sectionsContainer.innerHTML = ''; // Clear previous sections
    
    // Dynamically generate the vehicle sections and list the vehicles
    sections.forEach(section => {
      let sectionElement = document.createElement('div');
      sectionElement.innerHTML = `<h2>${section.label}</h2>`;
      
      section.vehicles.forEach(vehicle => {
        let vehicleButton = document.createElement('button');
        vehicleButton.innerHTML = vehicle;
        vehicleButton.onclick = function() {
          // Request the server to spawn the selected vehicle
          fetch(`https://${GetParentResourceName()}/spawnVehicle`, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({ vehicleModel: vehicle, sectionId: section.id }),
          });
        };
        sectionElement.appendChild(vehicleButton);
      });

      sectionsContainer.appendChild(sectionElement);
    });
  }
});

// Event listener to close the UI
document.addEventListener('keydown', function(event) {
  if (event.key === "Escape") {
    fetch(`https://${GetParentResourceName()}/closeUI`, { method: 'POST' });
  }
});
