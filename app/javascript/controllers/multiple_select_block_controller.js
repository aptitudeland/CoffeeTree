import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="multiple-select-block"
export default class extends Controller {
  static targets = ['inputs', 'varietiesFilter']

  connect() {
    this.filterItems()
  }

  filterItems() {
    this.inputsTargets.forEach((input) => {
      if (input.checked) {
        input.parentElement.style.display = 'inline-block'
      } else if (
        this.varietiesFilterTarget.value != "" &&
        input.labels[0].innerText
          .toLowerCase()
          .startsWith(this.varietiesFilterTarget.value.toLowerCase())
      ) {
        input.parentElement.style.display = "inline-block";
      } else {
        input.parentElement.style.display = "none";
      }
    })
    this.element.style.display = 'none'
    this.element.style.display = "block";
  }
}
