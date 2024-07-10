export function initAccessoryForm() {
  document.addEventListener('turbo:load', () => {
    console.log("accessory_form.js loaded");

    const accessoryTypeImages = document.querySelectorAll('.accessory-option');
    const accessoryTypeSelect = document.getElementById('accessory_type_select');
    const accessoryDetails = document.getElementById('accessory_details');
    const accessoryName = document.getElementById('accessory_name');
    const grinderFields = document.getElementById('grinder_fields');
    const grinderMin = document.getElementById('accessory_grinder_min');
    const grinderMax = document.getElementById('accessory_grinder_max');

    accessoryTypeImages.forEach(image => {
      image.addEventListener('click', () => {
        const selectedType = image.getAttribute('data-type');
        accessoryTypeSelect.value = selectedType;

        // Highlight selected image
        accessoryTypeImages.forEach(img => img.querySelector('img').classList.remove('selected'));
        image.querySelector('img').classList.add('selected');

        // Log selection
        console.log("Selected accessory type: ", selectedType);

        // Show accessory details
        accessoryDetails.style.display = 'block';

        // Auto-fill name field
        accessoryName.value = `My ${selectedType}`;

        // Show or hide grinder fields and prefill values
        if (selectedType === 'Grinder') {
          grinderFields.classList.add('active');
          grinderMin.value = 0;
          grinderMax.value = 30;
        } else {
          grinderFields.classList.remove('active');
        }
      });
    });
  });
}
