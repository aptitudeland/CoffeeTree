import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "accessoryType", "grinderFields", "accessoryImage",
    "brewingMethods", "otherAccessories", "buttonGroup",
    "name", "brewingButton", "otherButton", "namefield",
    "grinderMinInput", "grinderMaxInput", "commentsField"
  ];

  connect() {
    this.toggleGrinderFields();
  }

  toggleGrinderFields() {
    if (this.accessoryTypeTarget.value === 'Grinder') {
      this.grinderFieldsTargets.forEach(field => field.style.display = 'block');
    } else {
      this.grinderFieldsTargets.forEach(field => field.style.display = 'none');
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
    this.toggleGrinderFields();

    // Show the name and comments fields
    this.namefieldTarget.style.display = 'block';
    this.commentsFieldTarget.style.display = 'block';
  }

  showBrewingMethods(event) {
    this.brewingMethodsTarget.style.display = 'block';
    this.otherAccessoriesTarget.style.display = 'none';
    this.namefieldTarget.style.display = 'block';
    this.commentsFieldTarget.style.display = 'block';
    this.nameTarget.value = '';
    this.scrollToBrewingMethods(event);

    // Deselect other accessory button
    this.otherButtonTarget.classList.remove("selected");

    // Add "selected" class to brewing button
    this.brewingButtonTarget.classList.add("selected");
  }

  showOtherAccessories(event) {
    this.brewingMethodsTarget.style.display = 'none';
    this.otherAccessoriesTarget.style.display = 'block';
    this.namefieldTarget.style.display = 'block';
    this.commentsFieldTarget.style.display = 'block';
    this.nameTarget.value = '';
    this.scrollToOtherAccessories(event);

    // Deselect brewing method button
    this.brewingButtonTarget.classList.remove("selected");

    // Add "selected" class to other button
    this.otherButtonTarget.classList.add("selected");
  }

  scrollToBrewingMethods(event) {
    this.brewingMethodsTarget.querySelector("h3").scrollIntoView({ behavior: 'smooth', block: 'start' });
  }

  scrollToOtherAccessories(event) {
    this.otherAccessoriesTarget.querySelector("h3").scrollIntoView({ behavior: 'smooth', block: 'start' });
  }

  incrementMin(event) {
    const minValue = parseInt(this.grinderMinInputTarget.value) || 0;
    this.grinderMinInputTarget.value = minValue + 1;
  }

  decrementMin(event) {
    const minValue = parseInt(this.grinderMinInputTarget.value) || 0;
    if (minValue > 0) {
      this.grinderMinInputTarget.value = minValue - 1;
    }
  }

  incrementMax(event) {
    const maxValue = parseInt(this.grinderMaxInputTarget.value) || 0;
    this.grinderMaxInputTarget.value = maxValue + 1;
  }

  decrementMax(event) {
    const maxValue = parseInt(this.grinderMaxInputTarget.value) || 0;
    if (maxValue > 0) {
      this.grinderMaxInputTarget.value = maxValue - 1;
    }
  }
}
