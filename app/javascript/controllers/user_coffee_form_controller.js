import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-coffee-form"
export default class extends Controller {
  static targets = ['coffeeForm', 'weight']

  connect() {
    console.log(this.weightTarget)
  }

  toggleCoffeeFormVisibility(event) {
    if (event.currentTarget.value !== ''){
      this.coffeeFormTarget.classList.add('d-none')
    } else {
      this.coffeeFormTarget.classList.remove("d-none");
    }
  }

  changeWeight(event){
    console.log('HAHAHHAHAH')
    console.log(this.weightTarget.value)
    event.preventDefault()
    this.weightTarget.setAttribute(
      "value",
      parseInt(event.currentTarget.value) + parseInt(this.weightTarget.value)
    );

  }
}
