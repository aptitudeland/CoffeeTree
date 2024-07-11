import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    flatpickr(this.element, {dateFormat: 'd-m-Y'});
  }
}
