import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "accessoryType", "grinderField", "accessoryImage",
    "brewingMethods", "otherAccessories", "buttonGroup",
    "name", "brewingButton", "otherButton", "namefield",
    "grinderMaxInput", "commentsField", "createButton"
  ];

  connect() {
    this.toggleGrinderField();
  }

  toggleGrinderField() {
    if (this.accessoryTypeTarget.value === 'Grinder') {
      this.grinderFieldTargets.forEach(field => field.style.display = 'flex');
    } else {
      this.grinderFieldTargets.forEach(field => field.style.display = 'none');
    }
  }

  select(event) {
    const selectedType = event.currentTarget.dataset.type;
    this.accessoryTypeTarget.value = selectedType;

    // Ensure only one image is selected at a time
    this.accessoryImageTargets.forEach(img => img.classList.remove("selected"));
    event.currentTarget.classList.add("selected");

    // Set the name field value
    this.nameTarget.value = `My ${selectedType}`;
    this.toggleGrinderField();

    // Show the name and comments fields
    this.namefieldTarget.style.display = 'block';
    this.commentsFieldTarget.style.display = 'block';
  }

  showBrewingMethods() {
    this.otherAccessoriesTarget.style.display = 'none';
    this.otherButtonTarget.classList.remove("selected");
    this.brewingButtonTarget.classList.add("selected");
    this.brewingMethodsTarget.style.display = 'block';
    this.displayFields();
    this.brewingMethodsTarget.scrollIntoView({ behavior: 'smooth', inline: "nearest" });
  }

  showOtherAccessories() {
    this.brewingMethodsTarget.style.display = 'none';
    this.brewingButtonTarget.classList.remove("selected");
    this.otherButtonTarget.classList.add("selected");
    this.otherAccessoriesTarget.style.display = 'block';
    this.displayFields();
    this.otherAccessoriesTarget.scrollIntoView({ behavior: 'smooth', inline: "nearest" });
  }

  toggleAccessoryTypeSelection() {
    const accessoryTypeSelection = document.getElementById('accessory-type-selection');
    accessoryTypeSelection.style.display = accessoryTypeSelection.style.display === 'none' ? 'block' : 'none';
  }

  displayFields() {
    this.nameTarget.value = '';
    this.namefieldTarget.style.display = 'block';
    this.commentsFieldTarget.style.display = 'block';
    this.createButtonTarget.style.display = 'block';
  }

  incrementMax() {
    const maxValue = parseInt(this.grinderMaxInputTarget.value) || 0;
    this.grinderMaxInputTarget.value = maxValue + 1;
  }

  decrementMax() {
    const maxValue = parseInt(this.grinderMaxInputTarget.value) || 0;
    if (maxValue > 0) {
      this.grinderMaxInputTarget.value = maxValue - 1;
    }
  }
}
